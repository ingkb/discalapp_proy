import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/Services/sesions_service.dart';
import 'package:discalapp_proy/models/sesion_model.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/progress_barr_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  int actividadesPreCompletas;
  List<Widget> listaActividades;
  Actividades actividades;
  SesionService sesionService;
  ActivityResultService activityService;
  @override
  void initState() {
    actividadesPreCompletas = 0;
    actividadActual = 1;
    numActividades = 4;
    listaActividades = [Text("...")];
    actividades = new Actividades(3, 0, 0, 1, 0, pasarActividad);
    iniciarSesion();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double porcent = 0;
    int actividadMostrar;
    if (actividadActual != null) {
      porcent = (actividadActual+actividadesPreCompletas) / numActividades;
    }
    if (listaActividades.length != 0) {
      if (actividadActual - 1 < listaActividades.length) {
        actividadMostrar = actividadActual - 1;
      } else {
        actividadMostrar = listaActividades.length - 1;
      }
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

  iniciarSesion() async {
    /* Primero busca que haya una sesion sin terminar guardada
        => si existe entonces guarda el id en memoria 
            luego busca todas las actividades de la sesion y obtiene el indice mayor 
            para poder llamar la actividad correspondiente
        => si no hay sesiones sin terminar entonces crea una nueva y la registra
    */
    ActiveUser usuario = Provider.of<ActiveUser>(context, listen: false);
    sesionService = new SesionService();

    bool sesionSinterminar = false;
    await sesionService.getAllSesion(usuario.student.userId).then((value) => {
          if (value.state == 0)
            {
              value.sesions.forEach((sesionElement) {
                if (sesionElement.estado == false) {
                  usuario.sesionId = sesionElement.id;
                  sesionSinterminar = true;
                }
              })
            }
        });
    if (sesionSinterminar) {
      activityService = new ActivityResultService();

      int actyMax = 0;
      activityService.getAllActivityResult(usuario.sesionId).then((value) {
        value.activityResults.forEach((acti) {
          if (acti.indice > actyMax) {
            actyMax = acti.indice;
          }
        });
        setState(() {
          listaActividades = actividades.getActivities(actyMax);
          actividadesPreCompletas = actyMax;
        });
      });
    } else {
      sesionService
          .addSesion(new Sesion(
              student: usuario.student.userId,
              tipo: 1,
              fecha: DateTime.now(),
              estado: false))
          .then((value) {
        if (value.state == 0) usuario.sesionId = value.sesionId;
      });
      setState(() {
        listaActividades = actividades.getActivities(0);
      });
    }
  }

  validarActividad() {
    actividades.validarResultado(actividadActual+actividadesPreCompletas);
  }

  validarNumActividad() {
    if ((actividadActual+actividadesPreCompletas) > numActividades) {
      acabarSesion();
    }
  }

  acabarSesion() {
    ActiveUser usuario = Provider.of<ActiveUser>(context, listen: false);
    sesionService
        .updateSesion(usuario.sesionId, true)
        .then((value) => Navigator.pushReplacementNamed(this.context, 'menuStudent'));
  }

  pasarActividad(int n) {
    setState(() {
      actividadActual++;
      validarNumActividad();
    });
  }
}
