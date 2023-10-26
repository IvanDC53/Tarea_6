import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaginaGenero extends StatefulWidget {
  @override
  _PaginaGeneroState createState() => _PaginaGeneroState();
}

class _PaginaGeneroState extends State<PaginaGenero> {
  String nombre = '';
  String genero = '';
  bool isLoading = false;

  Future<void> obtenerGenero(String nombre) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$nombre'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      genero = data['gender'];

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        genero = 'Desconocido';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genero'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Ingrese un nombre:'),
            TextField(
              onChanged: (value) {
                nombre = value;
              },
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                obtenerGenero(nombre);
              },
              child: Text('Obtener Género'),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : genero == 'female'
                ? Container(
              width: 100,
              height: 100,
              color: Colors.pink,
            )
                : genero == 'male'
                ? Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            )
                : Container(
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
