import 'package:firebase_core/firebase_core.dart';
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
    await Future.delayed(Duration(seconds: 1),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'PETRA',
            style: TextStyle(
              fontFamily: 'TrajanPro',
              fontWeight: FontWeight.bold,
              fontSize: 70,
            ),

          ),),
      ),
    );
  }
}
