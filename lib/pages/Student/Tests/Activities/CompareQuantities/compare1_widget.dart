import 'dart:ui';

import 'package:flutter/material.dart';

Widget compare1(){
  
  return Container(
    width: double.infinity,
    height: 500,
    child: Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 150,
        child: Card(
          elevation: 20,
          color: Colors.red,
          child: Text("aaahhhhhh", style: TextStyle(fontSize: 20)),
        ),
      ),
    ),
  );
}