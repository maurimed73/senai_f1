// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:senai_f1/models/projeto_model.dart';
import 'package:senai_f1/screens/Empreendimento/reg_nac_mund_empreendimento.dart';
import 'package:senai_f1/screens/Engenharia/reg_nac_mund_engenharia.dart';
import 'package:senai_f1/screens/GestaoProjeto/reg_nac_gestao.dart';
import 'package:senai_f1/screens/TarefasGerais/reg_nac_mund_tarefasgerais.dart';
import 'package:senai_f1/services/login_service.dart';
import 'package:senai_f1/utils/colors.dart';
import 'package:senai_f1/widgets/customDrawer.dart';

class Homescreen extends StatefulWidget {
  void Function(Locale)? onLanguageChanged;

  Homescreen({
    super.key,
    this.onLanguageChanged,
  });

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  ColorsDart colorDart = ColorsDart();
  AuthService serviceAuth = AuthService();
 
// Função que exibe o AlertDialog
  @override
  void initState() {
    //Provider.of<MainModel>(context, listen: false).fetchItems();
   
    super.initState();
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

  // Criando o GlobalKey
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    print('Entrei na Sessão das Áreas');
    return PopScope(
      canPop: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          key: _scaffoldKey,
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
                                    // SRR
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, top: 10),
                                          child: Container(
                                            width: 75, // Largura da bola
                                            height: 35, // Altura da bola
                                            decoration: const BoxDecoration(
                                              color: Colors
                                                  .transparent, // Cor da bola (preto)
                                            ),
                                            child: Center(
                                                child: ColorFiltered(
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                      Colors.white,
                                                      BlendMode.srcIn),
                                              child: Image.asset(
                                                'assets/logo2.png',
                                                fit: BoxFit.cover,
                                              ),
                                            )),
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
                                          padding: const EdgeInsets.all(10),
                                          child: GestureDetector(
                                            onTap: () {
                                              HapticFeedback.lightImpact();
                                              // _scaffoldKey.currentState
                                              //     ?.openDrawer();
                                              
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
                                                  Icons.menu,
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
                                  AppLocalizations.of(context)!.titleSection,
                                  style: TextStyle(
                                      fontSize: larguraTela < 400 ? 46 : 52,
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
                          left: 12, top: 10, right: 12, bottom: 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.58,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: colorDart.VermelhoPadrao.withAlpha(80),
                                width: 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Sessao(
                                        corfundo: Colors.black,
                                        titulo: AppLocalizations.of(context)!
                                            .engineering,
                                        image: 'assets/icon_engenharia.png',
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const reg_nac_Engenharia(),
                                              ));
                                        }),
                                    Sessao(
                                      corfundo: colorDart.VermelhoPadrao,
                                      titulo: AppLocalizations.of(context)!
                                          .projectmanagement,
                                      image: 'assets/icon_gestaoprojeto.png',
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const reg_nac_Gestao(),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Sessao(
                                  corfundo: colorDart.VermelhoPadrao,
                                  titulo: AppLocalizations.of(context)!
                                      .generaltasks,
                                  image: 'assets/icon_tarefasgerais.png',
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const reg_nac_TarefasGerais(),
                                      )),
                                ),
                                Sessao(
                                  corfundo: Colors.black,
                                  titulo:
                                      AppLocalizations.of(context)!.enterprise,
                                  image: 'assets/icon_empreendimento.png',
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const reg_nac_Empreendimento(),
                                      )),
                                ),
                              ],
                            )
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
  String titulo;
  String image;
  final VoidCallback
      onPressed; // Função callback para quando o botão for pressionado

  Sessao({
    super.key,
    required this.corfundo,
    required this.titulo,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(2),

          // width:
          //     MediaQuery.of(context).size.width * 0.2, // Largura do Container
          // height:
          //     MediaQuery.of(context).size.height * 0.3, // Altura do Container
          decoration: BoxDecoration(
            color: corfundo,
            shape: BoxShape.circle, // Forma circular
            border: Border.all(
              color: Colors.black, // Cor da borda externa
              width: 1, // Largura da borda externa
            ),
          ),
          child: GestureDetector(
            onTap: () {
              onPressed();
              //onPressed;

              HapticFeedback.lightImpact(); // Vibração leve
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width *
                  0.29, // Largura interna (menor que a externa)
              height: MediaQuery.of(context).size.width *
                  0.29, // Altura interna (menor que a externa)
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
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 130,
          height: 50,
          color: Colors.transparent,
          child: Text(
            titulo,
            style: const TextStyle(
                fontFamily: 'Poppins', fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
