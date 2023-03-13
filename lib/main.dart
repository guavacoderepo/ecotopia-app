import 'package:flutter/material.dart';
import 'package:technovationapp/constants/colors.dart';
import 'package:technovationapp/modules/usersclass.dart';
import 'package:technovationapp/pages/splash.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => Users(),
        child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'oxygen',
              primaryColorDark: black,
              primaryColor: black,
              inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: deepgreen),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: white),
                ),
              ),
              scaffoldBackgroundColor: lightwhite,
            ),
            debugShowCheckedModeBanner: false,
            home: const Splash()
            // home: Store(),
            ),
      ),
    );
