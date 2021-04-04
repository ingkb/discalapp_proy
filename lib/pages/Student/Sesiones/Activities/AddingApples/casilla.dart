import 'package:flutter/material.dart';

Widget casilla(String numro,String manzana){
    return Column(children: [
      numero(numro, manzana),
      apple(manzana)
    ]);
  }

  Widget numero(String number, String manzana){

    Color colorNum = Colors.blue[400];
    if(manzana=="roja"){
      colorNum = Colors.red;
    }
    if(manzana == "verde"){
     colorNum = Colors.green[400];
    }
    return Text("$number",
      style: TextStyle(
        color: colorNum,
        fontSize: 35,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget apple(String manzana){

    DecorationImage imag;

    if(manzana == "roja"){
      imag = DecorationImage(image:AssetImage('assets/images/appleRed.png'));
    }
    if(manzana == "verde"){
      imag = DecorationImage(image:AssetImage('assets/images/appleGreen.png'));
    }
    return Container(
      width: 35,
      height: 35,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
      decoration: BoxDecoration(
        image: imag
      ),
    );
  }