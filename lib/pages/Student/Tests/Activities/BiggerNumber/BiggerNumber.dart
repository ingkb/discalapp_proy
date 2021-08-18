import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/Tests/Activities/BiggerNumber/BiggernNumberMap.dart';
import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants.dart';

class BiggerNumberActivity extends StatefulWidget {
  BiggerNumberActivity({Key? key, required this.numero, this.pasarActividad})
      : super(key: key);
  final int numero;
  final ValueChanged<int>? pasarActividad;
  @override
  BiggerNumberActivityState createState() => BiggerNumberActivityState();
}

class BiggerNumberActivityState extends BaseActivity<BiggerNumberActivity> {
  Color colorOPT1 = kAlumnColor;
  Color colorOPT2 = kAlumnColor;
  double borderOPT1 = 0.1;
  double borderOPT2 = 0.1;

  int selectedOption = 3;
  int numOPT1 = 0;
  int numOPT2 = 0;

  Stopwatch tiempo = Stopwatch();

  @override
  void initState() {
    super.initState();
    numOPT1 = biggerNumbers[widget.numero]![0];
    numOPT2 = biggerNumbers[widget.numero]![1];
    tiempo.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 30, right: 30),
      width: double.infinity,
      height: 240,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 50, top: 10, left: 20, right: 20),
            child: Text("Selecciona el número MAYOR",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500)),
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: borderOPT1, color: colorOPT1),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        seleccionarOPT(1);
                      });
                    },
                    child: Text(numOPT1.toString(),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ),
                VerticalDivider(
                  width: 10,
                  thickness: 3,
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: borderOPT2, color: colorOPT2),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        seleccionarOPT(2);
                      });
                    },
                    child: Text(
                      numOPT2.toString(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
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
    );
  }

  seleccionarOPT(int opt) {
    switch (opt) {
      case 1:
        colorOPT1 = kTeacherColor;
        borderOPT1 = 5;
        colorOPT2 = kAlumnColor;
        borderOPT2 = 0.1;
        selectedOption = 1;
        break;
      case 2:
        colorOPT1 = kAlumnColor;
        borderOPT1 = 0.1;
        colorOPT2 = kTeacherColor;
        borderOPT2 = 5;
        selectedOption = 2;
        break;
    }
  }

  validarDialog() {
    ActiveUser usuarioResultados =
        Provider.of<ActiveUser>(context, listen: false);
    tiempo.stop();
    double tiempoActividad = tiempo.elapsedMilliseconds / 1000;
    if (selectedOption == biggerNumbers[widget.numero]![2]) {
      usuarioResultados.addResults(new ActivityResult(
          area: Areas.menormayor, resultado: true, tiempo: tiempoActividad));
    } else {
      usuarioResultados.addResults(new ActivityResult(
          area: Areas.menormayor, resultado: false, tiempo: tiempoActividad));
    }
    widget.pasarActividad!(0);
  }

  validarResultado() {
    showConfirmationDialog(context, validarDialog);
  }
}
