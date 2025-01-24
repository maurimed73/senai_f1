// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senai_f1/services/auth_check.dart';
import 'package:senai_f1/services/login_service.dart';
import 'package:senai_f1/utils/colors.dart';
import 'package:senai_f1/widgets/customDrawer.dart';

//import 'package:awesome_dialog/awesome_dialog.dart';

class ReciclagemEngenharia extends StatefulWidget {
  // ServiceGestao service = ServiceGestao();

  ReciclagemEngenharia({super.key});

  @override
  State<ReciclagemEngenharia> createState() => _ReciclagemEngenhariaState();
}

class _ReciclagemEngenhariaState extends State<ReciclagemEngenharia> {
  ColorsDart colorDart = ColorsDart();
  AuthService serviceAuth = AuthService();

// Função que exibe o AlertDialog
  @override
  void initState() {
    //Provider.of<MainModel>(context, listen: false).fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorDart.FundoApp,
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 0, left: 1, right: 1),
        child: Center(
          child: Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // VOLTAR
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
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
                                                  bottom: 0, left: 0, right: 0),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            HapticFeedback.lightImpact();
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
                                                Icons.person,
                                                color: Colors.white,
                                              ),
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
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 265,
                                child: Text(
                                  'RECICLAGEM',
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(3.0,
                                              3.0), // Posição da sombra (horizontal, vertical)
                                          blurRadius:
                                              10.0, // A quantidade de desfoque da sombra
                                          // ignore: deprecated_member_use
                                          color: Colors.black.withOpacity(
                                              0.7), // Cor da sombra
                                        ),
                                      ],
                                      height: 1.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 40),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 5, right: 10),
                                child: SizedBox(
                                  width: 265,
                                  child: Text(
                                    'Engenharia',
                                    style: TextStyle(
                                        height: 1.0,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 16),
                                    textAlign: TextAlign.right,
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
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: colorDart.VermelhoPadrao.withAlpha(80),
                            width: 1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AnoWidget(
                          colorDart: colorDart,
                          ano: '2024',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            mesGrafico(colorDart: colorDart, mes: 'MAIO'),
                            mesGrafico(colorDart: colorDart, mes: 'JUNHO'),
                            mesGrafico(colorDart: colorDart, mes: 'JULHO'),
                            mesGrafico(colorDart: colorDart, mes: 'AGOSTO'),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            mesGrafico(colorDart: colorDart, mes: 'SETEMBRO'),
                            mesGrafico(colorDart: colorDart, mes: 'OUTUBRO'),
                            mesGrafico(colorDart: colorDart, mes: 'NOVEMBRO'),
                            Container(
                                height: 30,
                                color: Colors.transparent,
                                width: MediaQuery.of(context).size.width * 0.21,
                                child: null),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 0, bottom: 4),
                          child: SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                HapticFeedback.lightImpact();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    colorDart.VermelhoPadrao, // Cor do texto
                                elevation: 5, // Sombra
                                shape: RoundedRectangleBorder(
                                  // Forma do botão
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text('GERAL- GESTÃO DE PROJETOS'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                HapticFeedback.lightImpact();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    colorDart.VermelhoPadrao, // Cor do texto
                                elevation: 5, // Sombra
                                shape: RoundedRectangleBorder(
                                  // Forma do botão
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text('GERAL - TODAS AS ÁREAS'),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _grafico() {}
}

class AnoWidget extends StatelessWidget {
  final String ano;
  const AnoWidget({
    super.key,
    required this.colorDart,
    required this.ano,
  });

  final ColorsDart colorDart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 35,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: colorDart.VermelhoPadrao, // Cor do texto
            elevation: 5, // Sombra
            shape: RoundedRectangleBorder(
              // Forma do botão
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(ano),
        ),
      ),
    );
  }
}

class mesGrafico extends StatelessWidget {
  final String mes;
  const mesGrafico({
    super.key,
    required this.colorDart,
    required this.mes,
  });

  final ColorsDart colorDart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 30,
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width * 0.21,
        child: ElevatedButton(
          onPressed: () {
            HapticFeedback.lightImpact();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            foregroundColor: Colors.white,
            backgroundColor: colorDart.VermelhoPadrao, // Cor do texto
            elevation: 5, // Sombra
            shape: RoundedRectangleBorder(
              // Forma do botão
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            mes,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
