import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static const String authkey = 'login_details';

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(authkey);

    return data != null && data.isNotEmpty;
  }

  static Future<String?> getLoginDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authkey);
  }

  static Future<bool> setLoginDetails({required String token}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(authkey, token);
  }

  static Future<bool> logOut({required BuildContext context}) async {
    return await setLoginDetails(token: '');
  }
}
