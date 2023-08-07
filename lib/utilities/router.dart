import 'package:flutter/material.dart';

push(context, route) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));

pushReplacement(context, route) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => route));

pushUntil(context, route) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => route), (route) => false);
