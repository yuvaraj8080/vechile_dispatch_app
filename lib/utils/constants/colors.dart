import 'package:flutter/material.dart';

class TColors{
  TColors._();


  //  App basic Colors//
  static const Color primaryColor = Color(0xFF4B48ff);
  static const Color secondary = Color(0xFFFFE24B);
  static const Color accent = Color(0xFFb0c7ff);

  static const Gradient linearGradient = LinearGradient(
    begin:Alignment(0.0, 0.0),
      end: Alignment(0.707,-0.707),
      colors:[
        Color(0xffff9a9e),
        Color(0xfffad0c4),
        Color(0xfffad0c4)
  ]);


  // Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C7570);
  static const Color textWhite = Colors.white;

// background Container
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);


//  background Container Colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static  const Color white = Colors.white;

// buttons Colors
static const Color buttonPrimary = Color(0xFF4b68ff);
static const Color buttonSecondary = Color(0xFF6c7570);
static const Color buttonDisabled = Color(0xFFC4C4C4);


// Neutral  Shades
static const Color black = Color(0xFF232323);
static const Color darkGrey = Color(0xFF4F4F4F);
static const Color warning = Color(0xFF939393);
static const Color grey = Color(0xFFE0E0E0);

}