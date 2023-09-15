import 'package:flutter/material.dart';
import 'package:rubberx/welcomebody.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(child: WelcomeBody()),
    );
  }
}
