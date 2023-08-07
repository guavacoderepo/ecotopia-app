import 'package:flutter/material.dart';
import 'package:technovationapp/constants/colors.dart';

Text text(text, double size,
    {FontWeight weight = FontWeight.w400, Color color = black}) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: weight, color: color),
  );
}

Text f7(text, double size,
    {FontWeight weight = FontWeight.w400, Color color = white}) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: weight, color: color),
  );
}

Text f4(text, double size,
    {FontWeight weight = FontWeight.w200, Color color = green}) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: weight, color: color),
  );
}

Text f1(text, double size,
    {FontWeight weight = FontWeight.w300, Color color = white}) {
  return Text(
    text,
    overflow: TextOverflow.fade,
    style: TextStyle(fontSize: size, fontWeight: weight, color: color),
  );
}

Text f5(text, double size,
    {FontWeight weight = FontWeight.w400, Color color = blacklight}) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: weight, color: color),
  );
}

Text f6(text, double size,
    {FontWeight weight = FontWeight.w500, Color color = blacklight}) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: weight, color: color),
  );
}

Text f5a(text, double size,
    {FontWeight weight = FontWeight.w400,
    Color color = white,
    TextAlign align = TextAlign.center}) {
  return Text(
    text,
    textAlign: align,
    style: TextStyle(fontSize: size, fontWeight: weight, color: color),
  );
}
