import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:discalapp_proy/constants.dart';


class MultipliActivity1 extends StatefulWidget {
  MultipliActivity1({Key key}) : super(key: key);

  @override
  _MultipliActivity1State createState() => _MultipliActivity1State();
}
class _MultipliActivity1State extends StatelessWidget {
 
  Color colorOPT1 = kAlumnColor;
  Color colorOPT2 = kAlumnColor;
  double borderOPT1 = 1;
  double borderOPT2 = 1;
 
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
        width: double.infinity,
        child:Column(
         Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Text("Realiza la siguiente multiplicacion",textAlign:TextAlign.center,
            style: TextStyle(fontSize: 22, color: Colors.blue[700], fontWeight: FontWeight.w500)
          ),
         ),
      )

      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.blue[900].withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(2, 5), // changes position of shadow
        ),
      ],
    ),
      )
    );
  }
}