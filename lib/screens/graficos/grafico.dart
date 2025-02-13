import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senai_f1/models/projeto_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:senai_f1/utils/colors.dart';

class graficoPage extends StatefulWidget {
  final String titulo;
  final String campeonato;
  final String mes;
  final String banco;
  graficoPage(
      {super.key,
      required this.titulo,
      required this.campeonato,
      required this.mes,
      required this.banco});

  @override
  State<graficoPage> createState() => _graficoPageState();
}

class _graficoPageState extends State<graficoPage> {
  List<ProjetoModel> objetoRegional = [];
  late Future<List<FlSpot>> spotsFuture;

  @override
  void initState() {
    spotsFuture = fetchDataFromFirestore();

    //buscarDocumentos(widget.mes);
    super.initState();
  }

  int tarefasTerminadas = 0;
  List<ProjetoModel> temp = [];
  Future<List<FlSpot>> fetchDataFromFirestore() async {
    //List<FlSpot> spots = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('${widget.banco}Regional')
        .get();

    for (var doc in querySnapshot.docs) {
      String data = doc['terminoEstimado'];

      if (data != "") {
        if (isOkDate(data)) {
          var status = (doc['status']) == "ATRASADA"
              ? Status.ATRASADA
              : (doc['status']) == "TERMINADA"
                  ? Status.TERMINADA
                  : (doc['status']) == "TERMINANDO"
                      ? Status.TERMINANDO
                      : Status.ATIVO;

          temp.add(
            ProjetoModel(
              id: doc['id'],
              nome: doc['nome'],
              descricao: doc['descricao'],
              responsavelTarefa: doc['responsavelTarefa'],
              dataInicial: doc['dataInicial'],
              dataEntrega: doc['dataEntrega'],
              status: status,
              inicioEstimado: doc['inicioEstimado'],
              terminoEstimado: doc['terminoEstimado'],
            ),
          );
        }
      }
    }

    print('fetchData numero de tarefas: ${temp.length}');
    //setState(() {});
    List<DataPoint> dataPoints = [];

    for (var v = 0; v < temp.length; v++) {
      if (temp[v].status == Status.TERMINADA) {
        DateTime dataEntrega =
            DateFormat('dd/MM/yyyy').parse(temp[v].dataEntrega);
        DateTime dataTerminoEstimado =
            DateFormat('dd/MM/yyyy').parse(temp[v].terminoEstimado);
        // Descobrir a semana do mês
        int semanaDoMes = getSemanaDoMes(dataTerminoEstimado);

        // if (dataTerminoEstimado.isBefore(dataEntrega)) {
        //   print(
        //       "Tarefa ${v + 1} CUIDADO         - entrega feita dia ${dataEntrega.day} a previsão era para o dia  ${dataTerminoEstimado.day} - $semanaDoMesº semana.");

        //   //dataPoints.add(DataPoint(x: 0, y: v.toDouble()));
        // } else if (dataTerminoEstimado.isAfter(dataEntrega)) {
        //   print(
        //       "Tarefa ${v + 1} PARABÉNS        - Entregue dia ${dataEntrega.day}/${dataEntrega.month}/${dataEntrega.year}. O prazo era dia ${dataTerminoEstimado.day}/${dataTerminoEstimado.month}/${dataTerminoEstimado.year}  - $semanaDoMesº semana");
        // } else {
        //   print("Tarefa ${v + 1} As datas são iguais.  - $semanaDoMesº semana");
        // }

        // Exibir o resultado
        // print(
        //     'Previsão de Entrega: ${DateFormat('dd/MM/yyyy').format(dataTerminoEstimado)}  $semanaDoMesº semana  || Entrega realizada:  ${DateFormat('dd/MM/yyyy').format(dataEntrega)}');
        semanaDoMes == 1
            ? semana1.add(temp[v])
            : semanaDoMes == 2
                ? semana2.add(temp[v])
                : semanaDoMes == 3
                    ? semana3.add(temp[v])
                    : semanaDoMes == 4
                        ? semana4.add(temp[v])
                        : semana5.add(temp[v]);
      }
      tarefasTerminadas = temp.length;
    }

    print('semana 1 ${semana1.length} ');
    print('semana 2 ${semana2.length}');
    print('semana 3 ${semana3.length}');
    print('semana 4 ${semana4.length}');
    print('semana 5 ${semana5.length}');

    dataPoints.add(DataPoint(x: 0, y: 0));
    //SEMANA 1
    for (var i = 0; i < semana1.length; i++) {
      DateTime dataEntrega =
          DateFormat('dd/MM/yyyy').parse(semana1[i].dataEntrega);
      DateTime dataTerminoEstimado =
          DateFormat('dd/MM/yyyy').parse(semana1[i].terminoEstimado);
      if (dataTerminoEstimado.isBefore(dataEntrega)) {
        print(
            "CUIDADO         - entrega feita dia ${dataEntrega.day} a previsão era para o dia  ${dataTerminoEstimado.day} -  1ºsemana.");

        //dataPoints.add(DataPoint(x: 0, y: v.toDouble()));
      } else if (dataTerminoEstimado.isAfter(dataEntrega)) {
        print(
            "PARABÉNS        - Entregue dia ${dataEntrega.day}/${dataEntrega.month}/${dataEntrega.year}. O prazo era dia ${dataTerminoEstimado.day}/${dataTerminoEstimado.month}/${dataTerminoEstimado.year}  -  1ºsemana");
      } else {
        print("As datas são iguais.  -  1ºsemana");
      }
    }
    if (semana1.length == 1) {
      dataPoints.add(DataPoint(x: 0.5, y: 0.5));
    }
    double startXSemana1 = 0.2; // Início do quadrante
    double endXSemana1 = 0.8; // Final do quadrante
    int objectCountSemana1 = semana1.length;
    double stepSemana1 = (endXSemana1 - startXSemana1) /
        (objectCountSemana1 - 1); // Espaçamento entre os pontos

    List<FlSpot> listaSemana1 = List.generate(
      objectCountSemana1,
      (indexSemana1) {
        dataPoints.add(DataPoint(
            x: startXSemana1 + (indexSemana1 * stepSemana1),
            y: startXSemana1 + (indexSemana1 * stepSemana1)));
        return FlSpot(
            startXSemana1 + (indexSemana1 * stepSemana1), startXSemana1);
      },
    );

    //************************************************************************************************************************** */
    //************************************************************************************************************************** */
    //SEMANA 2
    for (var i = 0; i < semana2.length; i++) {
      if (semana2.length == 1) {
        //dataPoints.add(DataPoint(x: 1.5, y: 1.5));
      }
      DateTime dataEntrega =
          DateFormat('dd/MM/yyyy').parse(semana2[i].dataEntrega);
      DateTime dataTerminoEstimado =
          DateFormat('dd/MM/yyyy').parse(semana2[i].terminoEstimado);
      if (dataTerminoEstimado.isBefore(dataEntrega)) {
        print(
            "Tarefa ${i + 1} CUIDADO         - entrega feita dia ${dataEntrega.day} a previsão era para o dia  ${dataTerminoEstimado.day} -  2ºsemana.");

        //dataPoints.add(DataPoint(x: 0, y: v.toDouble()));
      } else if (dataTerminoEstimado.isAfter(dataEntrega)) {
        print(
            "Tarefa ${i + 1} PARABÉNS        - Entregue dia ${dataEntrega.day}/${dataEntrega.month}/${dataEntrega.year}. O prazo era dia ${dataTerminoEstimado.day}/${dataTerminoEstimado.month}/${dataTerminoEstimado.year}  -  2ºsemana");
      } else {
        print("Tarefa ${i + 1} As datas são iguais.  -  2ºsemana");
        if (semana2.length == 1) {
          //dataPoints.add(DataPoint(x: 1.5, y: 1.5));
        }
      }
    }
    if (semana2.length == 1) {
      dataPoints.add(DataPoint(x: 1.5, y: 1.5));
    } else {
      double startXSemana2 = 1.2; // Início do quadrante
      double endXSemana2 = 1.8; // Final do quadrante
      int objectCountSemana2 = semana2.length;
      double stepSemana2 = (endXSemana2 - startXSemana2) /
          (objectCountSemana2 - 1); // Espaçamento entre os pontos

      List<FlSpot> listaSemana2 = List.generate(
        objectCountSemana2,
        (indexSemana2) {
          dataPoints.add(DataPoint(
              x: startXSemana2 + (indexSemana2 * stepSemana2),
              y: startXSemana2 + (indexSemana2 * stepSemana2)));
          return FlSpot(
              startXSemana2 + (indexSemana2 * stepSemana2), startXSemana2);
        },
      );
    }

    //************************************************************************************************************************** */
    //************************************************************************************************************************** */
    //SEMANA 3
    for (var i = 0; i < semana3.length; i++) {
      if (semana3.length == 1) {
        //dataPoints.add(DataPoint(x: 1.5, y: 1.5));
      }
      DateTime dataEntrega =
          DateFormat('dd/MM/yyyy').parse(semana3[i].dataEntrega);
      DateTime dataTerminoEstimado =
          DateFormat('dd/MM/yyyy').parse(semana3[i].terminoEstimado);
      if (dataTerminoEstimado.isBefore(dataEntrega)) {
        print(
            "Tarefa ${i + 1} CUIDADO         - entrega feita dia ${dataEntrega.day} a previsão era para o dia  ${dataTerminoEstimado.day} -  3ºsemana.");

        //dataPoints.add(DataPoint(x: 0, y: v.toDouble()));
      } else if (dataTerminoEstimado.isAfter(dataEntrega)) {
        print(
            "Tarefa ${i + 1} PARABÉNS        - Entregue dia ${dataEntrega.day}/${dataEntrega.month}/${dataEntrega.year}. O prazo era dia ${dataTerminoEstimado.day}/${dataTerminoEstimado.month}/${dataTerminoEstimado.year}  -  3ºsemana");
      } else {
        print("Tarefa ${i + 1} As datas são iguais.  -  3ºsemana");
        if (semana3.length == 1) {
          //dataPoints.add(DataPoint(x: 1.5, y: 1.5));
        }
      }
    }
    if (semana3.length == 1) {
      dataPoints.add(DataPoint(x: 2.5, y: 2.5));
    } else {
      double startXSemana3 = 2.2; // Início do quadrante
      double endXSemana3 = 2.8; // Final do quadrante
      int objectCountSemana3 = semana3.length;
      double stepSemana3 = (endXSemana3 - startXSemana3) /
          (objectCountSemana3 - 1); // Espaçamento entre os pontos

      List<FlSpot> listaSemana3 = List.generate(
        objectCountSemana3,
        (indexSemana3) {
          dataPoints.add(DataPoint(
              x: startXSemana3 + (indexSemana3 * stepSemana3),
              y: startXSemana3 + (indexSemana3 * stepSemana3)));
          return FlSpot(
              startXSemana3 + (indexSemana3 * stepSemana3), startXSemana3);
        },
      );
    }

    //SEMANA 4
    for (var i = 0; i < semana4.length; i++) {
      DateTime dataEntrega =
          DateFormat('dd/MM/yyyy').parse(semana4[i].dataEntrega);
      DateTime dataTerminoEstimado =
          DateFormat('dd/MM/yyyy').parse(semana4[i].terminoEstimado);
      if (dataTerminoEstimado.isBefore(dataEntrega)) {
        print(
            "CUIDADO         - entrega feita dia ${dataEntrega.day} a previsão era para o dia  ${dataTerminoEstimado.day} -  4ºsemana.");
      } else if (dataTerminoEstimado.isAfter(dataEntrega)) {
        print(
            "PARABÉNS        - Entregue dia ${dataEntrega.day}/${dataEntrega.month}/${dataEntrega.year}. O prazo era dia ${dataTerminoEstimado.day}/${dataTerminoEstimado.month}/${dataTerminoEstimado.year}  -  4ºsemana");
      } else {
        print("As datas são iguais.  -  4ºsemana");
      }
    }

    if (semana4.length == 1) {
      dataPoints.add(DataPoint(x: 3.5, y: 3.5));
    } else {
      double startXSemana4 = 3.2; // Início do quadrante
      double endXSemana4 = 3.8; // Final do quadrante
      int objectCountSemana4 = semana4.length;
      double stepSemana4 = (endXSemana4 - startXSemana4) /
          (objectCountSemana4 - 1); // Espaçamento entre os pontos

      List<FlSpot> listaSemana4 = List.generate(
        objectCountSemana4,
        (indexSemana4) {
          dataPoints.add(DataPoint(
              x: startXSemana4 + (indexSemana4 * stepSemana4),
              y: startXSemana4 + (indexSemana4 * stepSemana4)));
          return FlSpot(
              startXSemana4 + (indexSemana4 * stepSemana4), startXSemana4);
        },
      );
    }

    // //SEMANA 5
    for (var i = 0; i < semana5.length; i++) {
      DateTime dataEntrega =
          DateFormat('dd/MM/yyyy').parse(semana5[i].dataEntrega);
      DateTime dataTerminoEstimado =
          DateFormat('dd/MM/yyyy').parse(semana5[i].terminoEstimado);
      if (dataTerminoEstimado.isBefore(dataEntrega)) {
        print(
            "Tarefa ${i + 1} CUIDADO         - entrega feita dia ${dataEntrega.day} a previsão era para o dia  ${dataTerminoEstimado.day} -  5ºsemana.");

        //dataPoints.add(DataPoint(x: 0, y: v.toDouble()));
      } else if (dataTerminoEstimado.isAfter(dataEntrega)) {
        print(
            "Tarefa ${i + 1} PARABÉNS        - Entregue dia ${dataEntrega.day}/${dataEntrega.month}/${dataEntrega.year}. O prazo era dia ${dataTerminoEstimado.day}/${dataTerminoEstimado.month}/${dataTerminoEstimado.year}  -  5ºsemana");
      } else {
        print("Tarefa ${i + 1} As datas são iguais.  -  5ºsemana");
      }
    }
    if (semana5.length == 1) {
      dataPoints.add(DataPoint(x: 4.5, y: 4.5));
    }

    double startXSemana5 = 4.2; // Início do quadrante
    double endXSemana5 = 4.8; // Final do quadrante
    int objectCountSemana5 = semana5.length;
    double stepSemana5 = (endXSemana5 - startXSemana5) /
        (objectCountSemana5 - 1); // Espaçamento entre os pontos

    List<FlSpot> listaSemana5 = List.generate(
      objectCountSemana5,
      (indexSemana5) {
        dataPoints.add(DataPoint(
            x: startXSemana5 + (indexSemana5 * stepSemana5),
            y: startXSemana5 + (indexSemana5 * stepSemana5)));
        return FlSpot(
            startXSemana5 + (indexSemana5 * stepSemana5), startXSemana5);
      },
    );

    return dataPoints
        .map((dataPoint) => FlSpot(dataPoint.x, dataPoint.y))
        .toList();
  }

// Função para verificar se a data está no mês de fevereiro
  bool isOkDate(String data) {
    List<String> partes = data.split('/');
    String mes = partes[1];

    return mes == widget.mes.toString();
  }

  List<ProjetoModel> semana1 = [];
  List<ProjetoModel> semana2 = [];
  List<ProjetoModel> semana3 = [];
  List<ProjetoModel> semana4 = [];
  List<ProjetoModel> semana5 = [];

  // Função para calcular a semana do mês
  int getSemanaDoMes(DateTime data) {
    // Obtém o dia do mês
    int diaDoMes = data.day;
// Calcula a semana (dividindo o dia do mês por 7)
    int semana = (diaDoMes / 7).ceil(); // O `.ceil()` arredonda para cima

    return semana;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlSpot>>(
      future: spotsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Enquanto os dados estão sendo carregados, mostra um carregando
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar os dados'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum dado encontrado.'));
        }

        // Usa os dados para construir o gráfico
        List<FlSpot> spots = snapshot.data!;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: ColorsDart().VermelhoPadrao,
            foregroundColor: Colors.white,
            title: Text('Evolução Tarefas'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                linhaDadosGrafico(
                  titulo: 'Área',
                  valor: widget.titulo,
                ),
                linhaDadosGrafico(
                  titulo: 'Campeonato',
                  valor: widget.campeonato,
                ),
                linhaDadosGrafico(
                  titulo: 'Mês',
                  valor: widget.mes,
                ),
                linhaDadosGrafico(
                  titulo: 'nº Tarefas',
                  valor: tarefasTerminadas == 0
                      ? 'Não há tarefas terminadas'
                      : tarefasTerminadas.toString(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                  child: Center(
                    child: Container(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      child: LineChart(
                        LineChartData(
                          backgroundColor: Colors.white,
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            drawHorizontalLine: false,
                            getDrawingVerticalLine: (value) {
                              if (value % 1 == 0) {
                                // Apenas para valores inteiros
                                return FlLine(
                                  color: Colors.black,
                                  strokeWidth: 1,
                                );
                              }
                              return FlLine(
                                  color:
                                      Colors.transparent); // Linhas invisíveis
                            },
                          ),
                          borderData: FlBorderData(show: true),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  // Exibe apenas números inteiros no eixo X
                                  int intValue = value.toInt();

                                  if (value.toInt() == 0) {
                                    return Text('1'); // Oculta o "0"
                                  }

                                  if (value == intValue) {
                                    if (value != 5) {
                                      return Text((value.toInt() + 1)
                                          .toString()); // Ajusta os números
                                    }
                                  }
                                  if (value.toInt() == 6) {
                                    return Text(''); // Oculta o "0"
                                  } else {
                                    return const SizedBox(); // Não exibe título para valores não inteiros
                                  }
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                                getTitlesWidget: (value, meta) {
                                  // Exibe apenas números inteiros no eixo Y
                                  int intValue = value.toInt();
                                  if (value == intValue) {
                                    return Text(
                                      intValue.toString(),
                                      style: const TextStyle(
                                          color: Colors.transparent,
                                          fontSize: 12),
                                    );
                                  } else {
                                    return const SizedBox(); // Não exibe título para valores não inteiros
                                  }
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                              ),
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                const FlSpot(0, 0),

                                const FlSpot(5, 5),
                                // FlSpot(5, temp.length.toDouble()),
                              ],
                              isStrokeCapRound: false,
                              preventCurveOverShooting: true,
                              show: true,
                              color: Colors.blue,
                              barWidth: 1,
                              isCurved: false,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                            LineChartBarData(
                              spots: spots
                                  .where((spot) => spot != FlSpot.nullSpot)
                                  .toList(),
                              barWidth: 2,
                              color: Colors.red,
                              isCurved: false,
                              dotData: FlDotData(
                                show: true, // Ativa os pontos
                                getDotPainter: (spot, percent, barData, index) {
                                  if (index == 0
                                      //index == barData.spots.length - 1
                                      ) {
                                    // Retorna um pintor "invisível"
                                    return FlDotCirclePainter(
                                      radius:
                                          0, // Define o raio como 0 para ocultar o último ponto
                                      color: Colors.transparent,
                                      strokeWidth: 0,
                                      strokeColor: Colors.transparent,
                                    );
                                  }
                                  return FlDotCirclePainter(
                                      radius: 4,
                                      color: Colors.red,
                                      strokeColor: Colors.transparent);
                                },
                              ),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class linhaDadosGrafico extends StatelessWidget {
  final String titulo;
  final String valor;
  const linhaDadosGrafico({
    super.key,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
              alignment: Alignment.centerRight,
              width: 90,
              child: Text("${titulo}:")),
          SizedBox(
            width: 10,
          ),
          Container(
              width: 270,
              child: Text(
                valor,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
        ],
      ),
    );
  }
}

class DataPoint {
  final double x;
  final double y;

  DataPoint({required this.x, required this.y});

  // Converte o documento Firestore em um DataPoint
  // factory DataPoint.fromFirestore(DocumentSnapshot doc) {
  //   return DataPoint(
  //     x: doc['x']?.toDouble() ?? 0.0,
  //     y: doc['y']?.toDouble() ?? 0.0,
  //   );
  // }
}
