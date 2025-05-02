import 'package:flutter/material.dart';

import 'app/app.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

final request = Uri.https("api.hgbrasil.com", "/finance", {
  "format": "json",
  "key": "2be5c344",
  'fields': 'USD,EUR,CAD,AUD,JPY',
});

void main() {
  runApp(const MyApp());
}

Future<Map> getConversionData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body)['results'];
}
