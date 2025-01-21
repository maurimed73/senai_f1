import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senai_f1/models/projeto_model.dart';

class BuscarFirebase extends StatefulWidget {
  const BuscarFirebase({super.key});

  @override
  State<BuscarFirebase> createState() => _BuscarFirebaseState();
}

class _BuscarFirebaseState extends State<BuscarFirebase> {
  List<ProjetoModel> projetos = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Exibir o CircularProgressIndicator enquanto os dados são carregados
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Exibir erro, se ocorrer
            return Center(child: Text("Erro ao buscar dados"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Caso não haja dados
            return Center(child: Text("Nenhum dado encontrado"));
          } else {
            // Exibir os dados quando estiverem carregados
            List<Map<String, dynamic>> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return ListTile(
                  title: Text(item['nome'] ??
                      'Sem Nome'), // Supondo que o campo seja 'name'
                  subtitle: Text(item['id'].toString() ??
                      'Sem ID'), // Supondo que o campo seja 'id'
                );
              },
            );
          }
        },
      ),
    );
  }

  refresh() async {}

// Função para buscar dados do Firestore
  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      // Suponha que você tenha uma coleção chamada 'items' no Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Tarefas').get();
      // Converter os documentos em uma lista de mapas
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Erro ao buscar dados: $e");
      return [];
    }
  }
}
