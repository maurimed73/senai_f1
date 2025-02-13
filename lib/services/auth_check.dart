import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:senai_f1/screens/sessao_das_areas/HomeScreen.dart';

import 'package:senai_f1/screens/Login/login.dart';
import 'package:senai_f1/widgets/customDrawer.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseAuth.instance.setLanguageCode('pt');
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const AuthCheck(),
//     );
//   }
// }

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Homescreen(); // Usuário autenticado, ir para a página inicial
        } else {
          return const LoginPage(); // Usuário não autenticado, ir para a página de login
        }
      },
    );
  }
}
