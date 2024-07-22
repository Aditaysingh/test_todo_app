import 'package:flutter/material.dart';
import 'colors.dart';

final BoxDecoration lightContainerDecoration = BoxDecoration(
  border: Border.all(color: Colors.grey.withOpacity(0.5)),
  borderRadius: BorderRadius.circular(10.0),
  color: primaryColor,
);

final BoxDecoration darkContainerDecoration = BoxDecoration(
  border: Border.all(color: Colors.white.withOpacity(0.5)),
  borderRadius: BorderRadius.circular(10.0),
  color: Colors.black26,
);

// Define themes
var lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor:primaryColor,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: secondaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(color: secondaryColor),
    actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.grey[200],
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(color: secondaryColor, fontSize: 16),
    subtitleTextStyle: TextStyle(color: secondaryColor, fontSize: 16),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: secondaryColor, fontSize: 20),
    bodyMedium: TextStyle(color: secondaryColor, fontSize: 18),
    displayLarge: TextStyle(color:secondaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  ),
  iconButtonTheme: IconButtonThemeData(style: ButtonStyle(iconColor: WidgetStateProperty.all(secondaryColor))),
  iconTheme:  IconThemeData(color:secondaryColor),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: primaryColor,
    hintStyle: TextStyle(fontSize: 20, color: secondaryColor),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: primaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(primaryColor),
      foregroundColor: WidgetStateProperty.all(secondaryColor),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(backgroundColor: WidgetStatePropertyAll(primaryColor),),
    inputDecorationTheme: InputDecorationTheme(

      filled: true,
      fillColor: primaryColor
    ),
    textStyle: TextStyle(color: secondaryColor)
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: primaryColor,
    textStyle: TextStyle(color:primaryColor),
    // labelTextStyle: WidgetStatePropertyAll(TextStyle(color:Colors.white)),
  ),
);

var darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black45,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(color:primaryColor),
    actionsIconTheme: IconThemeData(color: primaryColor),
  ),
  scaffoldBackgroundColor: Colors.grey,
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(Colors.black26),
    checkColor: WidgetStateProperty.all(primaryColor),
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(color: primaryColor, fontSize: 16),
    subtitleTextStyle: TextStyle(color: primaryColor, fontSize: 16),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color:primaryColor, fontSize: 20),
    bodyMedium: TextStyle(color: primaryColor, fontSize: 18),
    bodySmall: TextStyle(color: primaryColor, fontSize: 18),
    displayLarge: TextStyle(color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  ),
  iconButtonTheme: IconButtonThemeData(style: ButtonStyle(iconColor: WidgetStateProperty.all(primaryColor))),
  iconTheme: IconThemeData(color: primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.black12,
    hintStyle: TextStyle(fontSize: 20, color: Colors.white70),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.black45),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.black45),
      foregroundColor: WidgetStateProperty.all(primaryColor),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(

    menuStyle: MenuStyle(backgroundColor: WidgetStatePropertyAll(secondaryColor),),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: secondaryColor,
      ),
      textStyle: TextStyle(color: primaryColor),

  ),

  popupMenuTheme: PopupMenuThemeData(
    color: Colors.grey,
    textStyle: TextStyle(color: primaryColor),
    labelTextStyle: WidgetStatePropertyAll(TextStyle(color: primaryColor)),

  ),
);
