import 'dart:io';
import 'package:flutter/material.dart';

// Colors
const kBackgroundColor = Color(0xFFE7EEFB);
const kSidebarBackgroundColor = Color(0xFFF1F4FB);
const kCardPopupBackgroundColor = Color(0xFFF5F8FF);
const kPrimaryLabelColor = Color(0xFF242629);
const kSecondaryLabelColor = Color(0xFF797F8A);
const kShadowColor = Color.fromRGBO(72, 76, 82, 0.16);
const kCourseElementIconColor = Color(0xFF17294D);

//login page tag
const String appName = 'Routine Machine';
const String logoTag = 'near.huscarl.loginsample.logo';
const String titleTag = 'near.huscarl.loginsample.title';
// Text Styles
var kLargeTitleStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: kPrimaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var kTitle1Style = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: kPrimaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var kUnselectedTitleStyle = TextStyle(
  fontSize: 22,
  color: Colors.grey,
  fontFamily: 'SF Pro Text',
  fontWeight: FontWeight.bold,
);
var kCardTitleStyle = TextStyle(
  fontFamily: 'SF Pro Text',
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontSize: 22.0,
);
var kTitle2Style = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: kPrimaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var kHeadlineLabelStyle = TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.w800,
  color: kPrimaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var kSubtitleStyle = TextStyle(
  fontSize: 16.0,
  color: kSecondaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var kBodyLabelStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.black,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var kCalloutLabelStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w800,
  color: kPrimaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var kSecondaryCalloutLabelStyle = TextStyle(
  fontSize: 16.0,
  color: kSecondaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var kSearchPlaceholderStyle = TextStyle(
  fontSize: 13.0,
  color: kSecondaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var kSearchTextStyle = TextStyle(
  fontSize: 13.0,
  color: kPrimaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);
var kCardSubtitleStyle = TextStyle(
  fontFamily: 'SF Pro Text',
  color: Color(0xE6FFFFFF),
  fontSize: 13.0,
  decoration: TextDecoration.none,
);
var kCaptionLabelStyle = TextStyle(
  fontSize: 12.0,
  color: kSecondaryLabelColor,
  fontFamily: 'SF Pro Text',
  decoration: TextDecoration.none,
);

// Container decoration styles
var kCardDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(38.0),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.1),
      spreadRadius: 5,
      blurRadius: 10,
      offset: Offset(0, 3), // changes position of shadow
    ),
  ],
);
