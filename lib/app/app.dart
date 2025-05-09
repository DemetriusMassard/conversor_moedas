import 'package:flutter/material.dart';

import 'home/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.dark(), useMaterial3: true),
      home: const HomePage(),
    );
  }
}
