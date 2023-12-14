import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static String valueSharedPreferences = '';
  static int counter = 0;

// Write DATA
  static Future<bool> saveUserData(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setInt(
        'flutter.$valueSharedPreferences', value);
  }

// Read Data
  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('flutter.$valueSharedPreferences');
  }
}
