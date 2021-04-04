import 'dart:math';

import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'casilla.dart';

class AddingApplesActivity extends StatefulWidget {
  AddingApplesActivity({Key key, this.pasarActividad}) : super(key: key);
  final ValueChanged<int> pasarActividad;

  @override
  AddingApplesActivityState createState() => AddingApplesActivityState();
}

class AddingApplesActivityState extends State<AddingApplesActivity> {

  int n1;
  int n2;
  int resultado;

  @override
  void initState() {
    super.initState();
    generarNumeros();
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
              child: Text("Completa el espacio para que se cumpla la igualdad",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500)),
            ),
            numbersRow(),
            operacionText(),
            
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

   Widget operacionText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "+",
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
                          color: Colors.red,
                          fontWeight: FontWeight.w500),
                    )),
                respuestaInput(),
                Container(
                  width: 200,
                  child: Divider(
                    thickness: 3,
                    color: Colors.orange,
                  )
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      "$resultado",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          ],
        ),
      ],
    );
  }

  generarNumeros(){
    var rng = new Random();
    
    n1 = rng.nextInt(3)+1;
    var num2 = rng.nextInt(4)+1;
    resultado = n1 + num2;
  }

   Widget respuestaInput() {
    return Container(
        width: 100,
        margin: EdgeInsets.only(right: 10, top: 10),
        padding: EdgeInsets.only(right: 30),
        child: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.green[400], fontSize: 40, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
              hintText: '?',
              hintStyle: TextStyle(fontSize: 30, color: Colors.green[400])),
          onChanged: (valor) {
            setState(() {
              n2 = int.parse(valor);
            });
          },
        ));
  }

  Widget numbersRow(){

    List<Widget> casillas = [];
    for(int i=1;i<=n1;i++){
      casillas.add(casilla("$i","roja"));
    }

    for(int i=n1+1;i<=resultado;i++){
      casillas.add(casilla("$i","verde"));
    }

    for(int i=resultado+1;i<=7;i++){
      casillas.add(casilla("$i",""));
    }

    return Container(
      margin: EdgeInsets.only(bottom:20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: casillas,
      ),
    );
  }

  

  validarResultado() {

     ActiveUser usuarioResultados =
        Provider.of<ActiveUser>(context, listen: false);
    if (n2 == resultado-n1) {
      usuarioResultados.addResults(new ActivityResult(
          area: "Suma",
          resultado: true,
          tiempo: 1));
      showAlertDialog(context, "Respuesta correcta", "¡Genial!");
    } else {
      usuarioResultados.addResults(new ActivityResult(
          area: "Suma",
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