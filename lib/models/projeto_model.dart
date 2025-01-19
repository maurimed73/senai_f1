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

  // Converte o JSON para o objeto ProjetoModel
  factory ProjetoModel.fromJson(Map<String, dynamic> json) {
    return ProjetoModel(
        id: json['id'],
        nome: json['name'],
        descricao: json['description'],
        responsavelTarefa: json['responsavelTarefa'],
        dataInicial: json['dataInicial'],
        dataEntrega: json['dataEntrega'],
        status: json['status'],
        inicioEstimado: json['inicioEstimado'],
        terminoEstimado: json['terminoEstimado']);
  }

  // Converte o objeto ProjetoModel de volta para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nome,
      'description': descricao,
      'responsavelTarefa': responsavelTarefa,
      'dataInicial': dataInicial,
      'dataEntrega': dataEntrega,
      'status': status,
      'inicioEstimado': inicioEstimado,
      'terminoEstimado': terminoEstimado
    };
  }
}

enum Status { ativo, atrasada, terminada }
