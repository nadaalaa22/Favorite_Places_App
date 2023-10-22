import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

abstract class UserData {
  ///add user data to [sharedPreference]
  ///
  /// throw an error
  Future<void> setUserData(User user);

  ///get all  user data from  [sharedPreference]
  ///
  /// throw an error
  Future<User> getUserData();

  /// true if [user] has signed up
  ///
  /// throw an error
  Future<bool> hasSignedUp();

  Future<void> logout();
}

class UserDataImp implements UserData {
  final userKey = 'signed up user';

  @override
  Future<User> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String value = prefs.getString(userKey) ?? 'not found ';
    final jsonUser = jsonDecode(value);
    User user = User.fromMap(jsonUser);
    return user;
  }

  @override
  Future<bool> hasSignedUp() async {
    final pref = await SharedPreferences.getInstance();
    String? result = pref.getString(userKey);
    return result != null;
  }

  @override
  Future<void> setUserData(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonUser = jsonEncode(user.toMap());
    await prefs.setString(userKey, jsonUser);
  }

  @override
  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(userKey);
  }
}
