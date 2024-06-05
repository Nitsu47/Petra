import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  // nombre y apellido con pincel para editar
  // correo
  // dirrecion de envio
  // cerrar sesion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ingreso correctamente ${user.email!}'),
                MaterialButton(
                  onPressed: FirebaseAuth.instance.signOut,
                  color: Colors.deepPurple,
                  child: const Text('Cerrar Sesion'),
                )
              ],
            )
        )
    );
  }
}