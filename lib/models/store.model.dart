import 'dart:convert';

class StoreClass {
  StoreClass({
    required this.data,
    required this.message,
    required this.status,
  });

  List<Item> data;
  String message;
  bool status;

  factory StoreClass.fromJson(String str) =>
      StoreClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreClass.fromMap(Map<String, dynamic> json) => StoreClass(
        data: List<Item>.from(json["data"].map((x) => Item.fromMap(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "message": message,
        "status": status,
      };
}

class Item {
  Item({
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

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
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
