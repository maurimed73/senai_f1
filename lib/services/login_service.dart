import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Função para registrar um novo usuário
  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Erro ao criar usuário: $e");
      return null;
    }
  }

  // Função para fazer login com email e senha
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Erro ao fazer login: $e");
      return null;
    }
  }

  // Função para sair
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Função para verificar se o usuário está logado
  Stream<User?> get user => _auth.authStateChanges();
}
