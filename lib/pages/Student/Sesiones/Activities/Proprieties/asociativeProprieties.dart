import 'dart:math';
import 'package:discalapp_proy/pages/Student/Sesiones/baseActivity.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
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
    return marcoActividad("Actividad",[]);
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
