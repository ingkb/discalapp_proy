import 'dart:math';
import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/botonContinuar.dart';
import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AsociativeProp extends StatefulWidget {
  AsociativeProp({Key? key, this.pasarActividad, this.indice})
      : super(key: key);
  final ValueChanged<int>? pasarActividad;
  final int? indice;
  @override
  AsociativePropietState createState() => AsociativePropietState();
}

class AsociativePropietState extends BaseActivity<AsociativeProp> {
  int? n1,
      n3,
      n2,
      n4,
      resultado1,
      resultado2,
      resultado3,
      respuestacorrecta1,
      respuestacorrecta2,
      respuestacorrecta3;

  String? firstNumber, secondNumber, thirdNumber, fourthNumber;
  late ActivityResultService activityResultService;
  @override
  void initState() {
    super.initState();
    _generarNumeros();
  }

  @override
  // hacer un wd de flecha pero en el dos flechas reutiliza el pt codigo
  Widget build(BuildContext context) {
    return marcoActividad("Propiedad asociativa", [
      Column(children: [
        operacionText(),
        // aqui van las dos primeras flechas
        fila2(),
        respuesta1Input(),
        // aqui va una sola flecha
        fila1(),
        respuesta3Input(),
        botonContinuar(respondido, widget.pasarActividad)
      ])
    ]);
  }

  Widget operacionText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          numero(firstNumber!),
          signo(),
          numero(secondNumber!),
          signo(),
          numero(thirdNumber!),
          signo(),
          numero(fourthNumber!)
        ],
      ),
    );
  }

  Widget respuesta1Input() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          width: 100,
          margin: EdgeInsets.only(right: 15, top: 10),
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                //labelText: 'Respuesta',labelStyle: TextStyle(fontSize: 25)
                hintText: '?',
                hintStyle: TextStyle(fontSize: 20)),
            onChanged: (valor) {
              setState(() {
                resultado1 = int.tryParse(valor);
              });
            },
          )),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "+",
            style: TextStyle(
                fontSize: 35, color: Colors.black, fontWeight: FontWeight.w500),
          )),
      Container(
          width: 100,
          margin: EdgeInsets.only(right: 15, top: 10),
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                //labelText: 'Respuesta',labelStyle: TextStyle(fontSize: 25)
                hintText: '?',
                hintStyle: TextStyle(fontSize: 20)),
            onChanged: (valor) {
              setState(() {
                resultado2 = int.tryParse(valor);
              });
            },
          ))
    ]);
  }

  Widget respuesta3Input() {
    return Container(
        width: 100,
        margin: EdgeInsets.only(right: 15, top: 10),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              //labelText: 'Respuesta',labelStyle: TextStyle(fontSize: 25)
              hintText: 'Respuesta',
              hintStyle: TextStyle(fontSize: 20)),
          onChanged: (valor) {
            setState(() {
              resultado3 = int.tryParse(valor);
            });
          },
        ));
  }

  _generarNumeros() {
    var rng = new Random();
    n1 = rng.nextInt(10);
    n2 = rng.nextInt(10);
    n3 = rng.nextInt(10);
    n4 = rng.nextInt(10);
    respuestacorrecta1 = n1! + n2!;
    respuestacorrecta2 = n3! + n4!;
    respuestacorrecta3 = respuestacorrecta1! + respuestacorrecta2!;
    firstNumber = convertirNumero(n1!);
    secondNumber = convertirNumero(n2!);
    thirdNumber = convertirNumero(n3!);
    fourthNumber = convertirNumero(n4!);
  }

  convertirNumero(int numbe) {
    switch (numbe) {
      case 0:
        return "0.png";
      case 1:
        return "1.png";
      case 2:
        return "2.png";
      case 3:
        return "3.png";
      case 4:
        return "4.png";
      case 5:
        return "5.png";
      case 6:
        return "6.png";
      case 7:
        return "7.png";
      case 8:
        return "8.png";
      case 9:
        return "9.png";

      default:
    }
  }

  bool respondido = false;
  @override
  validarResultado() {
    if (!respondido) {
      respondido = true;
      ActiveUser usuarioResultados =
          Provider.of<ActiveUser>(context, listen: false);
      activityResultService = new ActivityResultService();
      if (resultado1 == respuestacorrecta1 &&
          resultado2 == respuestacorrecta2 &&
          respuestacorrecta3 == resultado3) {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: Areas.suma,
            resultado: true,
            tiempo: 1));
        showCorrectAnsDialog(context, () {
          setState(() {});
        });
      } else {
        activityResultService.addActivityResult(new ActivityResult(
            indice: widget.indice,
            sesionId: usuarioResultados.sesionId,
            area: Areas.suma,
            resultado: false,
            tiempo: 1));
        showWrongAnsDialog(context, () {
          setState(() {});
        });
      }
    }
  }

  Widget numero(String imgUrl) {
    return Container(
        height: 80,
        width: 80,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Image(image: AssetImage('assets/images/numeros/' + imgUrl)));
  }

  Widget signo() {
    return Container(
        height: 80,
        width: 80,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Image(
            image: AssetImage('assets/images/numeros/plus-24844_1280.png')));
  }

  Widget flecha() {
    return Container(
        height: 80,
        width: 80,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Image(image: AssetImage('assets/images/numeros/flecha-12.png')));
  }

  Widget fila1() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: [flecha()]);
  }

  Widget fila2() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [flecha(), flecha()]);
  }
}
