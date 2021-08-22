import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/models/areaResult_model.dart';
import 'package:discalapp_proy/models/sesion_model.dart';
import 'package:discalapp_proy/shared/Areas.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class StudentSesionResult extends StatefulWidget {
  StudentSesionResult({Key? key, this.sesion}) : super(key: key);
  final Sesion? sesion;
  @override
  _StudentSesionResultState createState() => _StudentSesionResultState();
}

class _StudentSesionResultState extends State<StudentSesionResult> {
  ActivityResultService activityService = new ActivityResultService();
  List<ActivityResult>? activityResults = [];

  List<AreaResult> areasResult = List.generate(
      11, (index) => new AreaResult(0, 0, 0, index.toString(), ''));

  @override
  void initState() {
    super.initState();

    activityService
        .getAllActivityResult(widget.sesion!.id ?? ' ')
        .then((value) {
      setState(() {
        this.activityResults = value.activityResults;
        organize();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kTeacherColor,
          title: Text('Resultados sesion'),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 20, right: 20),
            child: loaderListResults()));
  }

  //Se crean los resultados de area, luego se reparten las actividades dependiendo de donde coincida el area
  organize() {
    areasResult[0].area = Areas.conteo;
    areasResult[1].area = Areas.suma;
    areasResult[2].area = Areas.resta;
    areasResult[3].area = Areas.multiplicacion;
    areasResult[4].area = Areas.comparacion;
    areasResult[5].area = Areas.escritura;
    areasResult[6].area = Areas.rectaNumerica;
    areasResult[7].area = Areas.secuencia;
    areasResult[8].area = Areas.puntos;
    areasResult[9].area = Areas.lineas;
    areasResult[10].area = Areas.menormayor;

    this.activityResults!.forEach((element) {
      for (var i = 0; i < 11; i++) {
        if (areasResult[i].area == element.area) {
          areasResult[i].preguntas++;
          areasResult[i].tiempo += element.tiempo!;
          if (element.resultado! == true) areasResult[i].aciertos++;
        }
      }
    });
  }

  Widget loaderListResults() {
    return FutureBuilder(
      builder:
          (context, AsyncSnapshot<SearchAllActivityResultResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image(
              image: AssetImage('assets/images/loadinggreen.gif'),
              width: 100,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            if (snapshot.data!.activityResults!.isEmpty) {
              print('lista empty');
              return Container();
            }
            this.activityResults = snapshot.data!.activityResults;
            organize();
            return listResults();
        } else {
          print('data null');
          return Container();
        }
      },
      future: activityService.getAllActivityResult(widget.sesion!.id ?? ' '),
    );
  }

  Widget listResults() {
    List<Widget> results = [];

    this.areasResult.forEach((element) {
      double porcenjateNum = 0;
      String porcentaje = "No";
      try {
        porcenjateNum = (element.aciertos / element.preguntas);
        porcentaje = (porcenjateNum * 100).toInt().toString() + '%';
      } catch (e) {}
      if (element.preguntas > 0) {
        Widget temp = Container(
          width: 400,
          height: 60,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(element.area,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: SizedBox()),
                  Text(element.tiempo.toString())
                ],
              ),
              Row(
                children: [
                  barraPorcentaje(porcenjateNum),
                  Container(
                      margin: EdgeInsets.only(left: 4), child: Text(porcentaje))
                ],
              )
            ],
          ),
        );

        results.add(temp);
      }
    });
    return ListView(
      children: results,
    );
  }

  Widget barraPorcentaje(double porcentaje) {
    double maxWidth = 260;
    double progressLenght = (maxWidth * porcentaje);
    return Container(
      height: 22,
      width: maxWidth,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          height: 20,
          width: progressLenght,
          decoration: BoxDecoration(
            color: getColor(porcentaje),
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: getColor(porcentaje).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(1, 2), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(porcentaje) {
    if (porcentaje <= 0.4) {
      return Color(0xFFC53F3F);
    } else if (porcentaje <= 0.65) {
      return Color(0xFF523FC5);
    } else {
      return Color(0xFF3FC544);
    }
  }
}
