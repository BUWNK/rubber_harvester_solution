import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rubberx/Login/login_screen.dart';
import 'package:rubberx/Signup/signup_screen.dart';
import 'package:rubberx/weather_dashboard.dart';
import 'package:rubberx/welcome.dart';

class AuthChanges extends StatelessWidget {
  const AuthChanges({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            return const Welcome();
          } else {
            return const Loginscreen();
          }
        }
      },
    );
  }
}