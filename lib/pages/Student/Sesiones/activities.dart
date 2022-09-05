import 'dart:math';

import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/CountImages/CountImages.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/Dices/DicesActivity.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/Sequences/sequence.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/SetInLine/setInLine2_widget.dart';
import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Activities/Proprieties/asociativeProprieties.dart';
import 'Activities/AddingApples/addingApples.dart';
import 'Activities/NumbersWritting/numberWrite.dart';
import 'Activities/Operation/mathOperation.dart';

class Actividades {
  ValueChanged<int>? pasarActividadfn;
  late Map<int?, GlobalKey<BaseActivity>> keys;

  int mathOper = 0; //Suma, resta, multi
  int appleActi = 0; //suma
  int countImg = 0; // conteo
  int numWrite = 0; //escritura
  int asociative = 0; // suma, multi
  int dicesnum = 0; // conteo
  int secuennum = 0; // secuencia
  int rectaNum = 0;
  int totalActividades = 20;
  List<Widget>? actividades;
  int numActual = 0;

  Actividades(ValueChanged<int> pasarActividad) {
    keys = new Map<int?, GlobalKey<BaseActivity>>();
    this.pasarActividadfn = pasarActividad;
    this.numActual = 0;
    mathOper = 0;
    appleActi = 0;
    countImg = 0;
    numWrite = 0;
    asociative = 0;
    dicesnum = 0;
    rectaNum = 0;
    secuennum = 0;
  }

  //Asigna el número de actividades que se van a realizar en esta sesion
  setActivitiesNumbers(List<ActivityResult> activities) {
    int totalErrores = 0;

    //Primero busca los errores de la sesion anterior para agregar actividades de esta area 
    //asegurandose que hay un refuerzo de las areas en las que hay mas dificultades 
    activities.forEach((acti) {
      if (acti.resultado! < 0.6) {
        totalErrores++;
        sumarActivity(acti.area);
      }
    });

    //Una vez se aseguro el refuerzo, se llena el resto de actividades de la sesion 
    var restante = this.totalActividades - totalErrores;
    int creadas = 0;
    while (creadas <= restante) {
      sumarActivity(Areas.conteo);
      creadas++;
      if (creadas == restante) break;
      sumarActivity(Areas.escritura);
      creadas++;
      if (creadas == restante) break;
      sumarActivity(Areas.suma);
      creadas++;
      if (creadas == restante) break;
      sumarActivity(Areas.multiplicacion);
      creadas++;
      if (creadas == restante) break;
      sumarActivity(Areas.resta);
      creadas++;
      if (creadas == restante) break;
      sumarActivity(Areas.comparacion);
      creadas++;
      if (creadas == restante) break;
      sumarActivity(Areas.secuencia);
      creadas++;
      if (creadas == restante) break;
      sumarActivity(Areas.rectaNumerica);
      creadas++;
      if (creadas == restante) break;
    }
  }
  // Si existe mas de una actividad para una misma area se escoge al azar 
  // y se suma al numero de actividades que se van a instanciar
  sumarActivity(String? area) {
    var rng = new Random();
    if (area == Areas.suma) {
      int n1 = rng.nextInt(2);
      if (n1 == 0) asociative++;
      if (n1 == 1) appleActi++;
    }
    if (area == Areas.resta) {
      mathOper++;
    }
    if (area == Areas.multiplicacion) {
      mathOper++;
    }
    if (area == Areas.conteo) {
      int n1 = rng.nextInt(5);
      if (n1 >= 2) countImg++;
      if (n1 < 2) dicesnum++;
    }
    if (area == Areas.escritura) {
      numWrite++;
    }
    if (area == Areas.rectaNumerica) {
      rectaNum++;
    }
    if (area == Areas.comparacion) {
      dicesnum++;
    }

    if (area == Areas.secuencia) {
      secuennum++;
    }
  }

  crearActividades() {
    actividades = [];
    for (int i = 1; i <= mathOper; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<MathOperationState>();
      actividades!.add(MathOperation(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }
    for (int i = 1; i <= appleActi; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<AddingApplesActivityState>();
      actividades!.add(AddingApplesActivity(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }
    for (int i = 1; i <= countImg; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<CountImagesState>();
      actividades!.add(CountImages(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }
    for (int i = 1; i <= numWrite; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<NumberWriteState>();
      actividades!.add(NumberWrite(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }

    for (int i = 1; i <= asociative; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<AsociativePropietState>();
      actividades!.add(AsociativeProp(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }

    for (int i = 1; i <= dicesnum; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<DicesState>();
      actividades!.add(DicesActivity(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }

    for (int i = 1; i <= secuennum; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<SequencesActivityState>();
      actividades!.add(SequencesActivity(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }
    
    for (int i = 1; i <= rectaNum; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<SetInLine2State>();
      actividades!.add(SetInLine2(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          numero: i,
          indice: numActual));
    }
  }

  List<Widget>? getActivities(int? n) {
    if (n == 0) {
      return actividades;
    }
    List<Widget> newAcitivites = [];
    for (int i = n!; i < actividades!.length; i++) {
      newAcitivites.add(actividades![i]);
    }
    return newAcitivites;
  }

  validarResultado(int numero) {
    return keys[numero]!.currentState!.validarResultado();
  }
}
