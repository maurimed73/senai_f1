// Modelo de Dados
class ProjetoModel {
  int id;
  String nome;
  String descricao;
  String responsavelTarefa;
  String dataInicial;
  String dataEntrega;
  Status status;
  String inicioEstimado;
  String terminoEstimado;

  ProjetoModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.responsavelTarefa,
    required this.dataInicial,
    required this.dataEntrega,
    required this.status,
    required this.inicioEstimado,
    required this.terminoEstimado,
  });

  // Converte o JSON para o objeto ProjetoModel   RECEBENDO DO FIREBASE
  factory ProjetoModel.fromMap(Map<String, dynamic> json) {
    // Converte de String para Status (enum)
    Status parseStatus(String statusString) {
      return Status.values
          .firstWhere((e) => e.toString().split('.').last == statusString);
    }

    return ProjetoModel(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      responsavelTarefa: json['responsavelTarefa'],
      dataInicial: json['dataInicial'],
      dataEntrega: json['dataEntrega'],
      inicioEstimado: json['inicioEstimado'],
      terminoEstimado: json['terminoEstimado'],
      status: parseStatus(
        json['status'],
      ),
    );
  }

  // Converte o objeto ProjetoModel de volta para JSON  ENVIANDO PARA FIREBASE
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'responsavelTarefa': responsavelTarefa,
      'dataInicial': dataInicial,
      'dataEntrega': dataEntrega,
      'status': status.toString().split('.').last,
      'inicioEstimado': inicioEstimado,
      'terminoEstimado': terminoEstimado
    };
  }
}

enum Status { ATIVO, ATRASADA, TERMINADA, TERMINANDO }
