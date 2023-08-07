import 'package:http/http.dart' as http;
import '../constants/url.dart';

Future update(user) async {
  var client = http.Client();
  try {
    await client.get(
      Uri.parse("$baseUrl/api/v1/profile/update?user=" + user),
    );
  } finally {
    client.close();
  }
}
