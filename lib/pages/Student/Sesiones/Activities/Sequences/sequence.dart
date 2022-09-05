import 'dart:math';

import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../baseActivity.dart';
import '../botonContinuar.dart';
import '../mapaNumeroImagen.dart';
import 'SecuenciaRepresentar.dart';

class SequencesActivity extends StatefulWidget {
  SequencesActivity({Key? key, this.pasarActividad, this.indice})
      : super(key: key);
  final ValueChanged<int>? pasarActividad;
  final int? indice;
  @override
  SequencesActivityState createState() => SequencesActivityState();
}

class SequencesActivityState extends BaseActivity<SequencesActivity> {
  int? numeroActivi;
  late ActivityResultService activityResultService;
  Stopwatch tiempo = Stopwatch();

  Map<int, Offset> posicionesValidas = {
    0: Offset(280, 4),
    1: Offset(142, 135),
    2: Offset(5, 265),
    3: Offset(0, 360),
    4: Offset(95, 360),
    5: Offset(185, 360),
    6: Offset(280, 360),
  };
  Map<int, Offset> posFichas = {
    1: Offset(0, 0),
    2: Offset(0, 0),
    3: Offset(0, 0),
    4: Offset(0, 0),
  };

   Map<int, Function(Offset ofs)> updateFunctions = {};

  int valor1 = 0;
  int valor2 = 0;
  int valor3 = 0;
  int valor4 = 0;
  int valorUltimo = 0;

  List<int> ordenFichas = [1,2,3,4];
  @override
  void initState() {
    var rng = new Random();
    this.numeroActivi = rng.nextInt(5);

    posFichas[1] = posicionesValidas[3]!;
    posFichas[2] = posicionesValidas[4]!;
    posFichas[3] = posicionesValidas[5]!;
    posFichas[4] = posicionesValidas[6]!;

    valor1 = int.parse(secuenciaARepresentar[numeroActivi!]![2]);
    valor2 = int.parse(secuenciaARepresentar[numeroActivi!]![4]);
    valor3 = int.parse(secuenciaARepresentar[numeroActivi!]![6]);
    valorUltimo = int.parse(secuenciaARepresentar[numeroActivi!]![8]);

    valor4 = rng.nextInt(valorUltimo - valor1) + valor1;

    updateFunctions = {
      1:(Offset ofs){posFichas[1] = getNewPosition(ofs);},
      2:(Offset ofs){posFichas[2] = getNewPosition(ofs);},
      3:(Offset ofs){posFichas[3] = getNewPosition(ofs);},
      4:(Offset ofs){posFichas[4] = getNewPosition(ofs);},
    };

    ordenFichas.shuffle();

    tiempo.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return marcoActividad("Ubica las fichas en las casillas, debe sobrar una ficha", [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Column(
                children: [
                  fila1(),
                  flechafila1(),
                  fila2(),
                  flechafila2(),
                  fila3(),
                ],
              ),
            ),
            getDraggableNumber1(ordenFichas[0], valor1, updateFunctions[ordenFichas[0]]!),
            getDraggableNumber1(ordenFichas[1], valor2, updateFunctions[ordenFichas[1]]!),
            getDraggableNumber1(ordenFichas[2], valor3, updateFunctions[ordenFichas[2]]!),
            getDraggableNumber1(ordenFichas[3], valor4, updateFunctions[ordenFichas[3]]!),
          ],
        ),
      ),
      botonContinuar(respondido, widget.pasarActividad)
    ]);
  }

  Offset getNewPosition(Offset offset) {
    double screenW = MediaQuery.of(context).size.width;

    int closestPosition = 0;
    double closestDistance = 9999;

    double posX = offset.dx - 20;
    double posY = offset.dy - 140;
    posicionesValidas.forEach((key, value) {
      double difX = (posX - value.dx).abs();
      double difY = (posY - value.dy).abs();

      double difT = (difX + difY) / 2;
      if (difT < closestDistance) {
        closestDistance = difT;
        closestPosition = key;
      }
    });

    return posicionesValidas[closestPosition]!;
  }

  void updatePos1(Offset ofs) {
    posFichas[1] = getNewPosition(ofs);
  }

  void updatePos2(Offset ofs) {
    posFichas[2] = getNewPosition(ofs);
  }

  void updatePos3(Offset ofs) {
    posFichas[3] = getNewPosition(ofs);
  }

  void updatePos4(Offset ofs) {
    posFichas[4] = getNewPosition(ofs);
  }

  Widget getDraggableNumber1(int id, int valor, Function(Offset) f) {
    Widget fichaV = Container(
      // lo que se ve cuando se sostiene
      height: 60,
      width: 60,
      alignment: Alignment.center,
      child: Text("$valor",
          style: GoogleFonts.fredokaOne(fontSize: 40, color: Colors.white)),
      decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(image: AssetImage('assets/images/ficha.png'))),
    );
    return Positioned(
        top: posFichas[id]!.dy,
        left: posFichas[id]!.dx,
        child: Draggable(
          //Elemento arrastrable
          feedback: fichaV,
          child: fichaV,
          childWhenDragging: Container(),

          onDragEnd: (details) {
            setState(() {
              f(details.offset);
            });
          },
          data: "num1", dragAnchorStrategy: childDragAnchorStrategy,
        ));
  }

  Widget numero(int numero) {
    return Container(height: 40, width: 30, child: mapaNumeroImagenes[numero]);
  }

  Widget flechaDerecha() {
    return Container(
        height: 60,
        width: 60,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Image(
            image: AssetImage('assets/images/numeros/flechaDerecha.png')));
  }

  Widget flechaabajo() {
    return Container(
        height: 60,
        width: 60,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Image(image: AssetImage('assets/images/numeros/flecha-12.png')));
  }

  Widget flechaizquierda() {
    return Container(
        height: 60,
        width: 60,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Image(
            image: AssetImage('assets/images/numeros/flechaIzquierda.png')));
  }

  Widget respuestaInput() {
    return Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color.fromARGB(255, 4, 133, 0)),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: SizedBox.expand());
  }

  Widget fila1() {
    List<Widget> numeros = [];
    int p = 1;
    for (var i = 0; i < 3; i++) {
      if (p != 3) {
        String numeroOriginal = secuenciaARepresentar[numeroActivi!]![i];
        numeros.add(convertirNumeaWidg(numeroOriginal));
        numeros.add(flechaDerecha());
      } else {
        numeros.add(respuestaInput());
      }
      p++;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: numeros,
    );
  }

  Widget convertirNumeaWidg(String numeroOriginal) {
    List<Widget> numeros = [];

    for (var i = 0; i < numeroOriginal.length; i++) {
      numeros.add(numero(int.parse(numeroOriginal[i])));
    }
    return Container(
      width: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: numeros,
      ),
    );
  }

  Widget fila2() {
    int p = 5;
    List<Widget> numeros = [];
    for (var i = 0; i < 3; i++) {
      if (p != 4) {
        String numeroOriginal = secuenciaARepresentar[numeroActivi!]![p];
        numeros.add(convertirNumeaWidg(numeroOriginal));
      } else {
        numeros.add(flechaizquierda());
        numeros.add(respuestaInput());
        numeros.add(flechaizquierda());
      }
      p--;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: numeros,
    );
  }

  Widget fila3() {
    int p = 6;
    List<Widget> numeros = [];
    for (var i = 0; i < 3; i++) {
      if (p != 6) {
        numeros.add(flechaDerecha());
        String numeroOriginal = secuenciaARepresentar[numeroActivi!]![p];
        numeros.add(convertirNumeaWidg(numeroOriginal));
      } else {
        numeros.add(respuestaInput());
      }
      p++;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: numeros,
    );
  }

  Widget separador() {
    return Container(
      width: 140,
    );
  }

  Widget separadormin() {
    return Container(
      width: 15,
    );
  }

  Widget flechafila2() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [flechaabajo(), Expanded(child: Container())]);
  }

  Widget flechafila1() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Expanded(child: Container()), flechaabajo()]);
  }

  bool respondido = false;
  @override
  validarResultado() {

    if (!respondido) {
      respondido = true;
      ActiveUser usuarioResultados =
          Provider.of<ActiveUser>(context, listen: false);
      activityResultService = new ActivityResultService();
      tiempo.stop();
      double tiempoActividad = tiempo.elapsedMilliseconds / 1000;

      if (posFichas[ordenFichas[0]] == posicionesValidas[0] &&
          posFichas[ordenFichas[1]] == posicionesValidas[1] &&
          posFichas[ordenFichas[2]] == posicionesValidas[2]) {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: Areas.secuencia,
            resultado: 1,
            tiempo: tiempoActividad));
        showCorrectAnsDialog(context, () {
          setState(() {});
        });
      } else {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: Areas.secuencia,
            resultado: 0,
            tiempo: tiempoActividad));
        showWrongAnsDialog(context, () {
          setState(() {});
        });
      }
    }
  }
}
