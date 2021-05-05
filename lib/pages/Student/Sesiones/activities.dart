import 'dart:math';

import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/CountImages/CountImages.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/Dices/DicesActivity.dart';
import 'package:discalapp_proy/pages/Student/baseActivity.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Activities/Proprieties/asociativeProprieties.dart';
import 'Activities/AddingApples/addingApples.dart';
import 'Activities/NumbersWritting/numberWrite.dart';
import 'Activities/Operation/mathOperation.dart';

class Actividades {
  ValueChanged<int> pasarActividadfn;
  Map<int, GlobalKey<BaseActivity>> keys;

  int mathOper; //Suma, resta, multi
  int appleActi; //suma
  int countImg; // conteo
  int numWrite; //escritura
  int asociative; // suma, multi
  int dicesnum; // conteo

  int totalActividades = 20;
  List<Widget> actividades;
  int numActual;

  Actividades(ValueChanged<int> pasarActividad) {
    keys = new Map<int, GlobalKey<BaseActivity>>();
    this.pasarActividadfn = pasarActividad;
    this.numActual = 0;
    mathOper=0; 
    appleActi=0;
    countImg=0; 
    numWrite=0; 
    asociative=0;
    dicesnum=0; 
  }

  setActivitiesNumbers(List<ActivityResult> activities) {
    int totalErrores = 0;
    activities.forEach((acti) {
      if (acti.resultado == false) {
        totalErrores++;
        sumarActivity(acti.area);
      }
    });
    var restante = this.totalActividades - totalErrores;
    int numbase = restante ~/ 5;
    if (numbase >= 1) {
      for (int i = 0; i < numbase; i++) {
        sumarActivity(Areas.conteo);
        sumarActivity(Areas.escritura);
        sumarActivity(Areas.suma);
        sumarActivity(Areas.multiplicacion);
        sumarActivity(Areas.resta);
      }
    } else {
      for (int i = 0; i < restante; i++) {
        sumarActivity(Areas.suma);
      }
    }
  }

  sumarActivity(String area) {
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
      countImg++;
    }
    if (area == Areas.escritura) {
      numWrite++;
    }
    if(area == Areas.rectaNumerica){
      appleActi++;
    }
    if(area == Areas.comparacion){
      dicesnum++;
    }
  }

  crearActividades() {
    actividades = [];
    for (int i = 1; i <= mathOper; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<MathOperationState>();
      actividades.add(MathOperation(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }
    for (int i = 1; i <= appleActi; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<AddingApplesActivityState>();
      actividades.add(AddingApplesActivity(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }
    for (int i = 1; i <= countImg; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<CountImagesState>();
      actividades.add(CountImages(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }
    for (int i = 1; i <= numWrite; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<NumberWriteState>();
      actividades.add(NumberWrite(
          key: keys[numActual],
          pasarActividad: pasarActividadfn,
          indice: numActual));
    }

    for (int i = 1; i <= asociative; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<AsociativePropietState>();
      actividades.add(AsociativeProp(
          key: keys[numActual], pasarActividad: pasarActividadfn));
    }

    for (int i = 1; i <= dicesnum; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<DicesState>();
      actividades.add(DicesActivity(
          key: keys[numActual], pasarActividad: pasarActividadfn));
    }
  }

  List<Widget> getActivities(int n) {
    if (n == 0) {
      return actividades;
    }
    List<Widget> newAcitivites = [];
    for (int i = n; i < actividades.length; i++) {
      newAcitivites.add(actividades[i]);
    }
    return newAcitivites;
  }

  validarResultado(int numero) {
    return keys[numero].currentState.validarResultado();
  }
}
