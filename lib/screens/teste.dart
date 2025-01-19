import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lista de 30 itens (containers)
    List<Widget> itemsContainer = List.generate(30, (index) {
      return Container(
        width: 50, // Largura do item
        height: 50, // Altura do item
        color: Colors.blue[(index % 9) * 100],
        child: Center(
          child: Text(
            '${index + 1}', // Número do item
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });

    // Função para dividir a lista em sublistas de no máximo 12 itens
    List<List<Widget>> splitList(List<Widget> list, int chunkSize) {
      List<List<Widget>> chunks = [];
      for (int i = 0; i < list.length; i += chunkSize) {
        int end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
        chunks.add(list.sublist(i, end));
      }
      return chunks;
    }

    // Dividir a lista em sublistas de 12 itens cada
    List<List<Widget>> sublists = splitList(itemsContainer, 12);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dividir Lista em Sublistas'),
      ),
      body: ListView.builder(
        itemCount: sublists.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: sublists[index], // Sublista atual
            ),
          );
        },
      ),
    );
  }
}
