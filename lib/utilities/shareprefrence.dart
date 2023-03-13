import 'package:shared_preferences/shared_preferences.dart';

readprefs() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'user';
  final value = prefs.getString(key) ?? "";
  // print(value);
  return value;
}

Future save(String value) async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'user';
  prefs.setString(key, value);
}

Future delete() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'user';
  prefs.remove(key);
}
