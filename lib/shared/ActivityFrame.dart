import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget marcoActividad(String titulo,List<Widget> contenido){
  return Center(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
      padding: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500)),
          ),
          ...contenido
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[900]!.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(2, 5), // changes position of shadow
          ),
        ],
      ),
    ));
}