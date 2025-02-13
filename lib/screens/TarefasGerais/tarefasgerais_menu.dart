// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:senai_f1/provider/provider_main.dart';
import 'package:senai_f1/screens/TarefasGerais/campeonato/tarefasgerais_projetos.dart';
import 'package:senai_f1/screens/Reciclagem/campeonatos/reciclagem_mundial.dart';
import 'package:senai_f1/screens/Reciclagem/campeonatos/reciclagem_nacional.dart';
import 'package:senai_f1/screens/Reciclagem/campeonatos/reciclagem_regional.dart';
import 'package:senai_f1/screens/Tijolo/tijolo.dart';
import 'package:senai_f1/screens/sessao_das_areas/HomeScreen.dart';
import 'package:senai_f1/services/login_service.dart';
import 'package:senai_f1/utils/colors.dart';
import 'package:senai_f1/widgets/customDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

// ignore: camel_case_types
class TarefasGeraisMenu extends StatefulWidget {
  // ServiceGestao service = ServiceGestao();
  final String campeonato;
  const TarefasGeraisMenu({super.key, required this.campeonato});

  @override
  State<TarefasGeraisMenu> createState() => _TarefasGeraisMenuState();
}

// ignore: camel_case_types
class _TarefasGeraisMenuState extends State<TarefasGeraisMenu> {
  ColorsDart colorDart = ColorsDart();
  AuthService serviceAuth = AuthService();
  String banco = "";

// Função que exibe o AlertDialog
  @override
  void initState() {
    super.initState();
    // String banco = Provider.of<MainModel>(context, listen: false).area =
    //     'TarefasTarefasGerais';
  }

  // Função para mostrar o diálogo moderno
  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: colorDart.VermelhoPadrao,
                  size: 60,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Você tem certeza?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Deseja continuar com a ação?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha o diálogo
                      },
                      child: Text(
                        'Não',
                        style: TextStyle(
                          color: colorDart.VermelhoPadrao,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        //Fecha o aplicativo se o usuário clicar em "Sim"
                        serviceAuth.signOut();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(colorDart.VermelhoPadrao),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                      ),
                      child: const Text(
                        'Sim',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Atenção"),
          content: const Text("Deseja sair da sua conta"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Fecha o diálogo
              child: const Text("Não"),
            ),
            TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                serviceAuth.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double AlturaTela = MediaQuery.of(context).size.height;
    print('Entrando no menu TarefasGerais ${widget.campeonato}');
    return Consumer<MainModel>(
      builder: (context, provider, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          backgroundColor: colorDart.FundoApp,
          drawer: CustomDrawer(context: context),
          body: Padding(
            padding:
                const EdgeInsets.only(top: 32, bottom: 0, left: 1, right: 1),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(0),
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // VOLTAR
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            HapticFeedback
                                                .lightImpact(); // Vibração leve
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              width: 35, // Largura da bola
                                              height: 35, // Altura da bola
                                              decoration: const BoxDecoration(
                                                color: Colors
                                                    .black, // Cor da bola (preto)
                                                shape: BoxShape
                                                    .circle, // Forma circular
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons
                                                      .arrow_back, // Ícone de casa
                                                  color: Colors
                                                      .white, // Cor do ícone
                                                  size: 25, // Tamanho do ícone
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // LOGO CENTRAL
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06),
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
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0),
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
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(bottom: 0),
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                                color: Colors.transparent,
                                child: Text(
                                  AppLocalizations.of(context)!.generaltasks,
                                  style: TextStyle(
                                      fontSize: 52,
                                      fontFamily: 'LeagueGothic',
                                      fontWeight: FontWeight.w500,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(3.0,
                                              3.0), // Posição da sombra (horizontal, vertical)
                                          blurRadius:
                                              10.0, // A quantidade de desfoque da sombra
                                          color: Colors.black
                                              // ignore: deprecated_member_use
                                              .withOpacity(
                                                  0.7), // Cor da sombra
                                        ),
                                      ],
                                      color: Colors.white),
                                ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, right: 20, left: 20),
                              child: SizedBox(
                                height: AlturaTela < 600 ? 35 : 45,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Colors.black, // Cor do texto
                                    elevation: 5, // Sombra
                                    shape: RoundedRectangleBorder(
                                      // Forma do botão
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                    widget.campeonato == "Regional"
                                        ? AppLocalizations.of(context)!.regional
                                        : widget.campeonato == "Nacional"
                                            ? AppLocalizations.of(context)!
                                                .national
                                            : AppLocalizations.of(context)!
                                                .worldwide,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            //TAREFAS
                            Padding(
                              padding: EdgeInsets.only(
                                  top: AlturaTela < 600 ? 30 : 40,
                                  bottom: AlturaTela < 600 ? 10 : 20,
                                  left: 20,
                                  right: 20),
                              child: SizedBox(
                                height: AlturaTela < 600 ? 35 : 45,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    provider.area = "TarefasTarefasGerais";
                                    HapticFeedback.lightImpact();
                                    String campeonato = provider.campeonato;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TarefasGeraisProjetos(
                                                  context: context,
                                                  campeonato: campeonato),
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: colorDart
                                        .VermelhoPadrao, // Cor do texto
                                    elevation: 5, // Sombra
                                    shape: RoundedRectangleBorder(
                                      // Forma do botão
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.tasks,
                                    style: const TextStyle(fontSize: 26),
                                  ),
                                ),
                              ),
                            ),
                            //TIJOLO
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0,
                                  bottom: AlturaTela < 600 ? 10 : 20,
                                  left: 20,
                                  right: 20),
                              child: SizedBox(
                                height: AlturaTela < 600 ? 35 : 45,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    HapticFeedback.lightImpact();
                                    banco = provider.area;
                                    print('$banco  e  ${widget.campeonato}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Tijolo(
                                            titulo:
                                                AppLocalizations.of(context)!
                                                    .generaltasks,
                                            banco: banco,
                                            campeonato: widget.campeonato,
                                          ),
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Colors.white, // Cor do texto
                                    elevation: 5, // Sombra
                                    shape: RoundedRectangleBorder(
                                      // Forma do botão
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                      AppLocalizations.of(context)!.brick,
                                      style: const TextStyle(
                                          fontSize: 26, color: Colors.black)),
                                ),
                              ),
                            ),
                            //RECICLAGEM
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, bottom: 20, left: 20, right: 20),
                              child: SizedBox(
                                height: AlturaTela < 600 ? 35 : 45,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    HapticFeedback.lightImpact();
                                    widget.campeonato == "Regional"
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ReciclagemRegional(
                                                titulo: AppLocalizations.of(
                                                        context)!
                                                    .generaltasks,
                                                banco: banco,
                                              ),
                                            ))
                                        : widget.campeonato == "Nacional"
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReciclagemNacional(
                                                    titulo: AppLocalizations.of(
                                                            context)!
                                                        .generaltasks,
                                                    banco: banco,
                                                  ),
                                                ))
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReciclagemMundial(
                                                    titulo: AppLocalizations.of(
                                                            context)!
                                                        .generaltasks,
                                                    banco: banco,
                                                  ),
                                                ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: colorDart
                                        .VermelhoPadrao, // Cor do texto
                                    elevation: 5, // Sombra
                                    shape: RoundedRectangleBorder(
                                      // Forma do botão
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.recycling,
                                    style: const TextStyle(fontSize: 26),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 0, bottom: 20),
                              child: Sessao(
                                corfundo: Colors.black,
                                image: 'assets/icon_tarefasgerais.png',
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
      ),
    );
  }
}

class Sessao extends StatelessWidget {
  Color corfundo;
  String image;
  Sessao({
    super.key,
    required this.corfundo,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: corfundo,
              shape: BoxShape.circle, // Forma circular
              border: Border.all(
                color: Colors.black, // Cor da borda externa
                width: 1, // Largura da borda externa
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width *
                  0.25, // Largura interna (menor que a externa)
              height: MediaQuery.of(context).size.width *
                  0.25, // Altura interna (menor que a externa)
              decoration: BoxDecoration(
                color: corfundo,
                shape: BoxShape.circle, // Forma circular
                border: Border.all(
                  color: Colors.white, // Cor da borda interna
                  width: 1, // Largura da borda interna
                ),
              ),
              child: Padding(
                padding: image == 'assets/icon_tarefasgerais.png'
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(left: 0),
                child: Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  child: ColorFiltered(
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      child: Image.asset(
                        image,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
