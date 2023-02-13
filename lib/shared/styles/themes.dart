import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black45,
    primarySwatch: defaultColor,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black45,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
      ),
      iconTheme: IconThemeData(
          color: Colors.white
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        elevation: 20.0,
        backgroundColor: Colors.black45,
        unselectedItemColor: Colors.grey
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white
        )
    ),
  fontFamily: 'Jannah'
);
ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(
            color: Colors.black
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20.0,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black
        )
    ),
  fontFamily: 'Jannah'
);