import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:technovationapp/constants/url.dart';

Future makepayment(user, token) async {
  var client = http.Client();

  try {
    // print("payment");
    var request = await client.post(
      Uri.parse(baseUrl + storepayment),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {"Username": user, "Token": token},
      ),
    );
    // print(request.body);
    return json.decode(request.body);
  } finally {
    client.close();
  }
}
