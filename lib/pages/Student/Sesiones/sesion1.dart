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

  int numActividades = 5;
  int actividadActual =1;

  Actividades actividades;

  @override
  void initState() {
    super.initState();
    actividades = new Actividades(pasarActividad);
  }
  @override
  Widget build(BuildContext context) {
    double porcent = 0;
    if(actividadActual!=null){porcent = actividadActual/numActividades;}
    

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
               child: actividades.activities[actividadActual],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: btnValidar()
       );
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

  validarActividad() {
    if (actividadActual >= numActividades) {
      Navigator.pushReplacementNamed(context, 'initialResult');
      return;
    }

    comparekeys[actividadActual].currentState.validarResultado();  
  }

   pasarActividad(int n) {
     setState(() {
      actividadActual++; 
     });
  }
}
