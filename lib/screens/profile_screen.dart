import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}
class _ProfileScreen extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
        _firstNameController.text = data?['firstName'] ?? '';
        _lastNameController.text = data?['lastName'] ?? '';
        _addressController.text = data?['address'] ?? '';
      }
    } catch (e) {
      // Handle error
      print('Error loading user data: $e');
    }
  }
  Future<void> _saveUserData() async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'address': _addressController.text,
        'email': user.email,
      });
    } catch (e) {
      // Handle error
      print("Error saving user data: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Dirección de envío'),
            ),
            const SizedBox(height: 20),
            Text('Correo: ${user.email!}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 40),
            Center(
              child: MaterialButton(
                onPressed: FirebaseAuth.instance.signOut,
                  color: Colors.deepPurple,
                  child: const Text('Cerrar Sesion', style: TextStyle(color: Colors.white)),
                )
              ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}