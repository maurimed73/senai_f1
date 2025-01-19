import 'package:flutter/material.dart';
import 'package:senai_f1/models/projeto_model.dart';

class MainModel with ChangeNotifier {
  bool _visibleProjects = true;
  bool _loading = false;

  bool get visibleProjects => _visibleProjects;
  bool get loading => _loading;

  void visibletogle() {
    _visibleProjects = !_visibleProjects;
    notifyListeners();
  }

  void loadingUser() {
    _loading = true;
    notifyListeners();
  }

  void notLoading() {
    _loading = false;
    notifyListeners();
  }

  // List<ProjetoModel> _projetos = [
  // ProjetoModel(
  //     id: 10,
  //     nome: 'Mauricio',
  //     descricao: 'descrição de projeto',
  //     responsavelTarefa: 'BUGA',
  //     dataInicial: '01/01/2025',
  //     dataEntrega: '10/03/2025',
  //     status: Status.ativo,
  //     inicioEstimado: '10/01/2025',
  //     terminoEstimado: '30/03/2025'),
  // ProjetoModel(
  //     id: 11,
  //     nome: 'João',
  //     descricao: 'descrição de projeto',
  //     responsavelTarefa: 'João',
  //     dataInicial: '01/01/2025',
  //     dataEntrega: '10/03/2025',
  //     status: Status.ativo,
  //     inicioEstimado: '10/01/2025',
  //     terminoEstimado: '30/03/2025'),
  // ProjetoModel(
  //     id: 12,
  //     nome: 'Rodrigo',
  //     descricao: 'descrição de projeto',
  //     responsavelTarefa: 'Rodrigo',
  //     dataInicial: '01/01/2025',
  //     dataEntrega: '10/03/2025',
  //     status: Status.ativo,
  //     inicioEstimado: '10/01/2025',
  //     terminoEstimado: '30/03/2025'),
  // ProjetoModel(
  //     id: 13,
  //     nome: 'Silvia',
  //     descricao: 'descrição de projeto',
  //     responsavelTarefa: 'Silvia',
  //     dataInicial: '01/01/2025',
  //     dataEntrega: '10/03/2025',
  //     status: Status.ativo,
  //     inicioEstimado: '10/01/2025',
  //     terminoEstimado: '30/03/2025'),
  //];
  // Getter para acessar a lista de usuários
  List<ProjetoModel> _projetos = [];
  List<ProjetoModel> get projetos => _projetos;

  void adicionarProjeto(ProjetoModel projeto) {
    _projetos.add(projeto);
    notifyListeners();
  }

  // Função para editar o nome de um usuário na lista
  void editarResponsavel(int id, String novoNome) {
    final projeto = projetos.firstWhere((projeto) => projeto.id == id);
    projeto.responsavelTarefa = novoNome;
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  // Função para adicionar um novo usuário à lista
  void adicionarTarefa(ProjetoModel projeto) {
    _projetos.add(projeto);
    print('Total de ${_projetos.length} projetos na lista de objetos');
    print('${projetos[0].nome}');
    notifyListeners();
  }

  // Função para remover um usuário da lista
  void removerTarefa(String id) {
    _projetos.removeWhere((projeto) => projeto.id == id);
    notifyListeners();
  }
}
