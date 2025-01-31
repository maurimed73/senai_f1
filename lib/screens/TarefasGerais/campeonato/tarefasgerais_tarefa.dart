// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:senai_f1/models/projeto_model.dart';
import 'package:senai_f1/provider/provider_main.dart';
import 'package:senai_f1/services/login_service.dart';
import 'package:senai_f1/utils/colors.dart';

class TarefasGeraisDetailPage extends StatefulWidget {
  ProjetoModel? projeto;
  TarefasGeraisDetailPage({super.key, this.projeto});

  @override
  State<TarefasGeraisDetailPage> createState() => _TarefasGeraisDetailPageState();
}

class _TarefasGeraisDetailPageState extends State<TarefasGeraisDetailPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool terminando = false;
  String campeonato = "";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      campeonato = Provider.of<MainModel>(context, listen: false).campeonato;
    });

    calcularDiferencaEmDias("", "");
    updateCountdown(); // Atualiza a contagem regressiva na inicialização
    // timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   updateCountdown(); // Atualiza a contagem a cada segundo
    // });
    super.initState();
  }

  void updateCountdown() {
    DateTime now = DateTime.now();
    final DateFormat formato = DateFormat('dd/MM/yyyy');

    futureDate = formato.parse(widget.projeto!.terminoEstimado);
    Duration difference = futureDate.difference(now);
    if (widget.projeto!.status == Status.TERMINADA) {
      print('**********************************************Deu certo');
      firestore
          .collection('TarefasTarefasGerais${campeonato}')
          .doc((widget.projeto!.id).toString())
          .update({'status': 'TERMINADA'});
      setState(() {
        widget.projeto!.status = Status.TERMINADA;
      });
    } else {
      setState(() {
        if (difference.isNegative) {
          // Se a data já passou, exibe "Atrasado"
          countdown = "Atrasado ${difference.inDays.abs()} dias";
          var status = Status.ATRASADA;
          firestore
              .collection('TarefasTarefasGerais${campeonato}')
              .doc((widget.projeto!.id).toString())
              .update({'status': status.toString().split('.').last});
        } else {
          // Caso contrário, mostra a contagem regressiva
          countdown = "${difference.inDays + 1} dias restantes";
          widget.projeto!.status = Status.ATIVO;
          if (difference.inDays + 1 < 4) {
            terminando = true;
          }
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  AuthService serviceAuth = AuthService();
  ColorsDart colorDart = ColorsDart();
  Icon diasIcon = const Icon(Icons.timer_sharp, size: 20, color: Colors.black);

  int diasDeDiferenca = 0;
  int calcularDiferencaEmDias(String data1, String data2) {
    if (data1 != "" && data2 != "") {
      // data1 = "01/01/2025";
      //data2 = "31/01/2025";
      // Define o formato de data brasileiro (DD/MM/YYYY)
      final DateFormat formato = DateFormat('dd/MM/yyyy');

      // Converte as strings em objetos DateTime
      DateTime data1Date = formato.parse(data1);
      DateTime data2Date = formato.parse(data2);

      // Calcula a diferença entre as datas
      Duration diferenca = data2Date.difference(data1Date);
      diasIcon = const Icon(
        Icons.timer_sharp,
        size: 20,
        color: Colors.black,
      );
      // Retorna a diferença em dias
      if (diferenca.inDays == 0) {
        return diferenca.inDays + 1;
      } else {
        return diferenca.inDays;
      }
    } else {
      diasIcon = const Icon(
        Icons.timer_sharp,
        size: 20,
        color: Colors.transparent,
      );
      return 0;
    }
  }

  DateTime futureDate = DateTime(2025, 1, 20);
  String countdown = '';

  String calcularQuantosDiasFaltam(String data1, String data2) {
    if (data1 != "" && data2 != "") {
      // data1 = "01/01/2025";
      //data2 = "31/01/2025";
      // Define o formato de data brasileiro (DD/MM/YYYY)
      final DateFormat formato = DateFormat('dd/MM/yyyy');

      futureDate = formato.parse(data2);
      DateTime now = DateTime.now();

      Duration difference = futureDate.difference(now);
      print('teste de calcular dias $difference');
      setState(() {
        if (difference.isNegative) {
          // Se a data já passou, exibe "Atrasado"
          countdown = "Atrasado ${difference.inDays.abs()} dias";
        } else {
          // Caso contrário, mostra a contagem regressiva
          countdown = "${difference.inDays} dias restantes";
        }
      });

      // Retorna a diferença em dias
      return countdown;
    } else {
      return "";
    }
  }

  String? resultInicioRealizado = "";
  String? resultTerminoRealizado = "";
  int? resultDuracaoDias = 0;
  String? resultResponsavel = "";
  String textFromDialog = "";

  // Variável para armazenar o valor retornado do Dialog
  Future<String?> _openDialog(
    BuildContext context,
    titulo,
    String responsavelTarefa,
  ) async {
    final String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return MyDialog(
          titulo: titulo,
          parametro: responsavelTarefa,
        ); // Passando o Dialog que vai permitir digitar algo
      },
    );

    if (result != null) {
      setState(() {
        textFromDialog = result; // Atualiza o estado com o valor digitado
      });
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;

    //INÍCIO
    return Scaffold(
      resizeToAvoidBottomInset: false, // Isso permite que o layout se ajuste
      backgroundColor: colorDart.FundoApp,
      body: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 0, left: 8, right: 8),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // AppBar
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorsDart().VermelhoPadrao,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 35, // Largura da bola
                              height: 35, // Altura da bola
                              decoration: const BoxDecoration(
                                color: Colors.black, // Cor da bola (preto)
                                shape: BoxShape.circle, // Forma circular
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back, // Ícone de casa
                                  color: Colors.white, // Cor do ícone
                                  size: 25, // Tamanho do ícone
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/logo1.png'), // Substitua pelo caminho do seu logo
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                            },
                            child: Container(
                              width: 40, // Largura da bola
                              height: 35, // Altura da bola
                              decoration: const BoxDecoration(
                                color: Colors.black, // Cor da bola (preto)
                                shape: BoxShape.circle, // Forma circular
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
                        ],
                      ),
                    )),
                // Dados da Página
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    elevation: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.62,
                      width: MediaQuery.of(context).size.width * 1,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ROW -> PRIMEIRO ELEMENTO GARRAFA
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, top: 10),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  height: (MediaQuery.of(context).size.height *
                                      0.24),
                                  color: Colors.transparent,
                                  child: Image.asset(
                                    widget.projeto!.status == Status.ATRASADA
                                        ? 'assets/garrafa_atrasada.png'
                                        : widget.projeto!.status ==
                                                Status.TERMINADA
                                            ? 'assets/garrafa_finalizada.png'
                                            : terminando
                                                ? 'assets/garrafa_terminando.png'
                                                : 'assets/garrafa_andamento.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),

                              // ROW -> SEGUNDO  ELEMENTO COLUNA COM NOME E DESCRIÇÃO DA TAREFA
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 0, top: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                width: MediaQuery.of(context).size.width * 0.75,
                                height:
                                    MediaQuery.of(context).size.height * 0.26,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // ************************************* NOME  *************************************************
                                      SizedBox(
                                        height: 40,
                                        //mudei
                                        child: Text(
                                          widget.projeto!.nome,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // ************************************* DESCRIÇÃO  *************************************************
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.17,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                widget.projeto!.descricao,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Poppins'),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // ************************************* INICIO ESTIMADO  *************************************************

                                      // **********************************************************************************************************
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // TERCEIRO ELEMENTO -> DADOS DA TAREFA
                          Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * 0.93,
                            height: MediaQuery.of(context).size.height * 0.32,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: colorDart.VermelhoPadrao)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      height: 25,
                                      child: const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Início Estimado:',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      height: 25,
                                      child: const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Início Realizado:',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      height: 25,
                                      child: const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Término Estimado:',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      height: 25,
                                      child: const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Término Realizado:',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      height: 25,
                                      child: const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Duração em Dias:',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      height: 25,
                                      child: const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Responsável:',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                // 2º COLUNA DOS
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    // INICIO ESTIMADO
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            4), // Aqui define-se o raio da borda
                                      ),
                                      elevation: 5, // Define a sombra do Card
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 25,
                                        width: 120,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 50,
                                              child: Text(
                                                widget.projeto!.inicioEstimado,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins'),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15),
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.transparent,
                                                child: Icon(
                                                  Icons.check,
                                                  size: 20,
                                                  color: widget.projeto!
                                                              .inicioEstimado ==
                                                          ""
                                                      ? Colors.transparent
                                                      : Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    //  INICIO REALIZADO
                                    GestureDetector(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              4), // Aqui define-se o raio da borda
                                        ),
                                        elevation: 5, // Define a sombra do Card
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          color: Colors.transparent,
                                          height: 23,
                                          width: 120,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: 100,
                                                height: 50,
                                                child: Text(
                                                  widget.projeto!.dataInicial,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'Poppins'),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 15),
                                                child: Container(
                                                  width: 10,
                                                  height: 10,
                                                  color: Colors.transparent,
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 20,
                                                    color: widget.projeto!
                                                                .dataInicial ==
                                                            ""
                                                        ? Colors.transparent
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        if (widget.projeto!.status !=
                                            Status.TERMINADA) {
                                          resultInicioRealizado =
                                              await _openDialog(
                                                  context,
                                                  "Inicio Realizado",
                                                  widget.projeto!.dataInicial);

                                          if (resultInicioRealizado != null) {
                                            widget.projeto!.dataInicial =
                                                resultInicioRealizado!;
                                            firestore
                                                .collection(
                                                    'TarefasTarefasGerais${campeonato}')
                                                .doc((widget.projeto!.id)
                                                    .toString())
                                                .update({
                                              'dataInicial':
                                                  widget.projeto!.dataInicial
                                            });
                                          }
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    //  TÉRMINO ESTIMADO
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            4), // Aqui define-se o raio da borda
                                      ),
                                      elevation: 5, // Define a sombra do Card
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 25,
                                        width: 120,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 25,
                                              child: Text(
                                                widget.projeto!.terminoEstimado,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins'),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15),
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                color: Colors.transparent,
                                                child: Icon(
                                                  Icons.check,
                                                  size: 20,
                                                  color: widget.projeto!
                                                              .terminoEstimado ==
                                                          ""
                                                      ? Colors.transparent
                                                      : Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    //  TÉRMINO REALIZADO
                                    GestureDetector(
                                      onTap: () async {
                                        if (widget.projeto!.status !=
                                            Status.TERMINADA) {
                                          resultTerminoRealizado =
                                              await _openDialog(
                                                  context,
                                                  "Inicio Realizado",
                                                  widget.projeto!.dataEntrega);

                                          //mudei
                                          if (resultTerminoRealizado != null) {
                                            widget.projeto!.dataEntrega =
                                                resultTerminoRealizado!;
                                            firestore
                                                .collection(
                                                    'TarefasTarefasGerais${campeonato}')
                                                .doc((widget.projeto!.id)
                                                    .toString())
                                                .update({
                                              'dataEntrega':
                                                  widget.projeto!.dataEntrega
                                            });
                                          }
                                        }
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              4), // Aqui define-se o raio da borda
                                        ),
                                        elevation: 5, // Define a sombra do Card
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          color: Colors.transparent,
                                          height: 25,
                                          width: 120,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: 100,
                                                height: 25,
                                                //mudei
                                                child: Text(
                                                  widget.projeto!.dataEntrega,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'Poppins'),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 15),
                                                child: Container(
                                                  width: 10,
                                                  height: 10,
                                                  color: Colors.transparent,
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 20,
                                                    //mudei
                                                    color: widget.projeto!
                                                                .dataEntrega ==
                                                            ""
                                                        ? Colors.transparent
                                                        : Colors.black,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    //  DURAÇÃO EM DIAS
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            4), // Aqui define-se o raio da borda
                                      ),
                                      elevation: 5, // Define a sombra do Card
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 25,
                                        width: 120,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: 100,
                                              height: 25,
                                              child: Text(
                                                calcularDiferencaEmDias(
                                                            widget.projeto!
                                                                .dataInicial,
                                                            widget.projeto!
                                                                .dataEntrega) !=
                                                        0
                                                    ? "${calcularDiferencaEmDias(widget.projeto!.dataInicial, widget.projeto!.dataEntrega)}"
                                                    : "s/efeito",
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Container(
                                                  width: 10,
                                                  height: 10,
                                                  color: Colors.transparent,
                                                  child: diasIcon),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    //  RESPONSÁVEL
                                    GestureDetector(
                                      onTap: () async {
                                        if (widget.projeto!.status !=
                                            Status.TERMINADA) {
                                          resultResponsavel =
                                              (await _openDialog(
                                            context,
                                            "Responsável",
                                            widget.projeto!.responsavelTarefa,
                                          ));

                                          if (resultResponsavel != null) {
                                            widget.projeto!.responsavelTarefa =
                                                resultResponsavel!;
                                            firestore
                                                .collection(
                                                    'TarefasTarefasGerais${campeonato}')
                                                .doc((widget.projeto!.id)
                                                    .toString())
                                                .update({
                                              'responsavelTarefa': widget
                                                  .projeto!.responsavelTarefa
                                            });
                                          }
                                        }
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              4), // Aqui define-se o raio da borda
                                        ),
                                        elevation: 5, // Define a sombra do Card
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          color: Colors.transparent,
                                          height: 25,
                                          width: 120,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: 100,
                                                height: 25,
                                                child: Text(
                                                  widget
                                                          .projeto!
                                                          .responsavelTarefa
                                                          .isEmpty
                                                      ? ''
                                                      : widget.projeto!
                                                          .responsavelTarefa,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      fontSize: 16,
                                                      fontFamily: 'Poppins'),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 15),
                                                child: Container(
                                                  width: 10,
                                                  height: 10,
                                                  color: Colors.transparent,
                                                  child: Icon(Icons.check,
                                                      size: 20,
                                                      color:
                                                          resultResponsavel !=
                                                                  ""
                                                              ? Colors.black
                                                              : Colors
                                                                  .transparent),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // DESENVOLVENDO

                // dias Restantes
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 0),
                  child: Text('DIAS RESTANTES'),
                ),

                Text(
                  countdown,
                  style: TextStyle(
                      fontFamily: 'LeagueGothic',
                      fontSize: alturaTela < 600 ? 25 : 36,
                      letterSpacing: 5.0,
                      fontWeight: FontWeight.bold),
                ),
                //const Spacer(),

                // Rodapé
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: alturaTela < 600 ? 35 : 45,
                    decoration: BoxDecoration(
                        color: widget.projeto!.status == Status.TERMINADA
                            ? Colors.grey
                            : colorDart.VermelhoPadrao,
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: TextButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        if (widget.projeto!.dataInicial != "" &&
                            widget.projeto!.dataEntrega != "" &&
                            widget.projeto!.responsavelTarefa != "") {
                          setState(() {
                            widget.projeto!.status = Status.TERMINADA;
                          });

                          Status status = Status.TERMINADA;
                          firestore
                              .collection('TarefasTarefasGerais${campeonato}')
                              .doc((widget.projeto!.id).toString())
                              .update({
                            'status': status.toString().split('.').last
                          });
                        }
                      },
                      child: Text(
                        widget.projeto!.status == Status.TERMINADA
                            ? 'TAREFA REALIZADA'
                            : 'FINALIZAR TAREFA',
                        style: TextStyle(
                            fontSize: alturaTela < 600 ? 14 : 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
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
}

class MyDialog extends StatelessWidget {
  final _formKeyParameter = GlobalKey<FormState>();
  String titulo;
  String parametro;

  final maskFormatter = MaskTextInputFormatter(mask: '##/##/####');

  MyDialog({
    Key? key,
    required this.titulo,
    required this.parametro,
  }) : super(key: key);

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo não pode estar vazio';
    }

    // Verifica se a data está no formato DD/MM/AAAA
    final regex =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/([12]\d{3})$');
    if (!regex.hasMatch(value)) {
      return 'Formato inválido. Use DD/MM/AAAA';
    }

    // Tenta converter a data para verificar se é válida
    try {
      final date = DateFormat('dd/MM/yyyy').parseStrict(value);
      if (date.year < 1000 || date.year > 9999) {
        return 'Ano inválido';
      }
      return null; // Se a data for válida
    } catch (e) {
      return 'Data inválida';
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    TextEditingController controller = TextEditingController(text: parametro);
    return Dialog(
      child: Form(
        key: _formKeyParameter,
        child: Container(
          padding:
              const EdgeInsets.all(16), // Adiciona padding ao redor do conteúdo
          height: 200, // Define a altura do dialog
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Defina $titulo',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(2), // Diminui o borderRadius para 8
                ),
                margin: const EdgeInsets.all(0),
                child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    child: titulo == "Responsável"
                        ? TextFormField(
                            controller: controller,
                            keyboardType: TextInputType.name,
                            inputFormatters: const [],
                            textAlign: TextAlign.center,
                          )
                        : TextFormField(
                            controller: controller,
                            validator: _validateDate,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              maskFormatter, // Aplica a máscara de data
                            ],
                            textAlign: TextAlign.center,
                          )),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, controller.text);
                },
                child: const Text('OK'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
