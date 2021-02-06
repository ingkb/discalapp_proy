import 'package:flutter/material.dart';
import 'package:discalapp_proy/pages/Student/Tests/Activities/CompareQuantities/compare1_widget.dart';

Map<int, GlobalKey<CompareActivity1State>> comparekeys = {
  1: GlobalKey<CompareActivity1State>(),
  2: GlobalKey<CompareActivity1State>(),
  3: GlobalKey<CompareActivity1State>(),
  4: GlobalKey<CompareActivity1State>(),
  5: GlobalKey<CompareActivity1State>(),
};

class Actividades {

  Map<int, Widget> activities;

  Actividades(ValueChanged<int> pasarActividad){
    activities = {
      1: CompareActivity1(numero: 1, key: comparekeys[1], pasarActividad: pasarActividad),
      2: CompareActivity1(numero: 2, key: comparekeys[2], pasarActividad: pasarActividad),
      3: CompareActivity1(numero: 3, key: comparekeys[3], pasarActividad: pasarActividad),
      4: CompareActivity1(numero: 4, key: comparekeys[4], pasarActividad: pasarActividad),
      5: CompareActivity1(numero: 5, key: comparekeys[5], pasarActividad: pasarActividad)
    };
  }

 

  List<Widget> getActivities() {
    List<Widget> actividades = [];
    for (int i = 1; i < 4; i++) {
      actividades.add(activities[i]);
    }
    return actividades;
  }
}
