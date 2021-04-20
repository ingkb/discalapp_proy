import 'dart:math';
import 'package:discalapp_proy/pages/Student/Sesiones/baseActivity.dart';
import 'package:flutter/material.dart';

class AsociativeProp extends StatefulWidget {
  AsociativeProp({Key key, this.pasarActividad}) : super(key: key);
  final ValueChanged<int> pasarActividad;
  @override
  AsociativePropietState createState() => AsociativePropietState();
}

class AsociativePropietState extends BaseActivity<AsociativeProp> {
  int n1, n3, n2;
  @override
  void initState() {
    super.initState();
    _generarNumeros();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      padding: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text("Actividad",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500)),
          ),
          // operacionText(),
          //respuestaInput()
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
    var rng = new Random();

    var operation = rng.nextInt(3);

    n1 = rng.nextInt(100);
    n2 = rng.nextInt(100);
    n3 = rng.nextInt(100);
  }

  @override
  validarResultado() {
    // TODO: implement validarResultado
    throw UnimplementedError();
  }

  _operacion() {}
}
