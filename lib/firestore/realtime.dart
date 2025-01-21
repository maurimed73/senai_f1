import 'package:firebase_database/firebase_database.dart';
import 'package:senai_f1/models/projeto_model.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

// Supondo que você tenha uma lista de projetos
List<ProjetoModel> projetos = [
  ProjetoModel(
    id: 1,
    nome: "Projeto 1",
    descricao: "Descrição do projeto 1",
    responsavelTarefa: "Responsável 1",
    dataInicial: "2025-01-01",
    dataEntrega: "2025-03-01",
    status: Status.ATIVO,
    inicioEstimado: "2025-01-01",
    terminoEstimado: "2025-03-01",
  ),
  ProjetoModel(
    id: 2,
    nome: "Projeto 2",
    descricao: "Descrição do projeto 2",
    responsavelTarefa: "Responsável 2",
    dataInicial: "2025-02-01",
    dataEntrega: "2025-04-01",
    status: Status.ATIVO,
    inicioEstimado: "2025-02-01",
    terminoEstimado: "2025-04-01",
  ),
];

// Função para adicionar projetos ao Firebase
Future<void> addProjetosToFirebase() async {
  for (var projeto in projetos) {
    await database.child('projetos/${projeto.id}').set(projeto.toMap());
  }
}

// Função para buscar projetos do Firebase
Future<void> getProjetosFromFirebase() async {
  // Usando o DatabaseEvent, e então acessando o snapshot
  DatabaseEvent event = await database.child('projetos').once();
  DataSnapshot snapshot = event.snapshot;

  // Verificando se snapshot.value é um Map antes de fazer o cast
  if (snapshot.value is Map) {
    // Fazendo o cast seguro
    Map<dynamic, dynamic> projetosMap =
        Map<dynamic, dynamic>.from(snapshot.value as Map);

    List<ProjetoModel> projetos = [];

    // Convertendo o mapa em uma lista de objetos ProjetoModel
    projetosMap.forEach((key, value) {
      projetos.add(ProjetoModel.fromMap(Map<String, dynamic>.from(value)));
    });

    // Agora a lista de projetos está disponível e você pode usá-la no seu app
    print(projetos);
  } else {
    print("Erro: os dados não são um mapa válido.");
  }
}
