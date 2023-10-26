import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaginaEdad extends StatefulWidget {
  @override
  _PaginaEdadState createState() => _PaginaEdadState();
}

class _PaginaEdadState extends State<PaginaEdad> {
  String nombre = '';
  int edad = 0;
  String estado = '';
  bool isLoading = false;

  Future<void> obtenerEdad(String nombre) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.agify.io/?name=$nombre'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      edad = data['age'];

      if (edad < 18) {
        estado = 'joven';
      } else if (edad < 65) {
        estado = 'adulto';
      } else {
        estado = 'anciano';
      }

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        estado = 'Desconocido';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edad'),
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
              textAlign: TextAlign.center,  // Centra el texto ingresado
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                obtenerEdad(nombre);
              },
              child: Text('Obtener Edad'),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : Column(
              children: [
                Text('Edad: $edad años'),
                Text('Estado: $estado'),
                if (estado == 'joven') Image.asset('src/joven.png', width: 200, height: 200),
                if (estado == 'adulto') Image.asset('src/adulto.png', width: 200, height: 200),
                if (estado == 'anciano') Image.asset('src/anciano.png', width: 200, height: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
