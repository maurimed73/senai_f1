import 'package:flutter/material.dart';
import 'package:senai_f1/screens/sessao_das_areas/HomeScreen.dart';
import 'package:senai_f1/services/login_service.dart';
import 'package:senai_f1/utils/colors.dart';

class CustomDrawer extends StatelessWidget {
  AuthService serviceAuth = AuthService();
  void _showCustomDialog(BuildContext context) {
    ColorsDart colorDart = ColorsDart();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: colorDart.VermelhoPadrao,
                  size: 60,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Você tem certeza?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Deseja continuar com a ação?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha o diálogo
                      },
                      child: Text(
                        'Não',
                        style: TextStyle(
                          color: colorDart.VermelhoPadrao,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //Fecha o aplicativo se o usuário clicar em "Sim"
                        serviceAuth.signOut();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(colorDart.VermelhoPadrao),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                      ),
                      child: const Text(
                        'Sim',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Material(
        color: const Color.fromRGBO(245, 244, 244, 1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Cabeçalho do Drawer
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.red.shade800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 220,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const NetworkImage(
                            'https://static.portaldaindustria.com.br/media/filer_public_thumbnails/filer_public/92/28/9228bd05-f25f-4a73-9b4b-05318ca7c600/selo-f1.png__302x55_q85_crop_subsampling-2_upscale.png'),
                        fit: BoxFit
                            .contain, // Como a imagem deve se ajustar ao espaço
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0),
                            BlendMode.darken), // Para escurecer a imagem
                      ),
                    ),
                  ),
                  const Text(
                    'Team SRR',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Itens do Drawer
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black),
              title: const Text(
                'Página Inicial',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homescreen(),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text(
                'Configurações',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.black),
              title: const Text(
                'Sobre',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.black),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.black),
              title: const Text(
                'Sair da Conta',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                _showCustomDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
