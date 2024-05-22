import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Auch!');
      },
      child: Center(
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              SizedBox(width: 8), // Añadir espacio entre el icono y el texto
              Text('Google')
            ]
        ),
      ),
    );
  }

  void main() {
    runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Botón de Google')),
        body: const Center(child: GoogleButton()),
      ),
    ));
  }
}