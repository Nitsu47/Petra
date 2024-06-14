import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  bool _obscureText = true;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();

    // Attach listeners to the text controllers to save data on change
    _nombreController.addListener(_saveData);
    _apellidoController.addListener(_saveData);
    _documentoController.addListener(_saveData);
    _sexoController.addListener(_saveData);
    _mailController.addListener(_saveData);
    _contraseniaController.addListener(_saveData);
    _telefonoController.addListener(_saveData);
    _tarjetaclubController.addListener(_saveData);
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _nombreController.dispose();
    _apellidoController.dispose();
    _documentoController.dispose();
    _sexoController.dispose();
    _mailController.dispose();
    _contraseniaController.dispose();
    _telefonoController.dispose();
    _tarjetaclubController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userId = user.uid;
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(_userId).get();

      if (userData.exists) {
        Map<String, dynamic>? data = userData.data() as Map<String, dynamic>?;
        if (data != null) {
          _nombreController.text = data['nombre'] ?? '';
          _apellidoController.text = data['apellido'] ?? '';
          _documentoController.text = data['documento'] ?? '';
          _sexoController.text = data['sexo'] ?? '';
          _mailController.text = data['mail'] ?? '';
          _contraseniaController.text = data['contrasenia'] ?? '';
          _telefonoController.text = data['telefono'] ?? '';
          _tarjetaclubController.text = data['tarjetaclub'] ?? '';
        }
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _saveData() async {
    if (_userId != null) {
      String nombre = _nombreController.text;
      String apellido = _apellidoController.text;
      String documento = _documentoController.text;
      String sexo = _sexoController.text;
      String mail = _mailController.text;
      String contrasena = _contraseniaController.text;
      String telefono = _telefonoController.text;
      String tarjetaclub = _tarjetaclubController.text;

      await FirebaseFirestore.instance.collection('users').doc(_userId).set({
        'nombre': nombre,
        'apellido': apellido,
        'documento': documento,
        'sexo': sexo,
        'mail': mail,
        'contrasenia': contrasena,
        'telefono': telefono,
        'tarjetaclub': tarjetaclub
      });

      // Optionally, show a snackbar or other feedback
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Data Saved Automatically'),
      ));
    }
  }

  Future<void> _changePassword() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(_contraseniaController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password Updated Successfully'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update password: $e'),
        ),
      );
    }
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
            const SizedBox(height: 16),
            const Text(
              'Contraseña',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              controller: _contraseniaController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Contraseña',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _changePassword,
                child: const Text('Cambiar Contraseña'),
              ),
            ),
            const SizedBox(height: 20),
        Center(
          child: ElevatedButton.icon(
            onPressed: FirebaseAuth.instance.signOut,
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
            const SizedBox(height: 70,)
          ],
        ),
      ),
    );
  }
}









