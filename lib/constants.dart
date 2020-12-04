import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var titleText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 35.0,
    wordSpacing: 5.0,
    shadows: [
      BoxShadow(
        offset: Offset(2, 2),
        spreadRadius: 20.0,
        color: Colors.black,
        blurRadius: 20.0,
      )
    ]);

var subTitleText = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontSize: 15.0,
);

var errorTitle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 25.0,
    wordSpacing: 5.0,
    shadows: [
      BoxShadow(
        offset: Offset(2, 2),
        spreadRadius: 20.0,
        color: Colors.black,
        blurRadius: 20.0,
      )
    ]);
