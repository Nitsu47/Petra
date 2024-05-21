import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Petra',
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
    title: const Text('Petra')
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Crear una cuenta'),
        Text('Ingresa tu email para registrarte en esta app'),
        // Llamado al botón de crear cuenta.
        Text('O inicia con'),
        // Botón de google.
        Text('Al presionar continuar, usted acepta nuestros terminos de servicio y políticas de privacidad')
      ]
    )
  );
}
