import 'package:flutter/material.dart';

const primary = Color(0xFFB057F5);
//main color - purple

//Colors for habit cards
const yellow = Color(0xFFFFDF6B);
const orange = Color(0xFFFF950F);
const pink = Color(0xFFFF93BA);
const green = Color(0xFF9BE988);
const blue = Color(0xFF7CD0FF);
const grey = Color(0xFFCACACA);
const purple = Color(0xFFB057F5);
enum CardColors {
  yellow,
  orange,
  pink,
  green,
  blue,
  purple,
  grey,
}

Color getColor({String strColor = 'none', CardColors enumColor}) {
  switch (strColor) {
    case 'yellow':
      return yellow;
    case 'orange':
      return orange;
    case 'pink':
      return pink;
    case 'green':
      return green;
    case 'blue':
      return blue;
    case 'purple':
      return purple;
    case 'grey':
      return grey;
  }
  switch (enumColor) {
    case CardColors.yellow:
      return yellow;
    case CardColors.orange:
      return orange;
    case CardColors.pink:
      return pink;
    case CardColors.green:
      return green;
    case CardColors.blue:
      return blue;
    case CardColors.purple:
      return purple;
    case CardColors.grey:
      return grey;
  }
  throw Error;
}

//Main colors for titles
const letterDarkGrey = Color(0xFF3A3A3A);
const letterLightGrey = Color(0xFF959595);

//background
const containerGrey = Color(0xFBFBFB);

// colors for follow requests
const darkGreen = Color(0xFF00B432);
const red = Color(0xFFFF0000);
