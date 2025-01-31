import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senai_f1/models/projeto_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:senai_f1/provider/provider_main.dart';
import 'package:senai_f1/screens/TarefasGerais/campeonato/tarefasgerais_tarefa.dart';

import 'package:senai_f1/utils/colors.dart';

class GarrafasTarefasGerais extends StatefulWidget {
  String campeonato;
  GarrafasTarefasGerais({super.key, required this.campeonato});
  @override
  State<GarrafasTarefasGerais> createState() => _GarrafasTarefasGeraisState();
}

class _GarrafasTarefasGeraisState extends State<GarrafasTarefasGerais> {
  ColorsDart colorsDart = ColorsDart();
  final _formKey = GlobalKey<FormState>();
  List<Widget> originalList = [];
  List<ProjetoModel> projetos = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    refresh();
    // getProjetosFromFirebase();
    originalList.add(GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _criarNovaTarefa();
      },
      child: Container(
          width: 90,
          height: 120,
          color: ColorsDart().FundoApp,
          child: Container(
              child: Center(
                  child: Image.asset(
            'assets/garrafa_mais.png',
          )))),
    ));
  }

  @override
  void dispose() {
    tituloAdd.dispose();
    descricaoAdd.dispose();
    inicioEstimadoAdd.dispose();
    terminoEstimadoAdd.dispose();
    super.dispose();
  }

  void reorganizarTarefas(List<ProjetoModel> tarefas) {
    setState(() {
      // Ordena colocando os itens com Status.TERMINADO no final
      tarefas.sort((a, b) {
        // Se o status de a é TERMINADO e b não é, coloca a no final
        if (a.status == Status.TERMINADA && b.status != Status.TERMINADA) {
          return 1;
        }
        // Se o status de b é TERMINADO e a não é, coloca b no final
        if (a.status != Status.TERMINADA && b.status == Status.TERMINADA) {
          return -1;
        }
        // Se ambos são iguais, mantém a ordem original
        return 0;
      });
    });
  }

  refresh() async {
    List<ProjetoModel> temp = [];
    print('*******************************  COMEÇOU');
    print('campeonato ${widget.campeonato}');
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("TarefasTarefasGerais${widget.campeonato}")
        .get();
    for (var doc in snapshot.docs) {
      temp.add(ProjetoModel.fromMap(doc.data()));
      print(doc.data());
    }
    print('*******************************  TERMINOU');
    // Remover todos os itens após o primeiro (índice 1)
    if (originalList.length > 1) {
      originalList.removeRange(1, originalList.length);
    }
// Função para converter a string para DateTime
    DateTime parseDate(String dateStr) {
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      return dateFormat.parse(dateStr);
    }

    reorganizarTarefas(temp);

    temp.forEach(
      (projeto) {
        //print(projeto.terminoEstimado);
        bool terminando = false;
        // Data de destino (exemplo: 10 de março de 2025)
        DateTime parsedDate = parseDate(projeto.terminoEstimado);
        //print('Data convertida: $parsedDate');
        // Data de hoje
        DateTime today = DateTime.now();
        // Calcula a diferença entre as duas datas
        Duration difference = parsedDate.difference(today);
        //print('diferença em dias: ${difference.inDays + 1}');
        if ((difference.inDays + 1) < 4 && (difference.inDays + 1) > 0) {
          terminando = true;
        }
        print(projeto.id);
        originalList.add(
          GestureDetector(
            onLongPress: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Deletar Item'),
                    content: Text(
                        'Item ${projeto.nome.toUpperCase()} será deletado?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Fecha o diálogo
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Deleta o item
                          try {
                            // Referência do Firestore para o documento que você quer deletar
                            await FirebaseFirestore.instance
                                .collection(
                                    'TarefasTarefasGerais${widget.campeonato}')
                                .doc(projeto.id.toString())
                                .delete();
                            print('Documento deletado com sucesso');
                          } catch (e) {
                            print('Erro ao deletar o documento: $e');
                          }

                          refresh();

                          // Fecha o diálogo
                          Navigator.of(context).pop();
                        },
                        child: Text('Deletar'),
                      ),
                    ],
                  );
                },
              );

              temp.removeWhere((tarefa) => tarefa.id == projeto.id);
            },
            onTap: () async {
              HapticFeedback.lightImpact();
              final retorno = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TarefasGeraisDetailPage(
                      projeto: projeto,
                    ),
                  )).then(
                (value) {
                  refresh();
                },
              );
            },
            child: Container(
              width: 90,
              height: 143,
              color: ColorsDart().FundoApp,
              child: Container(
                height: 160,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        height: 120,
                        color: Colors.transparent,
                        child: Image.asset(
                          projeto.status == Status.ATRASADA
                              ? 'assets/garrafa_atrasada.png'
                              : projeto.status == Status.TERMINADA
                                  ? 'assets/garrafa_finalizada.png'
                                  : terminando
                                      ? 'assets/garrafa_terminando.png'
                                      : 'assets/garrafa_andamento.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Text(
                        projeto != null ? projeto.nome : "sem nome",
                        maxLines: 1, // Impede que o texto quebre linha
                        overflow: TextOverflow
                            .ellipsis, // Exibe '...' se o texto não couber
                        style: TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ); // Adiciona cada item na nova lista
      },
    );
    if (mounted) {
      setState(() {});
    }
  }

  TextEditingController tituloAdd = TextEditingController();
  TextEditingController descricaoAdd = TextEditingController();
  TextEditingController inicioEstimadoAdd = TextEditingController();
  TextEditingController terminoEstimadoAdd = TextEditingController();
  // Máscara para data no formato DD/MM/AAAA
  final maskFormatter = MaskTextInputFormatter(mask: '##/##/####');

// Função de validação
  String? _validateField(String? value) {
    if (value == null || value.isEmpty) {
      return ''; // Não retornar nenhuma mensagem, apenas controla a borda
    }
    return null;
  }

  // Função de validação de data
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

  Future<void> _criarNovaTarefa() async {
    tituloAdd.text = "";
    descricaoAdd.text = "";
    inicioEstimadoAdd.text = "";
    terminoEstimadoAdd.text = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(0), // Remove o padding padrão
          child: Container(
            height: MediaQuery.of(context).size.height *
                0.7, // 80% da altura da tela
            width:
                MediaQuery.of(context).size.width * 1, // 90% da largura da tela
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), // Bordas arredondadas
              color: Colors.transparent,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Botão de sair

                    // Título
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Adicionar Informações',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 40,
                              ))
                        ],
                      ),
                    ),
                    // const Divider(),
                    // Corpo do dialog
                    Container(
                      color: Colors.transparent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.height * 0.4,
                              color: Colors.transparent,
                              child: Image.asset(
                                'assets/garrafa_tarefa.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width * 0.65,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Título: ',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  color: Colors.grey.shade300,
                                  child: TextFormField(
                                    controller: tituloAdd,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w800),
                                    maxLength: 20, // Limita a 20 caracteres
                                    decoration: const InputDecoration(
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .red, // Cor da borda quando estiver em foco e com erro
                                            width: 2.0,
                                          ),
                                        ),
                                        errorStyle:
                                            TextStyle(height: 0, fontSize: 0),
                                        counterText: '',
                                        contentPadding:
                                            EdgeInsets.only(bottom: 15)),
                                    validator: _validateField,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Descrição',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Container(
                                  color: Colors.grey.shade300,
                                  //width: 200,
                                  height: 70,
                                  child: TextField(
                                    controller: descricaoAdd,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w800),
                                    maxLines:
                                        5, // Define que o TextField pode ter número ilimitado de linhas
                                    keyboardType: TextInputType
                                        .multiline, // Permite várias linhas
                                    textInputAction: TextInputAction
                                        .newline, // Permite o uso de "Enter" para nova linha
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            4.0), // Borda arredondada
                                        borderSide: const BorderSide(
                                            color: Colors.blue, width: 2.0),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Início Estimado: ',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  color: Colors.grey.shade300,
                                  child: TextFormField(
                                    controller: inicioEstimadoAdd,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w800),
                                    maxLength: 20, // Limita a 20 caracteres
                                    decoration: const InputDecoration(
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .red, // Cor da borda quando estiver em foco e com erro
                                            width: 2.0,
                                          ),
                                        ),
                                        errorStyle:
                                            TextStyle(height: 0, fontSize: 0),
                                        counterText: '',
                                        contentPadding:
                                            EdgeInsets.only(bottom: 15)),
                                    validator: _validateDate,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      maskFormatter, // Aplica a máscara de data
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Término Estimado: ',
                                  style: TextStyle(fontSize: 10),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  color: Colors.grey.shade300,
                                  child: TextFormField(
                                    controller: terminoEstimadoAdd,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w800),
                                    maxLength: 20, // Limita a 20 caracteres
                                    decoration: const InputDecoration(
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .red, // Cor da borda quando estiver em foco e com erro
                                            width: 2.0,
                                          ),
                                        ),
                                        errorStyle:
                                            TextStyle(height: 0, fontSize: 0),
                                        counterText: '',
                                        contentPadding:
                                            EdgeInsets.only(bottom: 15)),
                                    validator: _validateDate,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      maskFormatter, // Aplica a máscara de data
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //const Spacer(),
                    // Botão para fechar

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          if (_formKey.currentState?.validate() ?? false) {
                            // Se a validação for bem-sucedida, salve os dados
                            int id = DateTime.now().millisecondsSinceEpoch;
                            String nome = tituloAdd.text;
                            String descricao = descricaoAdd.text;
                            String responsavelTarefa = "";
                            String dataInicial = "";
                            String dataEntrega = "";
                            String inicioEstimado = inicioEstimadoAdd.text;
                            String terminoEstimado = terminoEstimadoAdd.text;
                            Status status = Status.ATIVO;
                            DateFormat dateFormat = DateFormat('dd/MM/yyyy');
                            DateTime dataConvertida =
                                dateFormat.parse(terminoEstimado);
                            // Obter a data atual
                            DateTime dataAtual = DateTime.now();
                            // Comparar as datas
                            if (dataConvertida.isBefore(dataAtual)) {
                              status = Status.ATRASADA;
                            } else {
                              status = Status.ATIVO;
                            }

                            ProjetoModel addTarefa = ProjetoModel(
                              id: id,
                              nome: nome,
                              descricao: descricao,
                              responsavelTarefa: responsavelTarefa,
                              dataInicial: dataInicial,
                              dataEntrega: dataEntrega,
                              status: status,
                              inicioEstimado: inicioEstimado,
                              terminoEstimado: terminoEstimado,
                            );

                            // mandar para o banco
                            firestore
                                .collection(
                                    'TarefasTarefasGerais${widget.campeonato}')
                                .doc((addTarefa.id).toString())
                                .set(addTarefa.toMap());

                            refresh();
                            // MÉTODOS PARA SALVAR TAREFA
                            // Provider.of<MainModel>(context, listen: false)
                            //     .adicionarProjeto(addTarefa);

                            // novaTarefa(addTarefa);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Tarefa Adicionada!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            // Se a validação falhar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Há erros no formulário'),
                                  duration: Duration(seconds: 2)),
                            );
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 45,
                          decoration: BoxDecoration(
                              color: ColorsDart().VermelhoPadrao,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Text(
                            'ADICIONAR TAREFA',
                            style: TextStyle(
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
      },
    );
  }

  //**************************************************************************************
  //************************* PARÂMETROS PARA NOVA PÁGINA ********************************

  @override
  Widget build(BuildContext context) {
    print(widget.campeonato);
    // refresh();
    // for (var element in MainModel().projetos) {
    //   print('Responsáveis pelas Tarefas:  ${element.responsavelTarefa}');
    // }

    //final projetos = Provider.of<MainModel>(context).items;
    // Função para dividir a lista original em sublistas com até 8 itens
    List<List<Widget>> splitListIntoChunks(List<Widget> list, int chunkSize) {
      List<List<Widget>> chunkedLists = [];
      for (int i = 0; i < list.length; i += chunkSize) {
        int end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
        chunkedLists.add(list.sublist(i, end));
      }
      return chunkedLists;
    }

    // Dividindo a lista em sublistas de até 8 itens
    List<List<Widget>> wrappedLists = splitListIntoChunks(originalList, 4);

    return Consumer<MainModel>(
      builder: (context, value, child) => SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Permite rolagem horizontal
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            value.loading
                ? CircularProgressIndicator()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: wrappedLists.map((wrapList) {
                      return SizedBox(
                        width: 190,
                        child: Container(
                          margin: EdgeInsets.only(
                              right: 0), // Espaço entre os wraps
                          child: Wrap(
                            spacing:
                                5, // Espaçamento entre os itens dentro do Wrap
                            runSpacing:
                                10, // Espaçamento entre as linhas do Wrap
                            children: wrapList,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
