// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:senai_f1/provider/provider_main.dart';
import 'package:senai_f1/screens/graficos/grafico.dart';
import 'package:senai_f1/screens/sessao_das_areas/HomeScreen.dart';
import 'package:senai_f1/services/login_service.dart';
import 'package:senai_f1/utils/colors.dart';
import 'package:senai_f1/widgets/customDrawer.dart';

//import 'package:awesome_dialog/awesome_dialog.dart';

class ReciclagemRegional extends StatefulWidget {
  final String banco;
  final String titulo;
  const ReciclagemRegional(
      {super.key, required this.banco, required this.titulo});

  @override
  State<ReciclagemRegional> createState() => _ReciclagemRegionalState();
}

class _ReciclagemRegionalState extends State<ReciclagemRegional> {
  ColorsDart colorDart = ColorsDart();
  AuthService serviceAuth = AuthService();

// Função que exibe o AlertDialog
  @override
  void initState() {
    //Provider.of<MainModel>(context, listen: false).fetchItems();
    // Carregar dados quando a página é inicializada
    // Future.delayed(Duration.zero, () {
    //   if (widget.titulo == 'Engenharia' || widget.titulo == 'Engineering') {
    //     Provider.of<MainModel>(context, listen: false)
    //         .carregarObjetosEngenhariaRegional();
    //   }
    //   if (widget.titulo == 'Gestão de Projetos' ||
    //       widget.titulo == 'Project Management') {
    //     Provider.of<MainModel>(context, listen: false)
    //         .carregarObjetosGestaoRegional();
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
// Acessa o provider, mas não estará escutando as mudanças automaticamente
    final meuObjetoProvider = Provider.of<MainModel>(context, listen: true);
    return Consumer(
      builder: (context, value, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          backgroundColor: colorDart.FundoApp,
          drawer: CustomDrawer(context: context),
          body: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 0, left: 1, right: 1),
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
                                padding: const EdgeInsets.only(top: 10),
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
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
                                                width: 35, // Largura da bola
                                                height: 45, // Altura da bola
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
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 265,
                                    child: Text(
                                      AppLocalizations.of(context)!.recycling,
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
                                          fontSize:
                                              larguraTela < 390 ? 30 : 40),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, right: 10),
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
                                mesGrafico(
                                  colorDart: colorDart,
                                  mes: AppLocalizations.of(context)!
                                      .may
                                      .toUpperCase(),
                                  larguraTela: larguraTela,
                                  campeonato: 'Regional',
                                  titulo: widget.titulo,
                                  banco: meuObjetoProvider.area,
                                ),
                                mesGrafico(
                                  colorDart: colorDart,
                                  mes: AppLocalizations.of(context)!
                                      .june
                                      .toUpperCase(),
                                  larguraTela: larguraTela,
                                  campeonato: 'Regional',
                                  titulo: widget.titulo,
                                  banco: meuObjetoProvider.area,
                                ),
                                mesGrafico(
                                  colorDart: colorDart,
                                  mes: AppLocalizations.of(context)!
                                      .july
                                      .toUpperCase(),
                                  larguraTela: larguraTela,
                                  campeonato: 'Regional',
                                  titulo: widget.titulo,
                                  banco: meuObjetoProvider.area,
                                ),
                                mesGrafico(
                                  colorDart: colorDart,
                                  mes: AppLocalizations.of(context)!
                                      .august
                                      .toUpperCase(),
                                  larguraTela: larguraTela,
                                  campeonato: 'Regional',
                                  titulo: widget.titulo,
                                  banco: meuObjetoProvider.area,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                mesGrafico(
                                  colorDart: colorDart,
                                  mes: AppLocalizations.of(context)!
                                      .september
                                      .toUpperCase(),
                                  larguraTela: larguraTela,
                                  campeonato: 'Regional',
                                  titulo: widget.titulo,
                                  banco: meuObjetoProvider.area,
                                ),
                                mesGrafico(
                                  colorDart: colorDart,
                                  mes: AppLocalizations.of(context)!
                                      .october
                                      .toUpperCase(),
                                  larguraTela: larguraTela,
                                  campeonato: 'Regional',
                                  titulo: widget.titulo,
                                  banco: meuObjetoProvider.area,
                                ),
                                mesGrafico(
                                  colorDart: colorDart,
                                  mes: AppLocalizations.of(context)!
                                      .november
                                      .toUpperCase(),
                                  larguraTela: larguraTela,
                                  campeonato: 'Regional',
                                  titulo: widget.titulo,
                                  banco: meuObjetoProvider.area,
                                ),
                                Container(
                                    height: 30,
                                    color: Colors.transparent,
                                    width: MediaQuery.of(context).size.width *
                                        0.21,
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
                                    backgroundColor: colorDart
                                        .VermelhoPadrao, // Cor do texto
                                    elevation: 5, // Sombra
                                    shape: RoundedRectangleBorder(
                                      // Forma do botão
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                      '${AppLocalizations.of(context)!.general}- ${widget.titulo}'
                                          .toUpperCase()),
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
                                    backgroundColor: colorDart
                                        .VermelhoPadrao, // Cor do texto
                                    elevation: 5, // Sombra
                                    shape: RoundedRectangleBorder(
                                      // Forma do botão
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                      '${AppLocalizations.of(context)!.general}- ${AppLocalizations.of(context)!.allareas}'
                                          .toUpperCase()),
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
  final double larguraTela;
  final String campeonato;
  final String titulo;
  final String banco;

  mesGrafico({
    super.key,
    required this.mes,
    required this.larguraTela,
    required this.colorDart,
    required this.campeonato,
    required this.titulo,
    required this.banco,
  });

  final ColorsDart colorDart;
  String converterMesParaNumero(String mes) {
    // Map com os meses em português e inglês
    Map<String, String> meses = {
      'JANEIRO': '01',
      'JANUARY': '01',
      'FEVEREIRO': '02',
      'FEBRUARY': '02',
      'MARÇO': '03',
      'MARCH': '03',
      'ABRIL': '04',
      'APRIL': '04',
      'MAIO': '05',
      'MAY': '05',
      'JUNHO': '06',
      'JUNE': '06',
      'JULHO': '07',
      'JULY': '07',
      'AGOSTO': '08',
      'AUGUST': '08',
      'SETEMBRO': '09',
      'SEPTEMBER': '09',
      'OUTUBRO': '10',
      'OCTOBER': '10',
      'NOVEMBRO': '11',
      'NOVEMBER': '11',
      'DEZEMBRO': '12',
      'DECEMBER': '12',
    };

    // Retorna o número do mês se encontrado no Map
    return meses[mes.toUpperCase()] ??
        'Mês inválido'; // Retorna 'Mês inválido' se não encontrar
  }

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

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => graficoPage(
                    titulo: titulo,
                    campeonato: campeonato,
                    mes: converterMesParaNumero(mes),
                    banco: banco,
                  ),
                ));
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
            style: TextStyle(fontSize: larguraTela < 390 ? 10 : 12),
          ),
        ),
      ),
    );
  }
}
