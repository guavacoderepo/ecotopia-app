import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:technovationapp/models/user.model.dart';
import '../constants/url.dart';
import '../utilities/shareprefrence.dart';

Future users(context) async {
  String user = await readprefs();
  var client = http.Client();

  try {
    var request = await client.post(
      Uri.parse(baseUrl + userprofile),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "Username": user,
      }),
    );
    // print(request.body);

    if (request.statusCode == 200) {
      Usersclass result = Usersclass.fromMap(json.decode(request.body));
      // print(_user);

      Provider.of<Users>(context, listen: false).setUser(result);
      // print(_user.data.cart.length);
    } else {
      // notifyListeners();
    }
  } finally {
    client.close();
  }
}

// user class
// ##################################################
class Users extends ChangeNotifier {
  Usersclass _user = Usersclass();

  Usersclass get user => _user;

  void setUser(Usersclass user) {
    _user = user;
    notifyListeners();
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




