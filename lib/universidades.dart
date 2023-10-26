import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';  // Importa url_launcher

class PaginaUniversidades extends StatefulWidget {
  @override
  _PaginaUniversidadesState createState() => _PaginaUniversidadesState();
}

class _PaginaUniversidadesState extends State<PaginaUniversidades> {
  String pais = '';
  List<dynamic> universidades = [];
  bool isLoading = false;

  Future<void> obtenerUniversidades(String pais) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$pais'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        universidades = data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        universidades = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Ingrese el nombre de un país en inglés:'),
            TextField(
              onChanged: (value) {
                pais = value;
              },
              textAlign: TextAlign.center,  // Centra el texto ingresado
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                obtenerUniversidades(pais);
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : universidades.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: universidades.length,
                itemBuilder: (context, index) {
                  final universidad = universidades[index];
                  final nombre = universidad['name'];
                  final dominios = universidad['domains'].join(", ");
                  final paginaWeb = universidad['web_pages'][0];
                  return ListTile(
                    title: Text(nombre),
                    subtitle: Text('Dominios: $dominios'),
                    trailing: Icon(Icons.link),
                    onTap: () async {  // Usa 'async' para 'launch'
                      await launch(paginaWeb);  // Usa 'await' para 'launch' y asegúrate de que 'paginaWeb' sea una URL válida
                    },
                  );
                },
              ),
            )
                : Text('No se encontraron universidades para el país ingresado.'),
          ],
        ),
      ),
    );
  }
}

