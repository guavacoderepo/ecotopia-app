import 'package:flutter/material.dart';
import 'package:technovationapp/constants/colors.dart';
import 'package:technovationapp/requestmodels/usersclass.dart';
import 'package:technovationapp/pages/splash.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => Users(),
        child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'poppins',
              primaryColorDark: black,
              primaryColor: black,
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: deepgreen),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                ),
              ),
              scaffoldBackgroundColor: lightwhite,
            ),
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: MyBehavior(),
                child: child!,
              );
            },
            home: const Splash()
            // home: Store(),
            ),
      ),
    );

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
