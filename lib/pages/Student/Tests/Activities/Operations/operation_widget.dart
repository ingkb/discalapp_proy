import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:discalapp_proy/constants.dart';
import 'dart:math';
import 'operation1_list.dart';

class OperationActivity extends StatefulWidget {
  OperationActivity({Key key, @required this.numero,this.pasarActividad}) : super(key: key);
  final int numero;
  final ValueChanged<int> pasarActividad;
  @override
  _OperationActivityState createState() => _OperationActivityState();
}

class _OperationActivityState extends State<OperationActivity> {
  int n1, n2, resultado;
  String operacion;
  String texto;
  int valorOperacion;
  @override

  void initState() {
    super.initState();
    _generarNumeros();
  }

  @override
  Widget build(BuildContext context) {
    operacion = operationsActivities[widget.numero][1];
    texto = operationsActivities[widget.numero][0];
    valorOperacion=int.parse(operationsActivities[widget.numero][2]);
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text("$texto",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500)),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "$n1 $operacion $n2",
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

//aun falta terminar la cuestion
  validarResultado() {
    switch (valorOperacion) {
      case 1:
        print("sirve op bro");
        break;
      default:print("ta sirviendo we");
    }
  }

  showAlertDialog(BuildContext context, String mensaje, String titulo) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("Siguiente",),
    onPressed: () { 
        widget.pasarActividad(0);
        Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(titulo,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
    content: Text(mensaje, style: TextStyle(fontSize: 18),),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  }
}
