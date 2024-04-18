import 'package:flutter/material.dart';

    const kTempTextStyle = TextStyle(
    fontSize: 100,
    color: Colors.deepPurple);

    const kMessageTextStyle = TextStyle(

    fontSize: 45,
   color: Colors.deepPurple);

const kButtonTextStyle = TextStyle(
    fontSize: 30.0,
    color: Colors.white);

const kConditionTextStyle = TextStyle(fontSize: 100,
color: Colors.deepPurple
);

const kTextFieldInputdecoration = InputDecoration(
  hintText: 'Enter city name',
  hintStyle: TextStyle(color: Colors.grey),
  fillColor: Colors.white,
  filled: true,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide.none),
);
