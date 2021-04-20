import 'dart:math';

import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/baseActivity.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MathOperation extends StatefulWidget {
  MathOperation({Key key, this.pasarActividad}) : super(key: key);
  final ValueChanged<int> pasarActividad;
  @override
  MathOperationState createState() => MathOperationState();
}

class MathOperationState extends BaseActivity<MathOperation> {
  int n1, n2, resultado, respuestaCorrecta;
  String operacion;
  String area;
  String texto;
  int valorOperacion;

  @override
  void initState() {
    super.initState();
    _generarNumeros();
  }

  @override
  Widget build(BuildContext context) {
    return marcoActividad("Actividad",[
        operacionText(),
        respuestaInput()
    ]);
        
  }

  Widget operacionText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "$operacion",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                )),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "$n1",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "$n2",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          ],
        ),
        Container(
            width: 200,
            child: Divider(
              thickness: 3,
              color: Colors.orange,
            ))
      ],
    );
  }

  Widget respuestaInput() {
    return Container(
        width: 100,
        margin: EdgeInsets.only(right: 15, top: 10),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              //labelText: 'Respuesta',labelStyle: TextStyle(fontSize: 25)
              hintText: 'Respuesta',
              hintStyle: TextStyle(fontSize: 20)),
          onChanged: (valor) {
            setState(() {
              resultado = int.tryParse(valor);
            });
          },
        ));
  }

  _generarNumeros() {
    var rng = new Random();

    var operation = rng.nextInt(3);

    n1 = rng.nextInt(100);
    n2 = rng.nextInt(10);

    switch (operation) {
      case 0:
        area = "suma";
        operacion = "+";
        texto = "Realiza la siguiente SUMA";
        respuestaCorrecta = n1 + n2;
        break;
      case 1:
        area = "resta";
        operacion = "-";
        texto = "Realiza la siguiente RESTA";
        if (n1 < n2) {
          var temp = n1;
          n1 = n2;
          n2 = temp;
        }
        respuestaCorrecta = n1 - n2;
        break;
      case 2:
        n1 = rng.nextInt(10);
        n2 = rng.nextInt(10);
        area = "multiplicacion";
        operacion = "x";
        texto = "Realiza la siguiente MULTIPLICACIÓN";
        respuestaCorrecta = n1 * n2;
        break;
      default:
        operacion = ".";
        texto = "...";
    }
  }

  validarResultado() {
    ActiveUser usuarioResultados =
        Provider.of<ActiveUser>(context, listen: false);
    if (resultado == respuestaCorrecta) {
      usuarioResultados.addResults(new ActivityResult(
          area: area,
          resultado: true,
          tiempo: 1));
      showCorrectAnsDialog(context,widget.pasarActividad);
    } else {
      usuarioResultados.addResults(new ActivityResult(
          area: area,
          resultado: false,
          tiempo: 1));
      showWrongAnsDialog(context, widget.pasarActividad);
    }
  }
}
