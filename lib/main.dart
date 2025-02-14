import 'package:flutter/material.dart';
import 'presentation/splash/pages/splash.dart';
import 'service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Funcionários',
      home: const SplashPage(),
    );
  }
}
