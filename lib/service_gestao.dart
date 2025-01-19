import 'dart:convert';

import 'package:senai_f1/models/projeto_model.dart';

class ServiceGestao {
  String jsonData = '''
    [
      {"id": 1, "name": "Escopo", "description": "Detalhes sobre o escopo.", "responsavelTarefa": "João Miguel", "dataInicial": "2025-01-08 12:34:56.789","dataEntrega":"2025-02-25 12:34:56.789", "situacao": "Iniciada" },
      {"id": 2, "name": "Pesquisa", "description": "Detalhes sobre o pesquisa.", "responsavelTarefa": "Daniel", "dataInicial": "2025-01-08 12:34:56.789","dataEntrega":"2025-02-25 12:34:56.789", "situacao": "Iniciada" },
     }
    ]
    ''';

  List<ProjetoModel> parseProjetos() {
    List<dynamic> data = json.decode(jsonData); // Decodificando o JSON
    return data
        .map((item) => ProjetoModel.fromJson(item))
        .toList(); // Convertendo para lista de objetos
  }
}
