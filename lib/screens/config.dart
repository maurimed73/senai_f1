import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senai_f1/provider/provider_main.dart';

class ConfigApp extends StatefulWidget {
  const ConfigApp({super.key});

  @override
  State<ConfigApp> createState() => _ConfigAppState();
}

class _ConfigAppState extends State<ConfigApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Consumer<MainModel>(
        builder: (context, providerIdioma, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
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
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
