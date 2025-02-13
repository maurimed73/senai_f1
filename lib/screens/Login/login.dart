import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senai_f1/provider/provider_main.dart';
import 'package:senai_f1/screens/sessao_das_areas/HomeScreen.dart';
import 'package:senai_f1/services/login_service.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final _authService = AuthService();
  final MainModel _loginService = MainModel();

  final bool _isLoading = false;

  Future<bool> _login() async {
    _loginService.loadingUser();

    User? user = await _authService.signInWithEmailPassword(
      _emailController.text,
      _passwordController.text,
    );

    _loginService.notLoading();

    if (user != null) {
      // Check if the widget is still mounted before navigating
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homescreen()),
        );

        return true;
      }
    } else {
      // Check if the widget is still mounted before showing the SnackBar
      if (user == null) {
        ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: const Scaffold(
            // Seu conteúdo aqui
            body: Text("Falha no login. Tente novamente."),
          ),
        );
        return false;
      }
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          backgroundColor: Colors.white,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: TextField(
                          controller: _emailController,
                          onChanged: (String value) {},
                          cursorColor: Colors.deepOrange,
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.email,
                              prefixIcon: const Material(
                                elevation: 0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Icon(
                                  Icons.email,
                                  color: Colors.red,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          onChanged: (String value) {},
                          cursorColor: Colors.deepOrange,
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.password,
                              prefixIcon: const Material(
                                elevation: 0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.red,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Color(0xffff3a5a)),
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : TextButton(
                                  child: Text(
                                    AppLocalizations.of(context)!.enter,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    var teste = await _login();
                                    print(teste);
                                    if (teste == false) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 16,
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .attention,
                                                      style: const TextStyle(
                                                          fontSize: 20)),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .formwithincorrectdata,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  ElevatedButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: const Text('Ok'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
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
                            child: Text(
                              '${AppLocalizations.of(context)!.forgotpassword} ?',
                              style: const TextStyle(
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
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color.fromRGBO(217, 15, 15, 1) // Cor do círculo
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
