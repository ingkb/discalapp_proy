import 'dart:math';

import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/Dices/DicesMap.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/botonContinuar.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../baseActivity.dart';
import 'Dice.dart';

class DicesActivity extends StatefulWidget {
  DicesActivity({Key? key, this.pasarActividad, this.indice}) : super(key: key);
  final ValueChanged<int>? pasarActividad;
  final int? indice;

  @override
  DicesState createState() => DicesState();
}

class DicesState extends BaseActivity<DicesActivity> {
  int? ejercicio;
  int? respuesta;
  late ActivityResultService activityResultService;

  Stopwatch tiempo = Stopwatch();
  @override
  void initState() {
    getRandom();
    super.initState();
    tiempo.start();
  }

  @override
  Widget build(BuildContext context) {
    return marcoActividad("Escribe que número representan estos dados",
        [dicesRow(), respuestaInput(), botonContinuar(respondido, widget.pasarActividad)]);
  }

  getRandom() {
    var rng = new Random();
    ejercicio = rng.nextInt(20) + 1;
  }

  Widget dicesRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      dice(ejercicio, 0),
      dice(ejercicio, 1),
    ]);
  }

  Widget respuestaInput() {
    return Container(
        width: 100,
        margin: EdgeInsets.only(right: 10, top: 10),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.green[400],
              fontSize: 40,
              fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              hintText: '?',
              hintStyle: TextStyle(fontSize: 30, color: Colors.green[400])),
          onChanged: (valor) {
            setState(() {
              respuesta = int.tryParse(valor);
            });
          },
        ));
  }

  bool respondido= false;
  @override
  validarResultado() {
    if (!respondido) {
      respondido = true;
      ActiveUser usuarioResultados =
          Provider.of<ActiveUser>(context, listen: false);
      
      tiempo.stop();
      double tiempoActividad = tiempo.elapsedMilliseconds / 1000;
      activityResultService = new ActivityResultService();
      if (respuesta.toString() == dicesImages[ejercicio!]![2]) {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: Areas.conteo,
            resultado: 1,
            tiempo: tiempoActividad));
        showCorrectAnsDialog(context, () {setState(() {});});
      } else {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: Areas.conteo,
            resultado: 0,
            tiempo: tiempoActividad));
        showWrongAnsDialog(context, () {setState(() {});});
      }
    }
  }
}
