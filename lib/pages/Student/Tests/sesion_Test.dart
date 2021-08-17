import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/Services/sesions_service.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/models/sesion_model.dart';
import 'package:discalapp_proy/shared/progress_barr_widget.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'activities_Test.dart';

class SesionTestPage extends StatefulWidget {
  SesionTestPage({Key? key}) : super(key: key);

  @override
  SesioTestState createState() => SesioTestState();
}

class SesioTestState extends State<SesionTestPage> {
  late int numActividades;
  int actividadActual = 0;
  List<Widget>? listaActividades;
  late ActividadesTest actividades;

  @override
  void initState() {
    actividadActual = 1;
    numActividades = 6; 
    actividades = new ActividadesTest(1, 1, 3, 1, pasarActividad); // 24,2,16,12
    listaActividades = actividades.getActivities();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double porcent = 0;
    int actividadMostrar;
    porcent = actividadActual / numActividades;
    if (actividadActual - 1 < listaActividades!.length) {
      actividadMostrar = actividadActual - 1;
    } else {
      actividadMostrar = listaActividades!.length - 1;
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
              child: listaActividades![actividadMostrar],
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
      acabarSesionActividad();
      Navigator.pushReplacementNamed(this.context, 'finish');
    }
  }

  acabarSesionActividad() {
    ActivityResultService activityService = new ActivityResultService();
    ActiveUser usuarioResultados =
        Provider.of<ActiveUser>(context, listen: false);
    var sesionService = new SesionService();
    sesionService
        .addSesion(new Sesion(
            student: usuarioResultados.student!.userId,
            tipo: ModalRoute.of(context)!.settings.arguments as int,
            fecha: DateTime.now(),
            estado: true))
        .then((value) {
      if (value.state == 0) {
        List<ActivityResult> results = usuarioResultados.resultados ?? [];
        results.forEach((element) {
          element.sesionId = value.sesionId;
        });
        activityService
            .addGroupActivityResult(
                RegisterAcitivityGroupRequest(activities: results))
            .then((value) {
          print(value.message);
        });
      }
    });
  }

  pasarActividad(int n) {
    setState(() {
      actividadActual++;
      validarNumActividad();
    });
  }
}
