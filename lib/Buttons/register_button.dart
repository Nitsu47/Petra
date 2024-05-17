import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Auch!');
      },
      child: const Center(
        child: Text('Registrarse con email')
      ),
    );
  }
}
