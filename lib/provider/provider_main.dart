import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senai_f1/models/projeto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainModel extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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

  String _campeonato = '';
  String get campeonato => _campeonato;

  set campeonato(String newValue) {
    _campeonato = newValue;
    notifyListeners();
  }

  String _area = '';
  String get area => _area;

  set area(String newValue) {
    _area = newValue;
    notifyListeners();
  }

  Locale _locale = const Locale('pt', 'BR'); // Idioma padrão é o inglês
  Locale get locale => _locale;

  Future<void> languagePref() async {
    final prefs = await SharedPreferences.getInstance();
    var language = prefs.get('language_code');
  }

  // Método para mudar o idioma
  Future<void> changeLanguage(
    String languageCode,
  ) async {
    _locale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode); // Salva a preferência

    notifyListeners();
  }

  // RECICLAGEM ENGENHARIA REGIONAL
  List<ProjetoModel> _objetosEngenhariaRegional = [];
  List<ProjetoModel> get objetosEngenhariaRegional =>
      _objetosEngenhariaRegional;
// Método para carregar a lista de objetos do Firestore
  Future<void> carregarObjetosEngenhariaRegional() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('TarefasEngenhariaRegional')
          .get();

      // Convertendo os documentos para a lista de objetos
      _objetosEngenhariaRegional = querySnapshot.docs
          .map(
              (doc) => ProjetoModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      notifyListeners(); // Notifica todos os widgets ouvindo este provider
    } catch (e) {
      print('Erro ao carregar objetos do Firestore: $e');
    }
  }

  // RECICLAGEM ENGENHARIA NACIONAL
  List<ProjetoModel> _objetosGestaoRegional = [];
  List<ProjetoModel> get objetosGestaoRegional => _objetosGestaoRegional;

  // Método para carregar a lista de objetos do Firestore
  Future<void> carregarObjetosGestaoRegional() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('TarefasGestaoRegional')
          .get();

      // Convertendo os documentos para a lista de objetos
      _objetosGestaoRegional = querySnapshot.docs
          .map(
              (doc) => ProjetoModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      notifyListeners(); // Notifica todos os widgets ouvindo este provider
    } catch (e) {
      print('Erro ao carregar objetos do Firestore: $e');
    }
  }

  // // Método para adicionar um objeto à lista
  // void adicionarObjeto(ProjetoModel objeto) {
  //   _objetosEngenhariaRegional.add(objeto);
  //   notifyListeners();
  // }

  // // Método para remover um objeto da lista
  // void removerObjeto(String id) {
  //   _objetosEngenhariaRegional.removeWhere((objeto) => objeto.id == id);
  //   notifyListeners();
  // }

  // // Método para atualizar um objeto na lista
  // void atualizarObjeto(ProjetoModel objetoAtualizado) {
  //   final index = _objetosEngenhariaRegional
  //       .indexWhere((objeto) => objeto.id == objetoAtualizado.id);
  //   if (index != -1) {
  //     _objetosEngenhariaRegional[index] = objetoAtualizado;
  //     notifyListeners();
  //   }
  // }
}
