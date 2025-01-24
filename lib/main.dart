
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senai_f1/firebase_options.dart';

import 'package:senai_f1/provider/provider_main.dart';

import 'package:senai_f1/screens/sessao_das_areas/HomeScreen.dart';

import 'package:senai_f1/services/auth_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase
  runApp(
      ChangeNotifierProvider(create: (context) => MainModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        // Tema escuro
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey,
        ),
        // Adicione mais customizações se necessário
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // A rota inicial do aplicativo
      routes: {
        '/login': (context) => AuthCheck(),
        //'/gestao': (context) => GestaoProjetos(),
        '/home': (context) => Homescreen()
      },
    );
  }
}
