import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';

Widget botonContinuar(bool respondido, funcion(int n)?) {
  if (respondido) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          FloatingActionButton(
              backgroundColor: kTeacherColor,
              child: Icon(
                Icons.arrow_right,
                color: Colors.white,
                size: 50,
              ),
              onPressed: () {
                funcion!(0);
              })
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
  return Container();
}
