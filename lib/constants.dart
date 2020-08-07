import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    letterSpacing: 1.0,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
    borderSide: BorderSide(
      color: Colors.teal,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
    borderSide: BorderSide(
      color: Colors.blue,
    ),
  ),
);
