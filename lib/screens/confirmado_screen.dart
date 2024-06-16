import 'package:flutter/material.dart';
import 'package:petratest/screens/auth/main_page.dart';

class ConfirmadoScreen extends StatefulWidget {
  const ConfirmadoScreen({super.key});

  @override
  State<ConfirmadoScreen> createState() => _ConfirmadoScreenState();
}

class _ConfirmadoScreenState extends State<ConfirmadoScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          'PETRA',
          style: TextStyle(
            fontFamily: 'TrajanPro',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '- Pedido Enviado -',
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            const Text(
              'Te llegara un correo confirmando la compra',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: screenWidth * 0.8,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const MainPage()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Volver al Inicio',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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