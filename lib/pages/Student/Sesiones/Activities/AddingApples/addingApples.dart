import 'dart:math';

import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'casilla.dart';

class AddingApplesActivity extends StatefulWidget {
  AddingApplesActivity({Key key, this.pasarActividad,this.indice}) : super(key: key);
  final ValueChanged<int> pasarActividad;
  final int indice;
  @override
  AddingApplesActivityState createState() => AddingApplesActivityState();
}

class AddingApplesActivityState extends BaseActivity<AddingApplesActivity> {

  int n1;
  int n2;
  int resultado;
  ActivityResultService activityResultService;
  @override
  void initState() {
    super.initState();
    generarNumeros();
  }
  @override
  Widget build(BuildContext context) {
    return marcoActividad("Actividad", [
      numbersRow(),
      operacionText()
      ]
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
              n2 = int.tryParse(valor);
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
         activityResultService= new ActivityResultService();
    if (n2 == resultado-n1) {
      activityResultService.addActivityResult(new ActivityResult(
         indice: widget.indice,
          sesionId: usuarioResultados.sesionId,
          area: Areas.suma,
          resultado: true,
          tiempo: 1));
       showCorrectAnsDialog(context, widget.pasarActividad);
    } else {
      activityResultService.addActivityResult(new ActivityResult(
          indice: widget.indice,
          sesionId: usuarioResultados.sesionId,
          area: Areas.suma,
          resultado: false,
          tiempo: 1));
      showWrongAnsDialog(context,  widget.pasarActividad);
    }
  }

}