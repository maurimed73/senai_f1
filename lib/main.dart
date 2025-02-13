import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:senai_f1/firebase_options.dart';
import 'package:senai_f1/models/projeto_model.dart';
import 'package:senai_f1/provider/provider_main.dart';
import 'package:senai_f1/screens/sessao_das_areas/HomeScreen.dart';
import 'package:senai_f1/services/auth_check.dart';

//import 'package:flutter_localizations/flutter_localizations.dart';  // Importando as localizações

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Inicializa o Firebase

  // Força a tela para o modo retrato (portrait)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Retrato normal
    DeviceOrientation.portraitDown, // Retrato invertido (opcional)
  ]);

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MainModel(),
          )
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    buscarDados();
    super.initState();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<ProjetoModel> tempEngenhariaRegional = [];
  List<ProjetoModel> tempEngenhariaNacional = [];
  List<ProjetoModel> tempEngenhariaMundial = [];
  List<ProjetoModel> tempEmpreendimentoRegional = [];
  List<ProjetoModel> tempEmpreendimentoNacional = [];
  List<ProjetoModel> tempEmpreendimentoMundial = [];
  List<ProjetoModel> tempGestaoRegional = [];
  List<ProjetoModel> tempGestaoNacional = [];
  List<ProjetoModel> tempGestaoMundial = [];
  List<ProjetoModel> tempTarefasGeraisRegional = [];
  List<ProjetoModel> tempTarefasGeraisNacional = [];
  List<ProjetoModel> tempTarefasGeraisMundial = [];

  void buscarDados() async {
    tempEngenhariaRegional = await buscarDadosTema('TarefasEngenhariaRegional');
    tempEngenhariaNacional = await buscarDadosTema('TarefasEngenhariaNacional');
    tempEngenhariaMundial = await buscarDadosTema('TarefasEngenhariaMundial');
    tempEmpreendimentoRegional =
        await buscarDadosTema('TarefasEmpreendimentoRegional');
    tempEmpreendimentoNacional =
        await buscarDadosTema('TarefasEmpreendimentoNacional');
    tempEmpreendimentoMundial =
        await buscarDadosTema('TarefasEmpreendimentoMundial');
    tempGestaoRegional = await buscarDadosTema('TarefasGestaoRegional');
    tempGestaoNacional = await buscarDadosTema('TarefasGestaoNacional');
    tempGestaoMundial = await buscarDadosTema('TarefasGestaoMundial');
    tempTarefasGeraisRegional =
        await buscarDadosTema('TarefasTarefasGeraisRegional');
    tempTarefasGeraisNacional =
        await buscarDadosTema('TarefasTarefasGeraisNacional');
    tempTarefasGeraisMundial =
        await buscarDadosTema('TarefasTarefasGeraisMundial');
  }

  Future<List<ProjetoModel>> buscarDadosTema(String banco) async {
    List<ProjetoModel> temp = [];

    print('*******************************  COMEÇOU $banco');
    print('campeonato Regional');
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection(banco).get();
    for (var doc in snapshot.docs) {
      temp.add(ProjetoModel.fromMap(doc.data()));
    }
    print('*******************************  TERMINOU $banco');
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<MainModel>().locale;

    return MaterialApp(
      debugShowMaterialGrid: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale.fromSubtags(languageCode: languageProvider.languageCode),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // A rota inicial do aplicativo
      routes: {
        '/login': (context) => const AuthCheck(),
        //'/gestao': (context) => GestaoProjetos(),
        '/home': (context) => Homescreen()
      },
    );
  }
}
