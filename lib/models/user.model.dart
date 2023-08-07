import 'dart:convert';

class Usersclass {
  Usersclass({
    this.data,
    this.message,
    this.status,
  });

  Data? data;
  String? message;
  bool? status;

  factory Usersclass.fromJson(String str) =>
      Usersclass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usersclass.fromMap(Map<String, dynamic> json) => Usersclass(
        data: Data.fromMap(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": data!.toMap(),
        "message": message,
        "status": status,
      };
}

class Data {
  Data({
    this.address,
    this.balance,
    this.cart,
    this.email,
    this.name,
    this.phone,
    this.username,
    this.id,
    this.lastScan,
  });

  String? address;
  double? balance;
  List<dynamic>? cart;
  String? email;
  String? name;
  String? phone;
  String? username;
  String? id;
  String? lastScan;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        address: json["Address"],
        balance: json["Balance"],
        cart: List<dynamic>.from(json["Cart"].map((x) => x)),
        email: json["Email"],
        name: json["Name"],
        phone: json["Phone"],
        username: json["Username"],
        id: json["_id"],
        lastScan: json["lastScan"],
      );

  Map<String, dynamic> toMap() => {
        "Address": address,
        "Balance": balance,
        "Cart": List<dynamic>.from(cart!.map((x) => x)),
        "Email": email,
        "Name": name,
        "Phone": phone,
        "Username": username,
        "_id": id,
        "lastScan": lastScan,
      };
}
