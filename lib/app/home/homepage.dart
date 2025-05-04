import 'package:conversor_moedas/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map> conversionData = getConversionData();

  double usdConversionRate = 0;
  double eurConversionRate = 0;
  double audConversionRate = 0;
  double jpyConversionRate = 0;

  int teste = 0;

  TextEditingController brlController = TextEditingController();
  TextEditingController usdController = TextEditingController();
  TextEditingController eurController = TextEditingController();
  TextEditingController audController = TextEditingController();
  TextEditingController jpyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Conversor de moedas",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: conversionData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _buildLoadingScreen();
            default:
              if (snapshot.hasError ||
                  snapshot.data == null ||
                  snapshot.data == []) {
                return _buildErrorScreen();
              } else {
                usdConversionRate = snapshot.data['currencies']['USD']['buy'];
                eurConversionRate = snapshot.data['currencies']['EUR']['buy'];
                audConversionRate = snapshot.data['currencies']['AUD']['buy'];
                jpyConversionRate = snapshot.data['currencies']['JPY']['buy'];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,
                        ),
                        _buildCurrencyTextField(
                          "Real (BRL)",
                          "R\$ ",
                          brlController,
                        ),
                        _buildCurrencyTextField(
                          "Dólar (USD)",
                          "US\$ ",
                          usdController,
                        ),
                        _buildCurrencyTextField(
                          "Euro (EUR)",
                          "€ ",
                          eurController,
                        ),
                        _buildCurrencyTextField(
                          "Dólar Australiano (AUD)",
                          "AU\$ ",
                          audController,
                        ),
                        _buildCurrencyTextField(
                          "Yen (JPY)",
                          "¥ ",
                          jpyController,
                        ),
                      ],
                    ),
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

  Widget _buildCurrencyTextField(
    String label,
    String prefix,
    TextEditingController controller,
  ) {
    return TextField(
      onChanged: (context) {
        _inputChanged(controller);
        setState(() {});
      },
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        errorText: validateNumericFields(controller.text),
        prefix: Text(prefix, style: TextStyle(color: Colors.amber)),
        label: Text(label, style: TextStyle(color: Colors.amber)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink),
        ),
      ),
    );
  }

  void _inputChanged(TextEditingController c) {
    double? convertedValue;

    //Convert the input value to BRL
    convertedValue = parseTextToDouble(c.text);
    if (convertedValue == null) {
      return;
    }

    if (c == usdController) {
      convertedValue = convertedValue * usdConversionRate;
    } else if (c == eurController) {
      convertedValue = convertedValue * eurConversionRate;
    } else if (c == audController) {
      convertedValue = convertedValue * audConversionRate;
    } else if (c == jpyController) {
      convertedValue = convertedValue * jpyConversionRate;
    }

    //Change the text of the unfocused inputs, according to the conversion rate
    if (c != brlController) {
      brlController.text = convertedValue.toStringAsFixed(2);
    }
    if (c != usdController) {
      usdController.text = (convertedValue / usdConversionRate).toStringAsFixed(
        2,
      );
    }
    if (c != eurController) {
      eurController.text = (convertedValue / eurConversionRate).toStringAsFixed(
        2,
      );
    }
    if (c != audController) {
      audController.text = (convertedValue / audConversionRate).toStringAsFixed(
        2,
      );
    }
    if (c != jpyController) {
      jpyController.text = (convertedValue / jpyConversionRate).toStringAsFixed(
        2,
      );
    }
  }

  String? validateNumericFields(String? value) {
    //Validator function
    if (value == null || value == "") {
      return null;
    }
    double? numericValue = parseTextToDouble(value);
    if (numericValue == null || numericValue.isNaN) {
      return "O valor deve ser numérico";
    } else {
      return null;
    }
  }

  double? parseTextToDouble(String? text) {
    //Parse function, so the user can use ',' an '.' as decimal separator
    double? parsedDouble = double.tryParse(text!.replaceAll(",", "."));
    return parsedDouble;
  }
}
