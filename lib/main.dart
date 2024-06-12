import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petratest/screens/auth/main_page.dart';
import 'package:petratest/screens/profile_screen.dart';
import 'package:petratest/screens/splash.dart';
import 'package:provider/provider.dart';
import 'services/video_controller_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoControllerProvider()),
        // Add more providers if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
