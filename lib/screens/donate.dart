import 'package:flutter/material.dart';
import 'package:technovationapp/constants/colors.dart';
import 'package:technovationapp/constants/font.dart';

class Contribute extends StatelessWidget {
  const Contribute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: f7("How to Contribute", 16, color: black),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              f4("ECoins is the in-app currency on EcoTopia that can be used to make in-app purchases on the app store or can be transferred to your commercial bank  account (to lower exchange rate). ",
                  14,
                  weight: FontWeight.w300, color: black),
              const SizedBox(height: 30),
              cardDesign(context, "1", "assets/img/img1.png",
                  "Identify an outlet around you"),
              const SizedBox(height: 10),
              cardDesign(context, "2", "assets/img/img2.png",
                  "Bring recyclables to the outlet"),
              const SizedBox(height: 10),
              cardDesign(context, "3", "assets/img/img3.png",
                  "Your material will be exchanged to coin")
            ],
          ),
        ),
      ),
    );
  }

  cardDesign(context, number, img, title) => Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: black.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  color: green.withOpacity(0.4),
                  width: 50,
                  height: 50,
                  child: Center(child: f1(number, 20, color: black)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: f4(title, 13, color: black, weight: FontWeight.w300),
                ),
                const SizedBox(width: 5)
              ],
            ),
            Center(
              child: Image.asset(
                img,
              ),
            )
          ],
        ),
      );
}
