import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:flutter/material.dart';
import 'Activities/CompareQuantities/compare1_widget.dart';
import 'Activities/Operations/operation_widget.dart';

import 'Activities/SetInLine/setInLine1_widget.dart';

class ActividadesTest {
  ValueChanged<int>? pasarActividadfn;
  late Map<int?, GlobalKey<BaseActivity>> keys;

  int compareQuant;
  int operations;
  int setInLine;
  //int nuevaActividad;

  List<Widget>? actividades;
  int numActual = 0;

  //ACTIVIDADES EN ORDEN
  //Agregar aqui el numero de actividades nueva
  ActividadesTest(this.compareQuant, this.setInLine, this.operations, 
    ValueChanged<int> pasarActividad) {
    keys = new Map<int?, GlobalKey<BaseActivity>>();
    this.pasarActividadfn = pasarActividad;
    this.numActual = 0;

    this._crearActividades();
  }

  _crearActividades() {
    actividades = [];

    for (int i = 1; i <= compareQuant; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<CompareActivity1State>();
      actividades!.add(CompareActivity1(
          key: keys[numActual], numero: i, pasarActividad: pasarActividadfn));
    }
    
    for (int i = 1; i <= setInLine; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<SetInLine1State>();
      actividades!.add(
          SetInLine1(key: keys[numActual], pasarActividad: pasarActividadfn));
    }

    for (int i = 1; i <= operations; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<OperationActivityState>();
      actividades!.add(OperationActivity(
          key: keys[numActual],numero: i,pasarActividad: pasarActividadfn));
    }
   
    //Copiar un for y reemplazar los campos
    // for (int i = 1; i <= nuevaActividadInt; i++) {
    //   this.numActual++;
    //   keys[numActual] = GlobalKey<NuevaActividadState>();
    //   actividades.add(NuevaActividad( key: keys[numActual], pasarActividad: pasarActividadfn));
    // }
  }

  List<Widget>? getActivities() {
    return actividades;
  }

  validarResultado(int? numero) {
    return keys[numero]!.currentState!.validarResultado();
  }
}
