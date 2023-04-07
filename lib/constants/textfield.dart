import 'package:flutter/material.dart';
import 'package:technovationapp/constants/colors.dart';

Widget inputbox(hint, controller,
    {bool obs = false, TextInputType keyboard = TextInputType.text}) {
  return TextField(
    style: const TextStyle(fontSize: 15, color: blacklight),
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20, right: 20),
        filled: true,
        fillColor: white,
        // labelText: hint,

        hintText: hint,
        hintStyle: const TextStyle(color: textgrey)),
    obscureText: obs,
    keyboardType: keyboard,
    controller: controller,
  );
}

Widget quantitybox() {
  return const TextField(
    style: TextStyle(fontSize: 15, color: palewhite),
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: white),
        ),
        contentPadding: EdgeInsets.all(5),
        hintText: "1",
        hintStyle: TextStyle(color: blacklight)),
    keyboardType: TextInputType.number,
  );
}
