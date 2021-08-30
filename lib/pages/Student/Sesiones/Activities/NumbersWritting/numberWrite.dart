import 'dart:math';

import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/NumbersWritting/textBox.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/botonContinuar.dart';
import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../mapaNumeroImagen.dart';
import 'numerosARepresentar.dart';

class NumberWrite extends StatefulWidget {
  NumberWrite({Key? key, this.pasarActividad, this.indice}) : super(key: key);
  final ValueChanged<int>? pasarActividad;
  final int? indice;
  @override
  NumberWriteState createState() => NumberWriteState();
}

class NumberWriteState extends BaseActivity<NumberWrite> {
  late double borderWidth1;
  late double borderWidth2;
  late double borderWidth3;
  int? numeroActivi;
  int? selectedOption;
  int? respuesta;
  late ActivityResultService activityResultService;
  Stopwatch tiempo = Stopwatch();

  @override
  void initState() {
    inicializar();
    super.initState();
    tiempo.start();
  }

  @override
  Widget build(BuildContext context) {
    return marcoActividad(
        "Selecciona la forma correcta de escribir el siguiente número", [
      convertirNumeaWidg(),
      textBox(1, numerosARepresentar[numeroActivi!]![1], borderWidth1,
          seleccionarTextbox),
      textBox(2, numerosARepresentar[numeroActivi!]![2], borderWidth2,
          seleccionarTextbox),
      textBox(3, numerosARepresentar[numeroActivi!]![3], borderWidth3,
          seleccionarTextbox),
      botonContinuar(respondido, widget.pasarActividad)
    ]);
  }

  inicializar() {
    this.selectedOption = 0;
    this.borderWidth1 = 0.1;
    this.borderWidth2 = 0.1;
    this.borderWidth3 = 0.1;

    var rng = new Random();
    this.numeroActivi = rng.nextInt(6);
    this.respuesta = int.parse(numerosARepresentar[numeroActivi!]![4]);
  }

  textBoxNumero() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(numerosARepresentar[numeroActivi!]![0],
          style: GoogleFonts.getFont('Bubblegum Sans',
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.deepOrange)),
    );
  }

  Widget convertirNumeaWidg() {
    // leer el char del numero , luego hacer una row que coja ese numero
    String numeroOriginal = numerosARepresentar[numeroActivi!]![0];

    List<Widget> numeros = [];
    for (var i = 0; i < numeroOriginal.length; i++) {
      numeros.add(numero(int.parse(numeroOriginal[i])));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numeros,
    );
  }

  Widget numero(int numero) {
    return Container(
        height: 60,
        width: 60,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: mapaNumeroImagenes[numero]);
  }

  seleccionarTextbox(int n) {
    borderWidth1 = 0.1;
    borderWidth2 = 0.1;
    borderWidth3 = 0.1;
    switch (n) {
      case 1:
        borderWidth1 = 7;
        break;
      case 2:
        borderWidth2 = 7;
        break;
      case 3:
        borderWidth3 = 7;
        break;
      default:
    }
    setState(() {
      selectedOption = n;
    });
  }

  bool respondido = false;
  @override
  validarResultado() {
    if (!respondido) {
      respondido = true;
      ActiveUser usuarioResultados =
          Provider.of<ActiveUser>(context, listen: false);
      tiempo.stop();
      double tiempoActividad = tiempo.elapsedMilliseconds / 1000;
      activityResultService = new ActivityResultService();
      if (selectedOption == respuesta) {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: Areas.escritura,
            resultado: 1,
            tiempo: tiempoActividad));
        showCorrectAnsDialog(context, () {
          setState(() {});
        });
      } else {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: Areas.escritura,
            resultado: 0,
            tiempo: tiempoActividad));
        showWrongAnsDialog(context, () {
          setState(() {});
        });
      }
    }
  }
}
