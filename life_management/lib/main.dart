import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_management/screens/sign_up_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Life Management',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 1, 54, 70),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 1, 54, 70),
          primary: const Color.fromARGB(255, 249, 182, 24),
          secondary: const Color.fromARGB(255, 245, 131, 31),
          tertiary: const Color.fromARGB(255, 31, 159, 188),
          background: const Color.fromARGB(255, 1, 54, 70),
          shadow: const Color.fromARGB(149, 46, 95, 110),
        ),
        unselectedWidgetColor: const Color.fromARGB(255, 255, 96, 128), // <-- your color

        useMaterial3: true,
      ),
      home: const SignUpScreen(),
    );
  }
}
