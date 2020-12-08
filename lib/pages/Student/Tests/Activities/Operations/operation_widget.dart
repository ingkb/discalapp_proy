import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:discalapp_proy/constants.dart';
import 'dart:math';
import 'operation1_list.dart';


class OperationActivity extends StatefulWidget {

  OperationActivity({Key key}) : super(key: key);
 // final int numero;
  @override
  _OperationActivityState createState() => _OperationActivityState();
}

class _OperationActivityState extends State<OperationActivity> {
  int n1, n2, resultado;
  String multiplicacion;
  String suma;
  String resta;
  String division;

  @override
  Widget build(BuildContext context) {
    _generarNumeros();
   // multiplicacion = operationsActivities[widget.numero][1];
    //suma = operationsActivities[widget.numero][2];
    //resta = operationsActivities[widget.numero][3];
    //multiplicacion = operationsActivities[widget.numero][4];
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text("Realiza la siguiente multiplicacion",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500)),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "$n1 X $n2",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500),
              )),
          Container(
              child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: kAlumnColor, width: 2.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintText: 'respuesta',
              labelText: 'respuesta',
            ),
            onChanged: (valor) {
              setState(() {
                resultado = int.parse(valor);
              });
            },
          ))
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
    ));
  }

  _generarNumeros() {
    int MAX = 100;
    n1 = new Random().nextInt(MAX);
    n2 = new Random().nextInt(MAX);
  }
/*
  bool _validarRespuesta() {
    int repuesta_correcta = n1 * n2;
    if (repuesta_correcta == resultado){
     print("respuesta correcta")
      return true;
    }
    else
      return false;
  }
  */
}
