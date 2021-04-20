import 'dart:math';

import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/baseActivity.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountImages extends StatefulWidget {
  CountImages({Key key, this.pasarActividad}) : super(key: key);
  final ValueChanged<int> pasarActividad;

  @override
  CountImagesState createState() => CountImagesState();
}

class CountImagesState extends BaseActivity<CountImages>{

  int n1;
  int resultado;
  @override
  void initState() {
    super.initState();
    generarNumero();
  }

  @override
  Widget build(BuildContext context) {
    
    return marcoActividad("Actividad", [
      piramide(),
      respuestaInput()
      ]
    );
  }

  Widget respuestaInput() {
    return Container(
        width: 100,
        margin: EdgeInsets.only(right: 0, top: 10),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
              hintText: '?',
              hintStyle: TextStyle(fontSize: 35)),
          onChanged: (valor) {
            setState(() {
              resultado = int.tryParse(valor);
            });
          },
        ));
  }

  piramide(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:filas(n1),
    );
  } 

  List<Widget> filas(int numero){
    List<Widget> filasCajas = [];
    switch(numero){
      case 3:
      filasCajas.add(fila1());
      filasCajas.add(fila2());
      break;
      case 4:
      filasCajas.add(fila1());
      filasCajas.add(fila3());
      break;
      case 5:
      filasCajas.add(fila2());
      filasCajas.add(fila3());
      break;
      case 6:
      filasCajas.add(fila1());
      filasCajas.add(fila2());
      filasCajas.add(fila3());
      break;
      case 7:
      filasCajas.add(fila1());
      filasCajas.add(fila2());
      filasCajas.add(fila4());
      break;
      case 8:
      filasCajas.add(fila1());
      filasCajas.add(fila3());
      filasCajas.add(fila4());
      break;
      case 9:
      filasCajas.add(fila2());
      filasCajas.add(fila3());
      filasCajas.add(fila4());
      break;
      case 10:
      filasCajas.add(fila1());
      filasCajas.add(fila2());
      filasCajas.add(fila3());
      filasCajas.add(fila4());
      break;
    }
    return filasCajas;
  }
  Widget fila1(){
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [imagenCaja()]
    );
  }

  Widget fila2(){
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [imagenCaja(),imagenCaja()]
    );
  }
  Widget fila3(){
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [imagenCaja(),imagenCaja(),imagenCaja()]
    );
  }
  Widget fila4(){
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [imagenCaja(),imagenCaja(),imagenCaja(),imagenCaja()]
    );
  }

  Widget imagenCaja(){
    return Container(
      height: 80,
      width: 80,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Image(image:AssetImage('assets/images/box.png')));
  }

  generarNumero(){
    var rng = new Random();
    n1 = rng.nextInt(8)+3;
  }
   
  validarResultado() {
     ActiveUser usuarioResultados =
        Provider.of<ActiveUser>(context, listen: false);
    if (resultado == n1) {
      usuarioResultados.addResults(new ActivityResult(
          area: "Conteo",
          resultado: true,
          tiempo: 1));
      showCorrectAnsDialog(context, widget.pasarActividad);
    } else {
      usuarioResultados.addResults(new ActivityResult(
          area: "Conteo",
          resultado: false,
          tiempo: 1));
      showWrongAnsDialog(context,  widget.pasarActividad);
    }
  }

 
}
