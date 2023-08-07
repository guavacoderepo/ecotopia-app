import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technovationapp/utilities/variables.dart';
import '../constants/colors.dart';
import '../utilities/font.dart';
import '../modules/usersclass.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String total = "0.0";
  String? token = "";
  @override
  Widget build(BuildContext context) {
    Usersclass user = Provider.of<Users>(context, listen: true).user;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: f5("${user.data!.username} Profile", 16),

        // cart icon
        actions: [
          //  total cart item
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: f1("∆${user.data!.balance!.toStringAsFixed(2)}", 15,
                color: blacklight),
          ),
          // payment button
        ],

        // pop icon
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: deepgreen,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // top divider
            const Divider(color: lightwhite, thickness: 3),
            // usser icon
            const Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: primary,
                radius: 60,
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiGcFYBKGruads8sUVAfUBlX8orSdEwuSSTg&usqp=CAU",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  f1("Name", 20, color: textgrey),
                  vgap(10),
                  f1(user.data!.name, 15, color: black),
                  vgap(10),
                  f1("Email", 20, color: textgrey),
                  vgap(10),
                  f1(user.data!.email, 15, color: black),
                  vgap(10),
                  f1("Phone", 20, color: textgrey),
                  vgap(10),
                  f1(user.data!.phone, 15, color: black),
                  vgap(10),
                  f1("UserName", 20, color: textgrey),
                  vgap(10),
                  f1(user.data!.username, 15, color: black),
                  vgap(10),
                  f1("Address", 20, color: textgrey),
                  vgap(10),
                  f1(user.data!.address, 15, color: black),
                  vgap(10),
                  f1("Balance", 20, color: textgrey),
                  vgap(10),
                  f1("∆${user.data!.balance!.toStringAsFixed(2)}", 15,
                      color: black),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
