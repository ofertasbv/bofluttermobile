import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
ThemeData getTheme(BuildContext context) {
  return ThemeData(
    tabBarTheme: TabBarTheme(),
    brightness: Brightness.light,
    primaryColor: Colors.deepPurpleAccent[800],
    accentColor: Colors.yellow[800],
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.grey[100],
    textTheme: GoogleFonts.latoTextTheme(
      Theme.of(context).textTheme,
    ),
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
