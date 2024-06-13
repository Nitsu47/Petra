import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to the next screen if login is successful
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'Usuario no encontrado.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'La contraseña es incorrecta.';
        } else {
          _errorMessage = 'El mail o la contraseña no coinciden.';
        }
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        title: const Text('PETRA',
            style: TextStyle(
              fontFamily: 'TrajanPro',
              fontWeight: FontWeight.bold,
              fontSize: 43,
            )
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Petra
              const Text(
                'Iniciar Sesion',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35
                ),
              ),
              const SizedBox(height: 15),
              // email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email@dominio.com',
                        hintStyle: GoogleFonts.inter(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Contraseña',
                        hintStyle: GoogleFonts.inter(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text(
                        'Ingresar',
                         style: GoogleFonts.inter(
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                         ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // error message
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    _errorMessage,
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 15),
              // not a member? register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No tienes cuenta?',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(' Registrate',
                      style: GoogleFonts.inter(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            
            ],
            ),
          ),
        ),
      )
    );
  }
}
