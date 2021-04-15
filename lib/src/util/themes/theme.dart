import 'package:flutter/material.dart';
ThemeData getTheme(BuildContext context) {
  return ThemeData(
    tabBarTheme: TabBarTheme(),
    brightness: Brightness.light,
    primaryColor: Colors.deepPurpleAccent[400],
    accentColor: Colors.yellow[800],
    primarySwatch: Colors.amber,
    scaffoldBackgroundColor: Colors.grey[100],
    cardTheme: CardTheme(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(0),
        side: BorderSide(color: Colors.white, width: 0),
      ),
    ),
    buttonTheme: ButtonThemeData(
      splashColor: Theme.of(context).accentColor,
      textTheme: ButtonTextTheme.primary,
      height: 50,
      padding: EdgeInsets.all(10),
      alignedDropdown: true,
      hoverColor: Theme.of(context).primaryColor.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(35),
        side: BorderSide(color: Colors.transparent),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(color: Colors.transparent, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(color: Colors.transparent, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.grey[600]),
      prefixStyle: TextStyle(color: Colors.grey[600]),
      hintStyle: TextStyle(color: Colors.orange),
      fillColor: Colors.grey[300],
      focusColor: Colors.red[900],
      hoverColor: Colors.grey[100],
      suffixStyle: TextStyle(color: Colors.orange),
      errorStyle: TextStyle(color: Colors.red),
      isDense: false,
      contentPadding: EdgeInsets.all(18),
    ),
    hintColor: Colors.grey[800],
    iconTheme: IconThemeData(
      color:Colors.grey[400],
    ),
    snackBarTheme: SnackBarThemeData(
      actionTextColor: Colors.deepPurpleAccent[600],
      backgroundColor: Colors.deepOrangeAccent[600],
    ),
    // scaffoldBackgroundColor: Colors.grey[100],
    bottomSheetTheme: BottomSheetThemeData(
      modalElevation: 1,
      backgroundColor: Colors.yellow[600],
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: Colors.yellow[800],
      unselectedItemColor: Colors.deepPurple,
      unselectedLabelStyle: TextStyle(color: Colors.yellow[900]),
      backgroundColor: Colors.grey[100],
    ),
  );
}
