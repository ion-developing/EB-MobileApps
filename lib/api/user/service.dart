import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:superestaurants/api/Constants.dart';
import 'package:superestaurants/api/user/user.dart';

import '../../persistence/preferences.dart';

class UserService {
  static Future<User> login(String username, String password) async {
    final response =
        await http.get(Uri.parse(Paths().login(username, password)));

    if (response.statusCode == 200) {
      List<User> temp = (json.decode(response.body) as List)
          .map((e) => User.fromJson(e))
          .toList();
      return temp[0];
    } else {
      throw Exception('Error de comsumo de API');
    }
  }

  static Future<User> register(User user) async {
    final response = await http.post(Uri.parse(Paths().register()), body: {
      'username': user.username,
      'last_name': user.last_name,
      'first_name': user.first_name,
      'password': user.password
    });
    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error de comsumo de API');
    }
  }

  static Future<bool> isLogged() async {
    Preferences prefs = Preferences();
    await prefs.init();
    var username = await prefs.isLogged();
    if (username != null) {
      return true;
    }
    return false;
  }
}
