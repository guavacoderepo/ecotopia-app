import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:technovationapp/constants/url.dart';

Future register(name, phone, username, email, pwd1, pwd2) async {
  var client = http.Client();

  try {
    var request = await client.post(
      Uri.parse(baseUrl + registerUser),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Full-name": name,
        "Phone": phone,
        "Username": username,
        "Email": email,
        "Password": pwd1,
        "Confirm_password": pwd2
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
