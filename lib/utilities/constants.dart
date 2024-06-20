import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Keystone',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Keystone',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Keystone',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kExtraInfoTextStyle= TextStyle(
  fontSize: 30.0,
  fontFamily: 'Keystone',
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
