import 'package:flutter/material.dart';

import 'DicesMap.dart';

Widget dice(int? ejercicio, int img){
  return Container(
    width: 100,
    height: 100,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    decoration: BoxDecoration(
      image:  DecorationImage(image: AssetImage(dicesImages[ejercicio!]![img]), fit: BoxFit.fill)
    ),
  );
}