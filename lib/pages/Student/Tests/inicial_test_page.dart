import 'dart:ui';

import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/pages/Student/Tests/Activities/SetInLine/setInLine1_widget.dart';
import 'package:flutter/material.dart';
import 'Activities/CompareQuantities/compare1_widget.dart';
import 'Activities/progress_barr_widget.dart';

class InitialTestPage extends StatefulWidget {
  InitialTestPage({Key key}) : super(key: key);

  @override
  _InitialTestPageState createState() => _InitialTestPageState();
}

class _InitialTestPageState extends State<InitialTestPage> {
  GlobalKey<SetInLine1State> _keySetInLine = GlobalKey();
  GlobalKey<CompareActivity1State> _keyCompare1 = GlobalKey();
  GlobalKey<CompareActivity1State> _keyCompare2 = GlobalKey();
  GlobalKey<CompareActivity1State> _keyCompare3 = GlobalKey();
  GlobalKey<CompareActivity1State> _keyCompare4 = GlobalKey();
  GlobalKey<CompareActivity1State> _keyCompare5 = GlobalKey();
  GlobalKey<CompareActivity1State> _keyCompareLine1 = GlobalKey();
  GlobalKey<CompareActivity1State> _keyCompareLine2 = GlobalKey();
  GlobalKey<CompareActivity1State> _keyCompareLine3 = GlobalKey();
  GlobalKey<CompareActivity1State> _keyCompareLine4 = GlobalKey();
  GlobalKey<CompareActivity1State> _keyCompareLine5 = GlobalKey();
  int actividadActual = 1;
  int numActividades = 11;

  @override
  Widget build(BuildContext context) {

    double porcent = actividadActual/numActividades;
    return Scaffold(
        appBar: AppBar(
          actions: [
            ProgressBar(porcentaje: porcent),
          ],
        ),
        backgroundColor: kAlumnColor,
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            AnimatedSwitcher(
                duration: Duration(milliseconds: 1000),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: getActivities()),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: btnValidar());
  }

  _pasarActividad(int n) {
    setState(() {
      actividadActual++;
    });
  }

  Widget btnValidar() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: RaisedButton(
        elevation: 10,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Text(
          "Validar",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        color: kTeacherColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onPressed: () {
          setState(() {
            validarActividad();
          });
        },
      ),
    );
  }

  //Se llama a la funcion de cada actividad para evaluar
  validarActividad() {
    switch (actividadActual) {
      case 1:  _keySetInLine.currentState.validarResultado(); break;
      case 2:  _keyCompare1.currentState.validarResultado(); break;
      case 3:  _keyCompare2.currentState.validarResultado(); break;
      case 4:  _keyCompare3.currentState.validarResultado(); break;
      case 5:  _keyCompare4.currentState.validarResultado(); break;
      case 6:  _keyCompare5.currentState.validarResultado(); break;
      case 7:  _keyCompareLine1.currentState.validarResultado(); break;
      case 8:  _keyCompareLine2.currentState.validarResultado(); break;
      case 9:  _keyCompareLine3.currentState.validarResultado(); break;
      case 10: _keyCompareLine4.currentState.validarResultado(); break;
      case 11: _keyCompareLine5.currentState.validarResultado(); break;
      default:
        print("default validdar res");
        break;
    }
    if (actividadActual >= numActividades) {
      Navigator.pushReplacementNamed(context, 'initialResult');
    }
  }

  //Funcion para traer la actividad actual
  Widget getActivities() {
    switch (actividadActual) {
      case 1:  return SetInLine1(key: _keySetInLine, pasarActividad: _pasarActividad);break;
      case 2:  return CompareActivity1(numero: 1, key: _keyCompare1, pasarActividad: _pasarActividad);break;
      case 3:  return CompareActivity1(numero: 2, key: _keyCompare2, pasarActividad: _pasarActividad);break;
      case 4:  return CompareActivity1(numero: 3, key: _keyCompare3, pasarActividad: _pasarActividad);break;
      case 5:  return CompareActivity1(numero: 4, key: _keyCompare4, pasarActividad: _pasarActividad);break;
      case 6:  return CompareActivity1(numero: 5, key: _keyCompare5, pasarActividad: _pasarActividad);break;
      case 7:  return CompareActivity1(numero: 6, key: _keyCompareLine1, pasarActividad: _pasarActividad);break;
      case 8:  return CompareActivity1(numero: 7, key: _keyCompareLine2, pasarActividad: _pasarActividad);break;
      case 9:  return CompareActivity1(numero: 8, key: _keyCompareLine3, pasarActividad: _pasarActividad);break;
      case 10: return CompareActivity1(numero: 9, key: _keyCompareLine4, pasarActividad: _pasarActividad);break;
      case 11: return CompareActivity1(numero: 10, key: _keyCompareLine5, pasarActividad: _pasarActividad);break;

      default:
        return SizedBox();
        break;
    }
  }
}
