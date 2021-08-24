import 'dart:math';

import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  int? respuesta1, respuesta2, respuesta3;
  int? numeroActivi;
  late ActivityResultService activityResultService;
  Stopwatch tiempo = Stopwatch();

  @override
  void initState() {
    super.initState();
    var rng = new Random();
    this.numeroActivi = rng.nextInt(4);
    tiempo.start();
  }

  @override
  Widget build(BuildContext context) {
    return marcoActividad("Completa la secuencia", [
      fila1(),
      flechafila1(),
      fila2(),
      flechafila2(),
      fila3(),
      botonContinuar(respondido, widget.pasarActividad)
    ]);
  }

  Widget numero(int numero) {
    return Container(
        height: 50,
        width: 40,
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: mapaNumeroImagenes[numero]);
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
        margin: EdgeInsets.only(right: 15, top: 10),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue[700],
              fontSize: 35,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 3.0, color: Colors.red)),
          ),
          onChanged: (valor) {
            setState(() {
              respuesta1 = int.tryParse(valor);
            });
          },
        ));
  }

  Widget respuesta2Input() {
    return Container(
        width: 70,
        margin: EdgeInsets.only(right: 15, top: 10),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue[700],
              fontSize: 35,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 3.0, color: Colors.red)),
          ),
          onChanged: (valor) {
            setState(() {
              respuesta2 = int.tryParse(valor);
            });
          },
        ));
  }

  Widget respuesta3Input() {
    return Container(
        width: 70,
        margin: EdgeInsets.only(right: 15, top: 10),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blue[700],
              fontSize: 35,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 3.0, color: Colors.red)),
          ),
          onChanged: (valor) {
            setState(() {
              respuesta3 = int.tryParse(valor);
            });
          },
        ));
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: numeros,
    );
  }

  Widget convertirNumeaWidg(String numeroOriginal) {
    List<Widget> numeros = [];
    if (numeroOriginal.length == 1) {
      numeros.add(SizedBox(width: 20));
    }

    for (var i = 0; i < numeroOriginal.length; i++) {
      numeros.add(numero(int.parse(numeroOriginal[i])));
    }

    if (numeroOriginal.length == 1) {
      numeros.add(SizedBox(width: 20));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numeros,
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
        numeros.add(respuesta2Input());
        numeros.add(flechaizquierda());
      }
      p--;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
        numeros.add(respuesta3Input());
      }
      p++;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numeros,
    );
  }

  Widget separador() {
    return Container(
      width: 160,
    );
  }

  Widget separadormin() {
    return Container(
      width: 60,
    );
  }

  Widget flechafila2() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [separadormin(), flechaabajo()]);
  }

  Widget flechafila1() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [separador(), separador(), flechaabajo()]);
  }

  bool respondido = false;
  @override
  validarResultado() {
    String respuestacorrecta1 = secuenciaARepresentar[numeroActivi!]![2];
    String respuestacorrecta2 = secuenciaARepresentar[numeroActivi!]![4];
    String respuestacorrecta3 = secuenciaARepresentar[numeroActivi!]![6];
    if (!respondido) {
      respondido = true;
      ActiveUser usuarioResultados =
          Provider.of<ActiveUser>(context, listen: false);
      activityResultService = new ActivityResultService();
      tiempo.stop();
      double tiempoActividad = tiempo.elapsedMilliseconds / 1000;

      if (respuesta1 == int.parse(respuestacorrecta1) &&
          respuesta2 == int.parse(respuestacorrecta2) &&
          respuesta3 == int.parse(respuestacorrecta3)) {
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
