import 'dart:math';
import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AsociativeProp extends StatefulWidget {
  AsociativeProp({Key key, this.pasarActividad, this.indice}) : super(key: key);
  final ValueChanged<int> pasarActividad;
  final int indice;
  @override
  AsociativePropietState createState() => AsociativePropietState();
}

class AsociativePropietState extends BaseActivity<AsociativeProp> {
  int n1,
      n3,
      n2,
      resultado1,
      resultado2,
      resultado3,
      respuestacorrecta1,
      respuestacorrecta2,
      respuestacorrecta3;
  String area;
  ActivityResultService activityResultService;
  @override
  void initState() {
    super.initState();
    _generarNumeros();
  }

  @override
  Widget build(BuildContext context) {
    return marcoActividad("hola", [
      operacionText(),
      respuesta1Input(),
      respuesta2Input(),
      respuesta3Input()
    ]);
  }

  Widget operacionText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "hola",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                )),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "$n1",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "$n2",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "$n3",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          ],
        ),
        Container(
            width: 200,
            child: Divider(
              thickness: 3,
              color: Colors.orange,
            ))
      ],
    );
  }

  Widget respuesta1Input() {
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
              resultado1 = int.tryParse(valor);
            });
          },
        ));
  }

  Widget respuesta2Input() {
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
              resultado2 = int.tryParse(valor);
            });
          },
        ));
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
    n1 = rng.nextInt(100);
    n2 = rng.nextInt(100);
    n3 = rng.nextInt(100);
    respuestacorrecta1 = n1 + n2;
    respuestacorrecta2 = n3;
    respuestacorrecta3 = respuestacorrecta1 + respuestacorrecta2;
  }

  @override
  validarResultado() {
    ActiveUser usuarioResultados =
        Provider.of<ActiveUser>(context, listen: false);
    activityResultService = new ActivityResultService();
    if (resultado1 == respuestacorrecta1 &&
        resultado2 == respuestacorrecta2 &&
        respuestacorrecta3 == resultado3) {
      activityResultService.addActivityResult(new ActivityResult(
          indice: widget.indice,
          sesionId: usuarioResultados.sesionId,
          area: area,
          resultado: true,
          tiempo: 1));
      showCorrectAnsDialog(context, widget.pasarActividad);
    } else {
      activityResultService.addActivityResult(new ActivityResult(
          indice: widget.indice,
          sesionId: usuarioResultados.sesionId,
          area: area,
          resultado: false,
          tiempo: 1));
      showWrongAnsDialog(context, widget.pasarActividad);
    }
  }
}
