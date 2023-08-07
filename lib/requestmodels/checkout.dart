import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:technovationapp/constants/url.dart';
import 'package:technovationapp/models/cart.model.dart';



Future<Cartclass> checkoutcart(user) async {
  var client = http.Client();
  // print(userid);
  // print(productid);
  try {
    var request = await client.post(
      Uri.parse(baseUrl + cartcheckout),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"Username": user}),
    );
    // print(request.body);
    if (request.statusCode == 200) {
      return Cartclass.fromMap(json.decode(request.body));
    } else {
      return Cartclass.fromMap(json.decode(request.body));
    }
  } finally {
    client.close();
  }
}
