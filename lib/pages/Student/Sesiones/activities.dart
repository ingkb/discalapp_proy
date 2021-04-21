import 'package:discalapp_proy/pages/Student/Sesiones/Activities/CountImages/CountImages.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/baseActivity.dart';
import 'package:flutter/material.dart';
import 'Activities/Proprieties/asociativeProprieties.dart';
import 'Activities/AddingApples/addingApples.dart';
import 'Activities/NumbersWritting/numberWrite.dart';
import 'Activities/Operation/mathOperation.dart';

class Actividades {
  ValueChanged<int> pasarActividadfn;
  Map<int, GlobalKey<BaseActivity>> keys;

  int mathOper;
  int appleActi;
  int countImg;
  int numWrite;
  int asociative;
  //int nuevaActividad;

  List<Widget> actividades;
  int numActual;

  //ACTIVIDADES EN ORDEN
  //Agregar aqui el numero de actividades nueva
  Actividades(int asociativeCount, int math, int apple, int countim,
      int numWrite, ValueChanged<int> pasarActividad) {
    keys = new Map<int, GlobalKey<BaseActivity>>();
    this.pasarActividadfn = pasarActividad;
    this.mathOper = math;
    this.appleActi = apple;
    this.countImg = countim;
    this.numWrite = numWrite;
    this.asociative = asociativeCount;
    this.numActual = 0;

    this._crearActividades();
  }

  _crearActividades() {
    actividades = [];

    for (int i = 1; i <= mathOper; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<MathOperationState>();
      actividades.add(MathOperation(
          key: keys[numActual], pasarActividad: pasarActividadfn));
    }
    for (int i = 1; i <= appleActi; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<AddingApplesActivityState>();
      actividades.add(AddingApplesActivity(
          key: keys[numActual], pasarActividad: pasarActividadfn));
    }
    for (int i = 1; i <= countImg; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<CountImagesState>();
      actividades.add(
          CountImages(key: keys[numActual], pasarActividad: pasarActividadfn));
    }
    for (int i = 1; i <= numWrite; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<NumberWriteState>();
      actividades.add(
          NumberWrite(key: keys[numActual], pasarActividad: pasarActividadfn));
    }

    for (int i = 1; i <= asociative; i++) {
      this.numActual++;
      keys[numActual] = GlobalKey<AsociativePropietState>();
      actividades.add(
          CountImages(key: keys[numActual], pasarActividad: pasarActividadfn));
    }

    //Copiar un for y reemplazar los campos
    // for (int i = 1; i <= nuevaActividadInt; i++) {
    //   this.numActual++;
    //   keys[numActual] = GlobalKey<NuevaActividadState>();
    //   actividades.add(NuevaActividad( key: keys[numActual], pasarActividad: pasarActividadfn));
    // }
  }

  List<Widget> getActivities() {
    return actividades;
  }

  validarResultado(int numero) {
    return keys[numero].currentState.validarResultado();
  }
}
