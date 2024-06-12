import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'email-already-in-use') {
          _errorMessage = 'Este mail ya esta en uso';
        } else if (e.code == 'invalid-email') {
          _errorMessage = 'Email invalido';
        } else if (e.code == 'weak-password') {
          _errorMessage = 'La contraseña es insegura';
        } else {
          _errorMessage = 'Ocurrio un error';
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
                    'Crear una cuenta',
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
                  // sign up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(child: Text(
                          'Crear Cuenta',
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
                  // already have an account? sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tienes cuenta?',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(' Ingresa',
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
