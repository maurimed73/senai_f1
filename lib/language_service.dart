// import 'package:shared_preferences/shared_preferences.dart';

// class LanguageService {
//   static const String _languageKey = 'language_code';

//   // Carrega a linguagem salva
//   static Future<String?> loadLanguage() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_languageKey);
//   }

//   // Salva a linguagem escolhida
//   static Future<void> saveLanguage(String languageCode) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_languageKey, languageCode);
//   }
// }
