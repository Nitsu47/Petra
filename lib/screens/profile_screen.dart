import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileScreen(),
    );
  }
}
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}
class _ProfileScreen extends State<ProfileScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();

  final TextEditingController _documentoController = TextEditingController();

  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  final TextEditingController _contraseniaController = TextEditingController();

  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _tarjetaclubController = TextEditingController();


  void _saveData() async {
    String nombre = _nombreController.text;
    String apellido = _apellidoController.text;
    String documento = _documentoController.text;
    String sexo = _sexoController.text;
    String mail = _mailController.text;
    String contrasena = _contraseniaController.text;
    String telefono = _telefonoController.text;
    String tarjetaclub = _tarjetaclubController.text;

    await FirebaseFirestore.instance.collection('users').add({
      'nombre': nombre,
      'apellido': apellido,
      'documento': documento,
      'sexo': sexo,
      'mail': mail,
      'contrasenia': contrasena,
      'telefono': telefono,
      'tarjetaclub': tarjetaclub
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Data Saved Successfully'),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text('PETRA',
            style: TextStyle(
              fontFamily: 'TrajanPro',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Nombre',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                hintText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Apellido',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              controller: _apellidoController,
              decoration: const InputDecoration(
                hintText: 'Apellido',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Documento',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              controller: _documentoController,
              decoration: const InputDecoration(
                hintText: 'Documento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Sexo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              controller: _sexoController,
              decoration: const InputDecoration(
                hintText: 'Sexo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Mail',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              controller: _mailController,
              decoration: const InputDecoration(
                hintText: '@gmail.com',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'telefono',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              controller: _telefonoController,
              decoration: const InputDecoration(
                hintText: 'Telefono',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tarjeta Club El Pais',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              controller: _tarjetaclubController,
              decoration: const InputDecoration(
                hintText: 'Tarjeta Club El Pais',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _saveData,
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar Sesión'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}









