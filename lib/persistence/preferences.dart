import 'package:shared_preferences/shared_preferences.dart';
import '../api/user/user.dart';

class Preferences {
  SharedPreferences? _preferences;
  User user =
      User(id: 0, first_name: '', last_name: '', username: '', password: '');
  Future<SharedPreferences?> get preferences async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
      user = User(
          // id: _preferences!.getInt('id'),
          first_name: _preferences!.getString('first_name') ?? '',
          last_name: _preferences!.getString('last_name') ?? '',
          username: _preferences!.getString('username') ?? '',
          password: _preferences!.getString('password') ?? '');
    }
    return _preferences;
  }

  Future<Preferences> init() async {
    _preferences = await preferences;
    return this;
  }

  Future<void> saveUser(User _user) async {
    // await _preferences!.setInt('id', _user.id!);
    await _preferences!.setString('first_name', _user.first_name);
    await _preferences!.setString('last_name', _user.last_name);
    await _preferences!.setString('username', _user.username);
    user = _user;
  }

  Future<User> getUser() async {
    user = User(
      // id: _preferences!.getInt('id'),
      first_name: _preferences!.getString('first_name') ?? '',
      last_name: _preferences!.getString('last_name') ?? '',
      username: _preferences!.getString('username') ?? '',
      password: '',
    );
    return user;
  }

  Future<void> deleteSession() async {
    await _preferences!.clear();
  }

  Future<String?> isLogged() async {
    return _preferences!.getString('username');
  }
}
