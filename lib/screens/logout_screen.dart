import 'package:flutter/material.dart';
import 'package:senai_f1/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LogoutScreen extends StatelessWidget {
  LogoutScreen({super.key, this.contextLanguage});
  final contextLanguage;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          backgroundColor: ColorsDart().FundoApp,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: double.infinity,
                  child: Image.asset('assets/noconnection.png'),
                ),
                Text(
                  AppLocalizations.of(contextLanguage)!.youareloggedout,
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  AppLocalizations.of(contextLanguage)!.closetheapp,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
