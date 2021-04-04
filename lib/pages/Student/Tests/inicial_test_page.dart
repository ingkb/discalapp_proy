import 'dart:ui';

import 'package:discalapp_proy/Services/areaResult_service.dart';
import 'package:discalapp_proy/Services/sesions_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/areaResult_model.dart';
import 'package:discalapp_proy/models/sesion_model.dart';
import 'package:discalapp_proy/pages/Student/Tests/Activities/SetInLine/setInLine1_widget.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:provider/provider.dart';


import 'Activities/CompareQuantities/compare1_widget.dart';
import 'Activities/Operations/operation_widget.dart';

import 'package:flutter/material.dart';
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
  GlobalKey<OperationActivityState> _keyOperation1 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation2 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation3 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation4 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation5 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation6 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation7 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation8 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation9 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation10 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation11 = GlobalKey();
  GlobalKey<OperationActivityState> _keyOperation12 = GlobalKey();

  int actividadActual = 1;
  int numActividades = 23;
  SesionService sesionService;

  @override
  void initState() {
    super.initState();
    sesionService = new SesionService();
  }
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
        body: ListView(
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

 _pasarActividad(int n) {
    setState(() {
      actividadActual++;
    });
  }
  //Se llama a la funcion de cada actividad para evaluar
  validarActividad() {
    switch (actividadActual) {
      
      case 1:  _keyCompare1.currentState.validarResultado(); break;
      case 2:  _keyCompare2.currentState.validarResultado(); break;
      case 3:  _keyCompare3.currentState.validarResultado(); break;
      case 4:  _keyCompare4.currentState.validarResultado(); break;
      case 5:  _keyCompare5.currentState.validarResultado(); break;
      case 6:  _keyCompareLine1.currentState.validarResultado(); break;
      case 7:  _keyCompareLine2.currentState.validarResultado(); break;
      case 8:  _keyCompareLine3.currentState.validarResultado(); break;
      case 9:  _keyCompareLine4.currentState.validarResultado(); break;
      case 10: _keyCompareLine5.currentState.validarResultado(); break;
      case 11: _keySetInLine.currentState.validarResultado(); break;
      case 12: _keyOperation1.currentState.validarResultado(); break;
      case 13: _keyOperation2.currentState.validarResultado(); break;
      case 14: _keyOperation3.currentState.validarResultado(); break;
      case 15: _keyOperation4.currentState.validarResultado(); break;
      case 16: _keyOperation5.currentState.validarResultado(); break;
      case 17: _keyOperation6.currentState.validarResultado(); break;
      case 18: _keyOperation7.currentState.validarResultado(); break;
      case 19: _keyOperation8.currentState.validarResultado(); break;
      case 20: _keyOperation9.currentState.validarResultado(); break;
      case 21: _keyOperation10.currentState.validarResultado(); break;
      case 22: _keyOperation11.currentState.validarResultado(); break;
      case 23: _keyOperation12.currentState.validarResultado(); break;
      default:
        print("default validar res");
        break;
    }
    //Si ya se cumplieron todas las actividades ve al resultado
    if (actividadActual >= numActividades) {
       acabarSesionActividad();
    }
  }

  acabarSesionActividad(){
    final prefs = new PreferenciasUsuario();
    AreaResultService areaService = new AreaResultService();
    ActiveUser usuarioResultados = Provider.of<ActiveUser>(context, listen: false);
      sesionService.addSesion(
        new Sesion(student: prefs.userId, tipo: 0, fecha: DateTime.now())
        ).then((value) {
          if(value.state==0){
            AreaResult comparePoints= usuarioResultados.getArea('puntos',value.sesionId);
            AreaResult compareLineas= usuarioResultados.getArea('lineas',value.sesionId);
            AreaResult setLine = usuarioResultados.getArea('UbicarLinea',value.sesionId);
            AreaResult sumas= usuarioResultados.getArea('suma',value.sesionId);
            AreaResult restas= usuarioResultados.getArea('resta',value.sesionId);
            AreaResult multiplica = usuarioResultados.getArea('multiplicacion',value.sesionId);

            areaService.addAreaResult(comparePoints).then((value) => null);
            areaService.addAreaResult(compareLineas).then((value) => null);
            areaService.addAreaResult(setLine).then((value) => null);
            areaService.addAreaResult(sumas).then((value) => null);
            areaService.addAreaResult(restas).then((value) => null);
            areaService.addAreaResult(multiplica).then((value) => null);

            
          }
          
          }
        
        );
    
    Navigator.pushReplacementNamed(context, 'initialResult');
      
  }

 //Funcion para traer la actividad actual

  Widget getActivities() {
    switch (actividadActual) {
      
     
      case 1:  return CompareActivity1(numero: 1, key: _keyCompare1, pasarActividad: _pasarActividad);break;
      case 2:  return CompareActivity1(numero: 2, key: _keyCompare2, pasarActividad: _pasarActividad);break;
      case 3:  return CompareActivity1(numero: 3, key: _keyCompare3, pasarActividad: _pasarActividad);break;
      case 4:  return CompareActivity1(numero: 4, key: _keyCompare4, pasarActividad: _pasarActividad);break;
      case 5:  return CompareActivity1(numero: 5, key: _keyCompare5, pasarActividad: _pasarActividad);break;
      case 6:  return CompareActivity1(numero: 6, key: _keyCompareLine1, pasarActividad: _pasarActividad);break;
      case 7:  return CompareActivity1(numero: 7, key: _keyCompareLine2, pasarActividad: _pasarActividad);break;
      case 8:  return CompareActivity1(numero: 8, key: _keyCompareLine3, pasarActividad: _pasarActividad);break;
      case 9:  return CompareActivity1(numero: 9, key: _keyCompareLine4, pasarActividad: _pasarActividad);break;
      case 10: return CompareActivity1(numero: 10, key: _keyCompareLine5, pasarActividad: _pasarActividad);break;
      case 11: return SetInLine1(key: _keySetInLine, pasarActividad: _pasarActividad);break;
      case 12: return OperationActivity(numero: 1, key: _keyOperation1, pasarActividad: _pasarActividad);break;
      case 13: return OperationActivity(numero: 2, key: _keyOperation2, pasarActividad: _pasarActividad);break;
      case 14: return OperationActivity(numero: 3, key: _keyOperation3, pasarActividad: _pasarActividad);break;
      case 15: return OperationActivity(numero: 4, key: _keyOperation4, pasarActividad: _pasarActividad);break;
      case 16: return OperationActivity(numero: 5, key: _keyOperation5, pasarActividad: _pasarActividad);break;
      case 17: return OperationActivity(numero: 6, key: _keyOperation6, pasarActividad: _pasarActividad);break;
      case 18: return OperationActivity(numero: 7, key: _keyOperation7, pasarActividad: _pasarActividad);break;
      case 19: return OperationActivity(numero: 8, key: _keyOperation8, pasarActividad: _pasarActividad);break;
      case 20: return OperationActivity(numero: 9, key: _keyOperation9, pasarActividad: _pasarActividad);break;
      case 21: return OperationActivity(numero: 10, key: _keyOperation10, pasarActividad: _pasarActividad);break;
      case 22: return OperationActivity(numero: 11, key: _keyOperation11, pasarActividad: _pasarActividad);break;
      case 23: return OperationActivity(numero: 12, key: _keyOperation12, pasarActividad: _pasarActividad);break;
      default: return SetInLine1(key: _keySetInLine, pasarActividad: _pasarActividad);break;
    }
}

}
      
    



