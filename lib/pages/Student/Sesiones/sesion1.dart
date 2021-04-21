import 'package:discalapp_proy/pages/Student/Tests/Activities/progress_barr_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'activities.dart';

class Sesion1 extends StatefulWidget {
  Sesion1({Key key}) : super(key: key);

  @override
  Sesion1State createState() => Sesion1State();
}

class Sesion1State extends State<Sesion1> {
  int numActividades;
  int actividadActual;
  List<Widget> listaActividades;
  Actividades actividades;

  @override
  void initState() {
    actividadActual = 1;
    numActividades = 2;
    actividades = new Actividades(1, 0, 0, 0, 1, pasarActividad);
    listaActividades = actividades.getActivities();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double porcent = 0;
    int actividadMostrar;
    if (actividadActual != null) {
      porcent = actividadActual / numActividades;
    }
    if (actividadActual - 1 < listaActividades.length) {
      actividadMostrar = actividadActual - 1;
    } else {
      actividadMostrar = listaActividades.length - 1;
    }
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
              child: listaActividades[actividadMostrar],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: btnValidar());
  }

  Widget btnValidar() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          primary: kTeacherColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Validar",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () {
          setState(() {
            validarActividad();
          });
        },
      ),
    );
  }

  validarActividad() {
    actividades.validarResultado(actividadActual);
  }

  validarNumActividad() {
    if (actividadActual > numActividades) {
      Navigator.pushReplacementNamed(this.context, 'menuStudent');
    }
  }

  pasarActividad(int n) {
    setState(() {
      actividadActual++;
      validarNumActividad();
    });
  }
}
