import 'package:rezerv/const/colors.dart';
import 'package:flutter/material.dart';

const TextStyle descriptionStyle = TextStyle(
  fontSize: 15,
  color: textLight,
  fontWeight: FontWeight.w200,
  fontFamily: 'PoppinsRegular',
);

const TextStyle mainTextStyle = TextStyle(
  fontSize: 30,
  color: mainBlue,
  fontWeight: FontWeight.w600,
  fontFamily: 'PoppinsSemiBold',
);

const TextStyle secondaryTextStyle = TextStyle(
  fontSize: 20,
  color: bgBlack,
  fontWeight: FontWeight.w600,
  fontFamily: 'PoppinsSemiBold',
);

const TextStyle btnTextStyle = TextStyle(
  fontSize: 25,
  color: bgBlack,
  fontWeight: FontWeight.w400,
  fontFamily: 'PoppinsRegular',
);

const TextStyle regularTextStyle = TextStyle(
  fontSize: 18,
  color: bgBlack,
  fontWeight: FontWeight.w400,
  fontFamily: 'PoppinsRegular',
);

const InputDecoration inputFieldDecoration = InputDecoration(
  hintText: "Email",
  hintStyle: TextStyle(
    color: textLight,
    fontSize: 15,
    fontFamily: 'PoppinsRegular',
  ),
  fillColor: white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: bgBlack, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainBlue, width: 2),
    borderRadius: BorderRadius.all(
      Radius.circular(100),
    ),
  ),
);
