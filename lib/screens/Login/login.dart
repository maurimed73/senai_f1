import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senai_f1/provider/provider_main.dart';
import 'package:senai_f1/services/login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _authService = AuthService();
  MainModel _loginService = MainModel();

  bool _isLoading = false;

  void _login() async {
    _loginService.loadingUser();

    User? user = await _authService.signInWithEmailPassword(
      _emailController.text,
      _passwordController.text,
    );

    _loginService.notLoading();

    if (user != null) {
      // Login bem-sucedido, navegue para a próxima tela
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Exibir mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Falha no login. Tente novamente."),
      ));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height / 2.8),
                      painter: CirclePainter(),
                    ),
                    Positioned(
                      top: 50,
                      left: (MediaQuery.of(context).size.width - 250) / 2,
                      child: Container(
                        width: 250,
                        height: 150,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/logo1.png'), // Substitua pelo caminho do seu logo
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: TextField(
                      controller: _emailController,
                      onChanged: (String value) {},
                      cursorColor: Colors.deepOrange,
                      decoration: const InputDecoration(
                          hintText: "Email",
                          prefixIcon: Material(
                            elevation: 0,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Icon(
                              Icons.email,
                              color: Colors.red,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 13)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      onChanged: (String value) {},
                      cursorColor: Colors.deepOrange,
                      decoration: const InputDecoration(
                          hintText: "Senha",
                          prefixIcon: Material(
                            elevation: 0,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Icon(
                              Icons.lock,
                              color: Colors.red,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 13)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 52),
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Color(0xffff3a5a)),
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : TextButton(
                              child: const Text(
                                "Entrar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                              onPressed: () {
                                _login();
                              },
                            ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: SizedBox(
                    height: 30,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Esqueceu a Senha ?",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Rodapé fixo
          Container(
            width: 120,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage(
                    'assets/logo2.png'), // Substitua pelo caminho do seu logo
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color.fromRGBO(217, 15, 15, 1) // Cor do círculo
      ..style = PaintingStyle.fill;

    // Largura da tela e altura
    double width = size.width;
    double height = size.height;

    // Raio é metade da largura, então o diâmetro é o dobro da largura da tela
    double radius = width;

    // Posicionamento do círculo: um pouco acima da região central
    double centerX = width / 2;
    double centerY =
        (height / 2) - 250; // Ajuste "100" conforme necessário para a posição

    // Desenha o círculo
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // Não precisa redesenhar a cada alteração
  }
}
