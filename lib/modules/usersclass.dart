import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/url.dart';

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

// user class
// ##################################################
class Users extends ChangeNotifier {
  Usersclass _user = Usersclass();

  Usersclass get user => _user;

  Future users({String username = ""}) async {
    var client = http.Client();

    try {
      var request = await client.post(
        Uri.parse(baseUrl + userprofile),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "Username": username,
        }),
      );
      // print(request.body);

      if (request.statusCode == 200) {
        _user = Usersclass.fromMap(json.decode(request.body));
        // print(_user);
        // print(_user.data.cart.length);
        notifyListeners();
      } else {
        // notifyListeners();
      }
    } finally {
      client.close();
    }
  }
}








// // call user function
// Future users(context) async {
//   var client = http.Client();

//   String token = await retriveToken();

//   try {
//     var response = await client.get(Uri.parse(baseurl + getme), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     });

//     final Map<String, dynamic> responseData = json.decode(response.body);

//     if (response.statusCode == 200) {
//       var user = UserModel.fromMap(responseData["data"]);

//       await saveToken(responseData["token"]);

//       Provider.of<User>(context, listen: false).setUser(user);
//       // user
//       return {
//         "status": true,
//         "token": responseData["token"],
//         "data": user,
//       };
//       // else return false
//     } else {
//       return {
//         "status": false,
//         "data": responseData['msg'],
//       };
//     }
//   } catch (e) {
//     throw Exception(e);
//   } finally {
//     client.close();
//   }
// }

 

// // notifier
// class User extends ChangeNotifier {
//   // intance of the user model
//   UserModel _user = UserModel();

//   UserModel get user => _user;

// // call user function
//   void setUser(UserModel user) {
//     _user = user;
//     notifyListeners();
//   }


// }




