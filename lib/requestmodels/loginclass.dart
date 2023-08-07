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

    // print(request.body);
    if (request.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(request.body);
      return responseData;
    } else {
      final Map<String, dynamic> responseData = json.decode(request.body);
      return responseData;
    }
  } finally {
    client.close();
  }
}
