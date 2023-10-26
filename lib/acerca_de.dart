import 'package:flutter/material.dart';

class PaginaAcercaDe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Foto
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('src/ivan.jpg'), // Asegúrate de que la imagen esté en la carpeta "assets"
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Nombre
            Text(
              'Iván Francisco Del Castillo Gómez',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Número de teléfono
            Text(
              'Teléfono: 809-849-5956',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),

            // Correo electrónico
            Text(
              'Correo electrónico: ivan03557@gmail.com',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
