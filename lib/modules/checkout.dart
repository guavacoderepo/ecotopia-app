import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:technovationapp/constants/url.dart';

class Cartclass {
  Cartclass({
    required this.data,
    required this.message,
    required this.price,
    required this.status,
  });

  List<Datum> data;
  String message;
  double price;
  bool status;

  factory Cartclass.fromJson(String str) => Cartclass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cartclass.fromMap(Map<String, dynamic> json) => Cartclass(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        message: json["message"],
        price: json["price"].toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "message": message,
        "price": price,
        "status": status,
      };
}

class Datum {
  Datum({
    required this.category,
    required this.createdAt,
    required this.description,
    required this.id,
    required this.imgUrl,
    required this.price,
    required this.quantity,
    required this.title,
  });

  String category;
  String createdAt;
  String description;
  String id;
  String imgUrl;
  double price;
  int quantity;
  String title;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        category: json["Category"],
        createdAt: json["Created_at"],
        description: json["Description"],
        id: json["Id"],
        imgUrl: json["ImgUrl"],
        price: json["Price"].toDouble(),
        quantity: json["Quantity"],
        title: json["Title"],
      );

  Map<String, dynamic> toMap() => {
        "Category": category,
        "Created_at": createdAt,
        "Description": description,
        "Id": id,
        "ImgUrl": imgUrl,
        "Price": price,
        "Quantity": quantity,
        "Title": title,
      };
}

Future<Cartclass> checkoutcart(userid) async {
  var client = http.Client();
  // print(userid);
  // print(productid);
  try {
    var request = await client.post(
      Uri.parse(baseUrl + cartcheckout),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"Address": userid}),
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
