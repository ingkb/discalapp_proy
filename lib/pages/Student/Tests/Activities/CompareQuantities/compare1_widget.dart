import 'dart:ui';

import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'compare1_list.dart';

class CompareActivity1 extends StatefulWidget {
  CompareActivity1({Key key, @required this.numero, this.pasarActividad}) : super(key: key);
  final int numero;
  final ValueChanged<int> pasarActividad;
  @override
  CompareActivity1State createState() => CompareActivity1State();
}

class CompareActivity1State extends State<CompareActivity1> {
  Color colorOPT1 = kAlumnColor;
  Color colorOPT2 = kAlumnColor;
  double borderOPT1 = 1;
  double borderOPT2 = 1;

  int selectedOption = 1;

  String imagen1;
  String imagen2;
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imagen1 = compareActivities[widget.numero][1];
    imagen2 = compareActivities[widget.numero][2];

    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
        width: double.infinity,
        height: 540,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text("Selecciona la imagen con mas ${compareActivities[widget.numero][0]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500)),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: borderOPT1, color: colorOPT1)),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    seleccionarOPT(1);
                  });
                },
                child: Image(
                  fit: BoxFit.fill,
                  height: 180,
                  image: AssetImage(imagen1),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: borderOPT2, color: colorOPT2)),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    seleccionarOPT(2);
                  });
                },
                child: Image(
                  fit: BoxFit.fill,
                  height: 180,
                  image: AssetImage(imagen2),
                ),
              ),
            )
          ],
        ),
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
      
    );
  }

  seleccionarOPT(int opt) {
    switch (opt) {
      case 1:
        colorOPT1 = kTeacherColor;
        borderOPT1 = 5;
        colorOPT2 = kAlumnColor;
        borderOPT2 = 1;
        selectedOption = 1;
        break;
      case 2:
        colorOPT1 = kAlumnColor;
        borderOPT1 = 1;
        colorOPT2 = kTeacherColor;
        borderOPT2 = 5;
        selectedOption = 2;
        break;
    }
  }

  validarResultado(){

    ActiveUser usuarioResultados = Provider.of<ActiveUser>(context,listen:false);

    if(selectedOption == int.parse(compareActivities[widget.numero][3])){
      
      usuarioResultados.addResults(new ActivityResult(area: compareActivities[widget.numero][0],resultado: true, tiempo: 1));
       showCorrectAnsDialog(context, widget.pasarActividad);
    }else{
      usuarioResultados.addResults(new ActivityResult(area:compareActivities[widget.numero][0],resultado: false, tiempo: 1));
       showWrongAnsDialog(context,  widget.pasarActividad);
    }
    
  }
}
