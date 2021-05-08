import 'dart:math';

import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../botonContinuar.dart';

class MathOperation extends StatefulWidget {
  MathOperation({Key key, this.pasarActividad, this.indice}) : super(key: key);
  final ValueChanged<int> pasarActividad;
  final int indice;
  @override
  MathOperationState createState() => MathOperationState();
}

class MathOperationState extends BaseActivity<MathOperation> {
  int n1, n2, resultado, respuestaCorrecta;
  String operacion;
  String area;
  String texto;
  int valorOperacion;
  ActivityResultService activityResultService;
  bool respondido = false;
  @override
  void initState() {
    _generarNumeros();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return marcoActividad(texto, [
      operacionText(), 
      respuesta(),
      botonContinuar(respondido,widget.pasarActividad)
    ]);
  }

  Widget respuesta(){
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      child: respondido?textoRespuesta():respuestaInput());
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
          onChanged: guardarValor,
        ));
  }

  Widget textoRespuesta() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          "$respuestaCorrecta",
          style: TextStyle(
              fontSize: 40, color: Colors.black, fontWeight: FontWeight.w500),
        ));
  }

  guardarValor(valor) {
    setState(() {
      resultado = int.tryParse(valor);
    });
  }

  _generarNumeros() {
    var rng = new Random();

    var operation = rng.nextInt(3);

    n1 = rng.nextInt(100);
    n2 = rng.nextInt(10);

    switch (operation) {
      case 0:
        area = Areas.suma;
        operacion = "+";
        texto = "Realiza la siguiente SUMA";
        respuestaCorrecta = n1 + n2;
        break;
      case 1:
        area = Areas.resta;
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
        area = Areas.multiplicacion;
        operacion = "x";
        texto = "Realiza la siguiente MULTIPLICACIÓN";
        respuestaCorrecta = n1 * n2;
        break;
      default:
        operacion = ".";
        texto = "...";
    }
  }

//cuando le de validar tiene que salir el mensaje de si gano o no
// bloquear el input con la respuesta correcta (Animaciones luego)
// y luego aparecer un boton para continuar
  @override
  validarResultado() {
    if (respondido == false) {
      respondido = true;
      ActiveUser usuarioResultados =
          Provider.of<ActiveUser>(context, listen: false);
      activityResultService = new ActivityResultService();
      if (resultado == respuestaCorrecta) {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: area,
            resultado: true,
            tiempo: 1));
        showCorrectAnsDialog(context,(){setState(() {});});
      } else {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: area,
            resultado: false,
            tiempo: 1));
        showWrongAnsDialog(context, (){setState(() {});});
      }
    } else {
      if (resultado == respuestaCorrecta) {
        showCorrectAnsDialog(context, (){setState(() {});});
      } else {
        showWrongAnsDialog(context, (){setState(() {});});
      }
    }
  }
}
