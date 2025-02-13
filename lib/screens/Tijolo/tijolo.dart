// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:senai_f1/models/projeto_model.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:senai_f1/screens/sessao_das_areas/HomeScreen.dart';
import 'package:senai_f1/services/login_service.dart';
import 'package:senai_f1/utils/colors.dart';
import 'package:senai_f1/widgets/customDrawer.dart';

//import 'package:awesome_dialog/awesome_dialog.dart';

class Tijolo extends StatefulWidget {
  String campeonato;
  String banco;
  String titulo;
  // ServiceGestao service = ServiceGestao();

  Tijolo(
      {super.key,
      required this.campeonato,
      required this.banco,
      required this.titulo});

  @override
  State<Tijolo> createState() => _TijoloState();
}

class _TijoloState extends State<Tijolo> {
  ColorsDart colorDart = ColorsDart();
  AuthService serviceAuth = AuthService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int garrafasNecessarias = 0;
  int garrafasRecebidas = 0;
  int garrafasFaltantes = 0;
  String campeonato = "";
  String banco = "";

// Função que exibe o AlertDialog
  @override
  void initState() {
    numeroGarrasTerminadas();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<ProjetoModel> temp = [];
  void numeroGarrasTerminadas() async {
    temp = [];
    print('*******************************  COMEÇOU');
    print(
        'procurando no banco ${widget.banco} e campeonato ${widget.campeonato}');
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("${widget.banco}${widget.campeonato}").get();
    for (var doc in snapshot.docs) {
      temp.add(ProjetoModel.fromMap(doc.data()));
      // print(ProjetoModel.fromMap(doc.data()).status);
      if ((ProjetoModel.fromMap(doc.data()).status == Status.TERMINADA)) {
        garrafasRecebidas = garrafasRecebidas + 1;
      }
      garrafasNecessarias = temp.length;

      setState(() {
        garrafasNecessarias = temp.length;
        garrafasFaltantes = garrafasNecessarias - garrafasRecebidas;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final alturaGrafico = MediaQuery.of(context).size.height * 0.34;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        backgroundColor: colorDart.FundoApp,
        drawer: CustomDrawer(context: context),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 0, left: 1, right: 1),
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // AppBar
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.33,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: ColorsDart().VermelhoPadrao,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              height: MediaQuery.of(context).size.height * 0.18,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // VOLTAR
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: GestureDetector(
                                            onTap: () {
                                              HapticFeedback.lightImpact();
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: 40, // Largura da bola
                                              height: 35, // Altura da bola
                                              decoration: const BoxDecoration(
                                                color: Colors
                                                    .black, // Cor da bola (preto)
                                                shape: BoxShape
                                                    .circle, // Forma circular
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0),
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // LOGO CENTRAL
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.47,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.rectangle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/logo1.png'), // Substitua pelo caminho do seu logo
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // PERSON ICON
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            HapticFeedback.lightImpact();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Homescreen(),
                                                ));
                                          },
                                          child: Container(
                                            width: 40, // Largura da bola
                                            height: 35, // Altura da bola
                                            decoration: const BoxDecoration(
                                              color: Colors
                                                  .black, // Cor da bola (preto)
                                              shape: BoxShape
                                                  .circle, // Forma circular
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 0, left: 0, right: 0),
                                              child: Icon(
                                                Icons.home,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 265,
                                  child: Text(
                                    AppLocalizations.of(context)!.brick,
                                    style: TextStyle(
                                        height: 1.0,
                                        fontSize: 46,
                                        fontFamily: 'LeagueGothic',
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          Shadow(
                                            offset: const Offset(3.0,
                                                3.0), // Posição da sombra (horizontal, vertical)
                                            blurRadius:
                                                10.0, // A quantidade de desfoque da sombra
                                            color: Colors.black.withOpacity(
                                                0.7), // Cor da sombra
                                          ),
                                        ],
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: SizedBox(
                                    width: 265,
                                    child: Text(
                                      widget.titulo,
                                      style: const TextStyle(
                                          height: 1.0,
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 2, top: 10, right: 2, bottom: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.58,
                      width: MediaQuery.of(context).size.height * 0.98,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: colorDart.VermelhoPadrao.withAlpha(80),
                              width: 1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                '${AppLocalizations.of(context)!.bottles} ${AppLocalizations.of(context)!.missing}',
                                style: const TextStyle(
                                    height: 1.0,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Poppins'),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '$garrafasFaltantes  ${garrafasFaltantes <= 1 ? AppLocalizations.of(context)!.bottle : AppLocalizations.of(context)!.bottles}   ',
                                style: const TextStyle(
                                    height: 1.0,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.transparent,
                            height: (MediaQuery.of(context).size.height * 0.40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, top: 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.31,
                                    height:
                                        (MediaQuery.of(context).size.height *
                                            0.36),
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      'assets/tijolo2.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.36,
                                    height:
                                        (MediaQuery.of(context).size.height *
                                            0.38),
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          //LEGENDA
                                          LEGENDA(context, garrafasNecessarias),
                                          //GRÁFICO LEGENDA
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.34,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color:
                                                    colorDart.VermelhoPadrao),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          //DADOS
                                          garrafasNecessarias == 0
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : graficoLegenda(
                                                  totalMaxGarrafasLegenda:
                                                      garrafasNecessarias,
                                                  garrafas: garrafasRecebidas,
                                                  tamanhoFinalLegenda:
                                                      alturaGrafico,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Container LEGENDA(BuildContext context, garrafasNecessarias) {
  int totalItems = garrafasNecessarias;
  // Gerando a lista de números de 5 em 5 até o total de 'totalItems'
  List<int> numeros2 = List.generate(
    (totalItems ~/ 5) + 1, // Calculando o número de múltiplos de 5
    (i) => i * 5, // Gerando múltiplos de 5 (0, 5, 10, 15, etc.)
  );

  if (totalItems <= 10) {
    numeros2 = List.generate(
      (totalItems ~/ 1) + 1, // Calculando o número de múltiplos de 5
      (i) => i * 1, // Gerando múltiplos de 5 (0, 5, 10, 15, etc.)
    );
  }

  // Revertendo a lista para exibir do maior para o menor
  numeros2 = numeros2.reversed.toList();
  //Quebrando a lista em grupos de 5
  List<List<int>> grupos = [];
  for (int i = 0; i < numeros2.length; i += 5) {
    grupos.add(
        numeros2.sublist(i, i + 5 > numeros2.length ? numeros2.length : i + 5));
  }
  List<int> numeros = List.generate(30, (i) => 30 - i); // Lista de 10 a 1
  return Container(
    height: MediaQuery.of(context).size.height * 0.35,
    width: 20,
    color: Colors.transparent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: numeros2.map((numero) {
        return Container(
          color: numero % 2 == 0 ? Colors.transparent : Colors.transparent,
          height: 12.0,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 0, right: 4),
          child: Text(
            '$numero',
            style: const TextStyle(color: Colors.black, fontSize: 9),
            textAlign: TextAlign.end,
          ),
        );
      }).toList(),
    ),
  );
}

class graficoLegenda extends StatelessWidget {
  final int garrafas;
  final tamanhoFinalLegenda;
  final totalMaxGarrafasLegenda;
  const graficoLegenda({
    super.key,
    this.tamanhoFinalLegenda,
    required this.garrafas,
    this.totalMaxGarrafasLegenda,
  });

  // Função que determina a altura do container com base em x
  int calcularAltura(int x) {
    int result = ((tamanhoFinalLegenda * x) / totalMaxGarrafasLegenda).round();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    print('garrafas $garrafas');
    print('tamanho final $tamanhoFinalLegenda');
    return Container(
      height: calcularAltura(garrafas).toDouble(),
      width: 40,
      color: Colors.orange,
    );
  }
}
