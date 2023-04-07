import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:technovationapp/constants/url.dart';

Future cart(user, productid, quantity) async {
  var client = http.Client();
  // print(userid);
  // print(productid);
  try {
    var request = await client.post(
      Uri.parse(baseUrl + cartendpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "Username": user,
        "Item_id": productid,
        "Quantity": quantity,
      }),
    );
    // print(request.body);
    if (request.statusCode == 200) {
      return json.decode(request.body);
    } else {
      return json.decode(request.body);
    }
  } finally {
    client.close();
  }
}
