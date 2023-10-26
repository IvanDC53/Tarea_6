import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

class PaginaLogo extends StatefulWidget {
  @override
  _PaginaLogoState createState() => _PaginaLogoState();
}

class _PaginaLogoState extends State<PaginaLogo> {
  String logoUrl = 'https://listindiario.com/images/logo.png';// URL del logo del sitio web.
  List<Map<String, String>> noticias = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    final response = await http.get(Uri.parse('https://listindiario.com/'));
    if (response.statusCode == 200) {
      final document = htmlParser.parse(response.body);

      // Obtén el logo del sitio web. Reemplaza 'logo-selector' con el selector CSS adecuado.
      final logoElement = document.querySelector('.logo-selector');
      logoUrl = logoElement?.attributes['src'] ?? '';

      // Extrae las noticias. Ajusta los selectores según la estructura HTML del sitio web.
      final noticiasHtml = document.querySelectorAll('.noticia-selector').take(3); // Obtiene las primeras 3 noticias.

      for (final noticiaHtml in noticiasHtml) {
        final titulo = noticiaHtml.querySelector('.titulo-selector')?.text ?? 'Título no encontrado';
        final resumen = noticiaHtml.querySelector('.resumen-selector')?.text ?? 'Resumen no encontrado';
        final enlace = noticiaHtml.querySelector('.enlace-selector')?.attributes['href'] ?? '';

        noticias.add({'titulo': titulo, 'resumen': resumen, 'enlace': enlace});
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sitio web con WordPress'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(logoUrl),
            for (final noticia in noticias)
              ListTile(
                title: Text(noticia['titulo']!),
                subtitle: Text(noticia['resumen']!),
                onTap: () {
                  // Implementa la navegación a la noticia original utilizando noticia['enlace'].
                },
              ),
          ],
        ),
      ),
    );
  }
}
