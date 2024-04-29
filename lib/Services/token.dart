import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static Future<void> salvarToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> recuperarToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> limparToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
