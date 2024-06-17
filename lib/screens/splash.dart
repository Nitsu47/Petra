import 'package:flutter/material.dart';
import 'package:petratest/screens/auth/main_page.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(const Duration(seconds: 2),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'PETRA',
          style: TextStyle(
            fontFamily: 'TrajanPro',
            fontWeight: FontWeight.bold,
            fontSize: 70,
          ),

        ),
      ),
    );
  }
}
