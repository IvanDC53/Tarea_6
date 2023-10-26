import 'package:flutter/material.dart';
import 'genero.dart'; // Importa tus vistas
import 'edad.dart';
import 'universidades.dart';
import 'clima.dart';
import 'logo.dart';
import 'acerca_de.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',  // Ruta inicial
      routes: {
        '/': (context) => PaginaInicio(),
        '/genero': (context) => PaginaGenero(),
        '/edad': (context) => PaginaEdad(),
        '/universidades': (context) => PaginaUniversidades(),
        '/clima': (context) => PaginaClima(),
        '/logo': (context) => PaginaLogo(),
        '/acerca_de': (context) => PaginaAcercaDe(),
      },
    );
  }
}

class PaginaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Genero'),
              onTap: () {
                Navigator.pushNamed(context, '/genero');
              },
            ),
            ListTile(
                leading: Icon(Icons.cake),
                title: Text('Edad'),
              onTap: () {
                Navigator.pushNamed(context, '/edad');
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Universidades'),
              onTap: () {
                Navigator.pushNamed(context, '/universidades');
              },
            ),
            ListTile(
              leading: Icon(Icons.wb_sunny),
              title: Text('Clima'),
              onTap: () {
                Navigator.pushNamed(context, '/clima');
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Logo'),
              onTap: () {
                Navigator.pushNamed(context, '/logo');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Acerca de'),
              onTap: () {
                Navigator.pushNamed(context, '/acerca_de');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          child: Image.asset('src/herramientas.jpg'),
        ),
      ),
    );
  }
}