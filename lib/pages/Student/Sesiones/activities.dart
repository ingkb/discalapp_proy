import 'package:flutter/material.dart';
import 'package:discalapp_proy/pages/Student/Tests/Activities/CompareQuantities/compare1_widget.dart';

import 'Activities/mathOperation.dart';

Map<int, GlobalKey<MathOperationState>> comparekeys = {
  1: GlobalKey<MathOperationState>(),
  2: GlobalKey<MathOperationState>(),
  3: GlobalKey<MathOperationState>(),
  4: GlobalKey<MathOperationState>(),
  5: GlobalKey<MathOperationState>(),
};

class Actividades {

  Map<int, Widget> activities;

  Actividades(ValueChanged<int> pasarActividad){
    activities = {
      1: MathOperation(numero: 1, key: comparekeys[1], pasarActividad: pasarActividad),
      2: MathOperation(numero: 2, key: comparekeys[2], pasarActividad: pasarActividad),
      3: MathOperation(numero: 3, key: comparekeys[3], pasarActividad: pasarActividad),
      4: MathOperation(numero: 4, key: comparekeys[4], pasarActividad: pasarActividad),
      5: MathOperation(numero: 5, key: comparekeys[5], pasarActividad: pasarActividad)
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
