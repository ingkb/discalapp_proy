import 'dart:math';

import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/botonContinuar.dart';
import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CountImagesMap.dart';

class CountImages extends StatefulWidget {
  CountImages({Key? key, this.pasarActividad, this.indice}) : super(key: key);
  final ValueChanged<int>? pasarActividad;
  final int? indice;
  @override
  CountImagesState createState() => CountImagesState();
}

class CountImagesState extends BaseActivity<CountImages> {
  num? n1, frutaSelect, n2;
  num? n3;
  int? resultado;
  late ActivityResultService activityResultService;
  bool respondido = false;
  Stopwatch tiempo = Stopwatch();

  @override
  void initState() {
    super.initState();
    generarNumero();
    tiempo.start();
  }

  @override
  Widget build(BuildContext context) {
    return marcoActividad('Escribe el número de frutas que ves', [
      cuadroTabla(),
      
      respuesta(),
      botonContinuar(respondido, widget.pasarActividad)
    ]);
  }

Widget respuesta(){
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      child: respondido?textoRespuesta():respuestaInput());
  }
   Widget textoRespuesta() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          "$n1",
          style: TextStyle(
              fontSize: 40, color: kTeacherColor, fontWeight: FontWeight.w500),
        ));
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
              hintText: '?', hintStyle: TextStyle(fontSize: 35)),
          onChanged: (valor) {
            setState(() {
              resultado = int.tryParse(valor);
            });
          },
        ));
  }

  Widget cuadroTabla() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 40),
        width: 320,
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [piramide(n2), piramide(n3)],
        ),
      ),
    );
  }

  piramide(num? numeroFruta) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: filas(numeroFruta),
    );
  }

  List<Widget> filas(num? numero) {
    List<Widget> filasCajas = [];
    switch (numero) {
      case 2:
        filasCajas.add(fila2());
        break;
      case 3:
        filasCajas.add(fila3());
        break;
      case 4:
        filasCajas.add(fila2());
        filasCajas.add(fila2());
        break;
      case 5:
        filasCajas.add(fila2());
        filasCajas.add(fila3());
        break;
      case 6:
        filasCajas.add(fila2());
        filasCajas.add(fila2());
        filasCajas.add(fila2());
        break;
      case 7:
        filasCajas.add(fila2());
        filasCajas.add(fila2());
        filasCajas.add(fila3());
        break;
      case 8:
        filasCajas.add(fila2());
        filasCajas.add(fila3());
        filasCajas.add(fila3());
        break;
      case 9:
        filasCajas.add(fila3());
        filasCajas.add(fila3());
        filasCajas.add(fila3());
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

  Widget fila1() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: [imagenCaja()]);
  }

  Widget fila2() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [imagenCaja(), imagenCaja()]);
  }

  Widget fila3() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [imagenCaja(), imagenCaja(), imagenCaja()]);
  }

  Widget fila4() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [imagenCaja(), imagenCaja(), imagenCaja(), imagenCaja()]);
  }

  Widget imagenCaja() {
    int posicion = 0;
    return Container(
        height: 60,
        width: 60,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Image(
            image: AssetImage(frutasRepresentar[frutaSelect!]![posicion]),
            fit: BoxFit.contain));
  }

  generarNumero() {
    var rng = new Random();
    n2 = rng.nextInt(7) + 2;
    n3 = rng.nextInt(7) + 2;

    n1 = n2! + n3!;
    frutaSelect = rng.nextInt(3);
  }

  validarResultado() {
    if (!respondido) {
      respondido = true;
      ActiveUser usuarioResultados =
          Provider.of<ActiveUser>(context, listen: false);
      tiempo.stop();
      double tiempoActividad = tiempo.elapsedMilliseconds / 1000;
      activityResultService = new ActivityResultService();
      if (resultado == n1) {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: Areas.conteo,
            resultado: 1,
            tiempo: tiempoActividad));
        showCorrectAnsDialog(context, () {
          setState(() {});
        });
      } else {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: Areas.conteo,
            resultado: 0,
            tiempo: tiempoActividad));
        showWrongAnsDialog(context, () {
          setState(() {});
        });
      }
    }
  }
}
