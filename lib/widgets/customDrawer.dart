import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:senai_f1/main.dart';

import 'package:senai_f1/provider/provider_main.dart';
import 'package:senai_f1/screens/Login/login.dart';
import 'package:senai_f1/screens/config.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:senai_f1/screens/logout_screen.dart';
import 'package:senai_f1/services/auth_check.dart';
import 'package:senai_f1/services/login_service.dart';
import 'package:senai_f1/utils/colors.dart';

class CustomDrawer extends StatefulWidget {
  final context;
  const CustomDrawer({super.key, this.context});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  AuthService serviceAuth = AuthService();

  void _showCustomDialog(BuildContext context) {
    ColorsDart colorDart = ColorsDart();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MaterialApp(
          home: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: colorDart.VermelhoPadrao,
                    size: 60,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(widget.context)!.areyousure,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(widget.context)!.continueaction,
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
                          AppLocalizations.of(widget.context)!.no,
                          style: TextStyle(
                            color: colorDart.VermelhoPadrao,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          //Fecha o aplicativo se o usuário clicar em "Sim"
                          await serviceAuth.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogoutScreen(contextLanguage: widget.context ),
                              ));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(colorDart.VermelhoPadrao),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(widget.context)!.yes,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // bool idioma = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
      builder: (context, providerIdioma, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          backgroundColor: Colors.transparent,
          body: Drawer(
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
                    leading: const Icon(Icons.settings, color: Colors.black),
                    title: DropdownButton<String>(
                      value: providerIdioma.locale.languageCode,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          providerIdioma
                              .changeLanguage(newValue); // Muda o idioma
                        }
                      },
                      items: <String>['en', 'pt'] // Idiomas disponíveis
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value == 'en' ? 'Inglês' : 'Português'),
                        );
                      }).toList(),
                    ),
                  ),

                  ListTile(
                    leading: const Icon(Icons.info, color: Colors.black),
                    title: const Text(
                      'Config',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConfigApp(),
                          ));
                    },
                  ),
                  const Divider(color: Colors.black),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.black),
                    title: Text(
                      AppLocalizations.of(widget.context)!.logout,
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      _showCustomDialog(widget.context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
