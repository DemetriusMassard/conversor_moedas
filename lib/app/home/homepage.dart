import 'package:conversor_moedas/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double usdConversion = 0;
  double eurConversion = 0;
  double audConversion = 0;
  double jpyConversion = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("\$ Conversor \$", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getConversionData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _buildLoadingScreen();
            default:
              if (snapshot.hasError) {
                return _buildErrorScreen();
              } else {
                usdConversion = snapshot.data['results']['currencies']['USD']['buy'];
                eurConversion = snapshot.data['results']['currencies']['EUR']['buy'];
                audConversion = snapshot.data['results']['currencies']['AUD']['buy'];
                jpyConversion = snapshot.data['results']['currencies']['JPY']['buy'];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      _buildBRLInput(),
                      _buildUSDInput(),
                      _buildEURInput(),
                      _buildAUDInput(),
                      _buildJPYInput(),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Text(
        "Erro ao carregar dados :(",
        style: TextStyle(color: Colors.amber, fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Text(
        "Carregando Dados...",
        style: TextStyle(color: Colors.amber, fontSize: 25),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBRLInput() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefix: Text("R\$ ", style: TextStyle(color: Colors.amber)),
        label: Text("Reais (BRL)", style: TextStyle(color: Colors.amber)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
    );
  }

  Widget _buildUSDInput() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefix: Text("\$ ", style: TextStyle(color: Colors.amber)),
        label: Text("Dólares (USD)", style: TextStyle(color: Colors.amber)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
    );
  }

  Widget _buildEURInput() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefix: Text("€ ", style: TextStyle(color: Colors.amber)),
        label: Text("Euro (EUR)", style: TextStyle(color: Colors.amber)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
    );
  }

  Widget _buildJPYInput() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefix: Text("¥ ", style: TextStyle(color: Colors.amber)),
        label: Text("Yen (JPY)", style: TextStyle(color: Colors.amber)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
    );
  }

  Widget _buildAUDInput() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefix: Text("AU\$ ", style: TextStyle(color: Colors.amber)),
        label: Text(
          "Dólares Australianos (AUD)",
          style: TextStyle(color: Colors.amber),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
      ),
    );
  }
}
