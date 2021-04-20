import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textBox(int n,String numero, double borderW, fnSeleccionar(int n)) {
  return Container(
    width: 300,
    height: 60,
    //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: TextButton(
          onPressed: ()=>fnSeleccionar(n),
          child: Text(numero,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont('Bubblegum Sans',
              fontSize: 30, fontWeight: FontWeight.w700, color:Colors.black )),
    ),
    decoration: BoxDecoration(
        border: Border.all(width: borderW, color: kAlumnColor),
        image: DecorationImage(
            image: AssetImage('assets/images/cuadromadera.jpg'),
            fit: BoxFit.fill)),
  );
}
