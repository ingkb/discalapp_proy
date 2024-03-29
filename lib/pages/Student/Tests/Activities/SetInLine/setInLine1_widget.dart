import 'dart:ui';

import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetInLine1 extends StatefulWidget {
  SetInLine1({Key? key, this.pasarActividad, this.numero}) : super(key: key);
  final ValueChanged<int>? pasarActividad;
  final int? numero;
  @override
  SetInLine1State createState() => SetInLine1State();
}

class SetInLine1State extends BaseActivity<SetInLine1> {
  Offset pos = Offset(30, 10);
  Offset pos2 = Offset(30, 110);
  Offset pos3 = Offset(30, 210);

  int numMax = 10;
  int numMin = 0;
  int num1 = 3, num2 = 9, num3 = 4;

  String valor = " a";

  double realPos1 = 360*(0.7);
  double realPos2 = 360*(0.1);
  double realPos3 = 360*(0.6);

  Stopwatch tiempo = Stopwatch();

  @override
  void initState() {
    super.initState();
    if (widget.numero == 2) {
      numMax = 100;
      numMin = 0;
      num1 = 25;
      num2 = 90;
      num3 = 70;
      
      realPos1 = 360*(0.75);
      realPos2 = 360*(0.1);
      realPos3 = 360*(0.3);
    }
    tiempo.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[900]!.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(2, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 20,
            margin: EdgeInsets.only(top: 20, bottom: 10, right: 10, left: 10),
            child: Text("Ubica los números en la línea",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500)),
          ),
          SizedBox(
            height: 500,
            child: Stack(
              children: [
                getDraggableNumber1(),
                getDraggableNumber2(),
                getDraggableNumber3(),
                Positioned(
                    //Barra donde se ubicaran los numeros
                    right: 40,
                    top: 20,
                    child: Column(children: [
                      Text(
                        "$numMax",
                        style: TextStyle(color: Colors.blue[900], fontSize: 25),
                      ),
                      Container(height: 370, width: 5, color: Colors.blue[900]),
                      Text(
                        "$numMin",
                        style: TextStyle(color: Colors.blue[900], fontSize: 25),
                      )
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Offset getNewPosition(Offset offset) {
    double posX = offset.dx - 20;
    double posY = offset.dy - 150;
    if (posX < 10) {
      posX = 10;
    }
    if (posX > 160) {
      posX = 160;
    }
    if (posY > 360) {
      posY = 360;
    }
    if (posY < 10) {
      posY = 10;
    }

    return new Offset(posX, posY);
  }

// Lista de numeros arrastrables
  Widget getDraggableNumber1() {
    return Positioned(
        top: pos.dy,
        left: pos.dx,
        child: Draggable(
          //Elemento arrastrable
          feedback: Container(
            // lo que se ve cuando se sostiene
            height: 110,
            width: 110,
            alignment: Alignment.center,
            child: Text("$num1",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold)),
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage('assets/images/circulonumero.png'))),
          ),
          child: Container(
            //Elemento normal sin ser arrastrado
            height: 100,
            width: 100,
            alignment: Alignment.center,
            child: Text(
              "$num1",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage('assets/images/circulonumero.png'))),
          ),
          childWhenDragging: Container(),

          onDragEnd: (details) {
            setState(() {
              pos = getNewPosition(details.offset);
            });
          },
          data: "num1", dragAnchorStrategy: childDragAnchorStrategy,
        ));
  }

  Widget getDraggableNumber2() {
    return Positioned(
        top: pos2.dy,
        left: pos2.dx,
        child: Draggable(
          //Elemento arrastrable
          feedback: Container(
            // lo que se ve cuando se sostiene
            height: 110,
            width: 110,
            alignment: Alignment.center,
            child: Text("$num2",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.green,
                    fontWeight: FontWeight.bold)),
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage('assets/images/circulonumeroVerde.png'))),
          ),
          child: Container(
            //Elemento normal sin ser arrastrado
            height: 100,
            width: 100,
            alignment: Alignment.center,
            child: Text(
              "$num2",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage('assets/images/circulonumeroVerde.png'))),
          ),
          childWhenDragging: Container(),

          onDragEnd: (details) {
            setState(() {
              pos2 = getNewPosition(details.offset);
            });
          },
          data: "num2", dragAnchorStrategy: childDragAnchorStrategy,
        ));
  }

  Widget getDraggableNumber3() {
    return Positioned(
        top: pos3.dy,
        left: pos3.dx,
        child: Draggable(
          //Elemento arrastrable
          feedback: Container(
            // lo que se ve cuando se sostiene
            height: 110,
            width: 110,
            alignment: Alignment.center,
            child: Text("$num3",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.pink,
                    fontWeight: FontWeight.bold)),
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/circulonumeroFucsia.png'))),
          ),
          child: Container(
            //Elemento normal sin ser arrastrado
            height: 100,
            width: 100,
            alignment: Alignment.center,
            child: Text(
              "$num3",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/circulonumeroFucsia.png'))),
          ),
          childWhenDragging: Container(),

          onDragEnd: (details) {
            setState(() {
              pos3 = getNewPosition(details.offset);
            });
          },
          data: "num3", dragAnchorStrategy: childDragAnchorStrategy,
        ));
  }

  validarDialog() {
    double resul1 = (50 - (pos.dy - realPos1).abs())/50;
    double resul2 = (50 - (pos2.dy - realPos2).abs())/50;
    double resul3 = (50 - (pos3.dy - realPos3).abs())/50;

    resul1 = resul1<0?0:resul1;
    resul2 = resul2<0?0:resul2;
    resul3 = resul3<0?0:resul3;


    double resultado = (resul1 + resul2 + resul3)/3;

    tiempo.stop();
    double tiempoActividad = tiempo.elapsedMilliseconds / 1000;
    ActiveUser usuarioResultados =
        Provider.of<ActiveUser>(context, listen: false);

    usuarioResultados.addResults(new ActivityResult(
          area: Areas.rectaNumerica, resultado: resultado, tiempo: tiempoActividad));
    widget.pasarActividad!(0);
  }

  validarResultado() {
    showConfirmationDialog(context, validarDialog);
  }
}
