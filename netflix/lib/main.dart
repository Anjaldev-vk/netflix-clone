import 'package:flutter/material.dart';
import 'package:netflix/login_screen.dart';
import 'package:netflix/bottomNav.dart';
import 'package:netflix/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        '/home': (context) => const BottomNav(),
      },
    );
  }
}
