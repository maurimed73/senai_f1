import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:senai_f1/screens/gestao_projetos.dart';

import 'package:senai_f1/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthCheck(),
    );
  }
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return GestaoProjetos(); // Usuário autenticado, ir para a página inicial
          } else {
            return LoginPage(); // Usuário não autenticado, ir para a página de login
          }
        }
        return Center(
            child:
                CircularProgressIndicator()); // Esperando pelo estado de autenticação
      },
    );
  }
}
