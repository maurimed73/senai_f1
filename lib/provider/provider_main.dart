import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senai_f1/models/projeto_model.dart';

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

  List<ProjetoModel> _items = [];
  bool _isLoading = false;

  List<ProjetoModel> get items => _items;
  bool get isLoading => _isLoading;

  // Função para buscar os dados do Firestore
  Future<void> fetchItems() async {
    List<ProjetoModel> temp = [];
    print('*******************************  COMEÇOU');
    _isLoading = true; // Inicia o carregamento
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("Tarefas").get();
    for (var doc in snapshot.docs) {
      temp.add(ProjetoModel.fromMap(doc.data()));
      print(doc.data());
    }
    print('*******************************  TERMINOU');
    _isLoading = false; // Fim do carregamento
    _items = temp;
    notifyListeners();
  }
}
