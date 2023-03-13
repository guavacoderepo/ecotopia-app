import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:technovationapp/constants/url.dart';

Future login(user, pwd) async {
  var client = http.Client();

  try {
    var request = await client.post(
      Uri.parse(baseUrl + loginUser),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "User": user,
        "Password": pwd,
      }),
    );

    if (request.statusCode == 200) {
      return json.decode(request.body);
    } else {
      return json.decode(request.body);
    }
  } finally {
    client.close();
  }
}
