import 'package:flutter/material.dart';

import 'colors.dart';

final kButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  primary: accentColor,
  elevation: 5,
);

final kAppBarButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  primary: accentColor,
  elevation: 7,
);

final kSendButtonTextStyle = TextStyle(
  color: accentColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

final kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

final kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: accentColor, width: 2.0),
  ),
);

final kTextFieldDecoration = InputDecoration(
  hintText: ' ',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

final kBigTextStyle = TextStyle(
  color: primaryText,
  fontWeight: FontWeight.w700,
  fontSize: 20.0,
);

final kNormalTextStyle = TextStyle(
  color: primaryText,
  fontWeight: FontWeight.w500,
  fontSize: 16.0,
);

final kSmallTextStyle = TextStyle(
  color: primaryText,
  fontWeight: FontWeight.w400,
  fontSize: 13.0,
);
