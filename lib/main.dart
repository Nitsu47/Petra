import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petratest/screens/home_screen.dart';
import 'package:petratest/models/bag.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyDpQ5_YanT4UZgpsWRZyEccOXoWyrE2lpM", appId: "1:457519054926:web:ff062545edf31b3a28831f", messagingSenderId: "457519054926", projectId: "petra-25468"))
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return const MaterialApp(
    title : 'Petra',
    home: HomeScreen(),
   );
  }
}
