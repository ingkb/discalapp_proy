import 'dart:math';

import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountImages extends StatefulWidget {
  CountImages({Key key, this.pasarActividad}) : super(key: key);
  final ValueChanged<int> pasarActividad;

  @override
  CountImagesState createState() => CountImagesState();
}

class CountImagesState extends State<CountImages>{

  int n1;
  int resultado;
  @override
  void initState() {
    super.initState();
    generarNumero();
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
              margin: EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 30),
              child: Text("¿Qué número representan las imágenes?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500)),
            ),
            
            piramide(),
            respuestaInput()
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
      )
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
      showAlertDialog(context, "Respuesta correcta", "¡Genial!");
    } else {
      usuarioResultados.addResults(new ActivityResult(
          area: "Conteo",
          resultado: false,
          tiempo: 1));
      showAlertDialog(context, "Respuesta incorrecta", "Ups...");
    }
  }

  showAlertDialog(BuildContext context, String mensaje, String titulo) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "Siguiente",
      ),
      onPressed: () {
        Navigator.of(context).pop();
        widget.pasarActividad(0);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        titulo,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      content: Text(
        mensaje,
        style: TextStyle(fontSize: 18),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
