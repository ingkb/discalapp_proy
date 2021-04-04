import 'package:discalapp_proy/pages/Student/Sesiones/Activities/CountImages/CountImages.dart';
import 'package:flutter/material.dart';

import 'Activities/AddingApples/addingApples.dart';
import 'Activities/Operation/mathOperation.dart';


class Actividades {

  ValueChanged<int> pasarActividad;
  Map<int, GlobalKey<MathOperationState>> mathkeys;
  Map<int, GlobalKey<AddingApplesActivityState>> applekeys;
  Map<int, GlobalKey<CountImagesState>> countImgkeys;
  int mathOper;
  int appleActi;
  int countImg;

  //ACTIVIDADES EN ORDEN
  Actividades(int math, int apple,int countim, ValueChanged<int> pasarActividad){ 
    mathkeys = new Map<int,GlobalKey<MathOperationState>>();
    applekeys = new Map<int, GlobalKey<AddingApplesActivityState>>();
    countImgkeys = new Map<int, GlobalKey<CountImagesState>>();
    this.pasarActividad = pasarActividad;
    this.mathOper = math;
    this.appleActi = apple;
    this.countImg = countim;
  }

  List<Widget> getActivities() {

    List<Widget> actividades = [];
    for (int i = 1; i <= mathOper; i++) {
      mathkeys[i] = GlobalKey<MathOperationState>();
      actividades.add(MathOperation( key: mathkeys[i], pasarActividad: pasarActividad));
    }
    for (int i = 1; i <= appleActi; i++) {
      applekeys[i] = GlobalKey<AddingApplesActivityState>();
      actividades.add(AddingApplesActivity( key: applekeys[i], pasarActividad: pasarActividad));
    }
    for (int i = 1; i <= countImg; i++) {
      countImgkeys[i] = GlobalKey<CountImagesState>();
      actividades.add(CountImages( key: countImgkeys[i], pasarActividad: pasarActividad));
    }
    return actividades;
  }
  
  validarResultado(int numero){

    if(numero>0 && numero<=mathOper){
      return mathkeys[numero].currentState.validarResultado();
    }else if(numero<=appleActi+mathOper){
      var numer = numero-mathOper;
      return applekeys[numer].currentState.validarResultado();
    }else if(numero<=countImg+appleActi+mathOper){
      var numer = numero-mathOper-appleActi;
      return countImgkeys[numer].currentState.validarResultado();
    }
  }
}
