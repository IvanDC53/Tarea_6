import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaginaClima extends StatefulWidget {
  @override
  _PaginaClimaState createState() => _PaginaClimaState();
}

class _PaginaClimaState extends State<PaginaClima> {
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.weatherapi.com/v1/current.json?key=834cad77435b45f09fd14041232410&q=Santo%20Domingo',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weatherData = data;
        });
      } else {
        print('Error en la solicitud: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en República Dominicana'),
      ),
      body: Center(
        child: weatherData != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Clima en República Dominicana',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Ciudad: ${weatherData!['location']['name']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Temperatura: ${weatherData!['current']['temp_c']}°C',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Descripción: ${weatherData!['current']['condition']['text']}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        )
            : Text('Cargando el clima...'),
      ),
    );
  }
}
