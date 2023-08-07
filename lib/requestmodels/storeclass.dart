import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:technovationapp/constants/url.dart';
import 'package:technovationapp/models/store.model.dart';



// store class
Future<StoreClass> storedata() async {
  var client = http.Client();
  try {
    var request = await client.get(Uri.parse(baseUrl + fetchStoreData));

    if (request.statusCode == 200) {
      var response = StoreClass.fromMap(json.decode(request.body));
      return response;
    } else {
      throw Exception();
    }
  } finally {
    client.close();
  }
}
