import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


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
}
