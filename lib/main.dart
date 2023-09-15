import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rubberx/Components/myprovider.dart';
import 'package:rubberx/Login/login_screen.dart';
import 'package:rubberx/Signup/signup_screen.dart';
import 'package:rubberx/auth_state_changes.dart';
import 'package:rubberx/meter_dashboard.dart';
import 'package:rubberx/testdb.dart';
import 'package:rubberx/welcome.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), 
      child: MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  AuthChanges(),
    );
  }
}
