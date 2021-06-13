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
        body: listResults());
  }

  List<AreaResult> areasResult = List.generate(
      7, (index) => new AreaResult(0, 0, 0, index.toString(), ''));
  organize() {
    areasResult[0].area = Areas.conteo;
    areasResult[1].area = Areas.suma;
    areasResult[2].area = Areas.resta;
    areasResult[3].area = Areas.multiplicacion;
    areasResult[4].area = Areas.comparacion;
    areasResult[5].area = Areas.escritura;
    areasResult[6].area = Areas.rectaNumerica;

    this.activityResults!.forEach((element) {
      switch (element.area) {
        case Areas.conteo:
          _addResult(0, element);
          break;
        case Areas.suma:
          _addResult(1, element);
          break;
        case Areas.resta:
          _addResult(2, element);
          break;
        case Areas.multiplicacion:
          _addResult(3, element);
          break;
        case Areas.comparacion:
          _addResult(4, element);
          break;
        case Areas.escritura:
          _addResult(5, element);
          break;
        case Areas.rectaNumerica:
          _addResult(6, element);
          break;
        default:
      }
    });
  }

  _addResult(int number, ActivityResult element) {
    areasResult[number].preguntas++;
    areasResult[number].tiempo += element.tiempo!;
    if (element.resultado! == true) areasResult[number].aciertos++;
  }

  Widget listResults() {
    List<Widget> results = [];

    this.areasResult.forEach((element) {

      String porcentaje = "No";
      try {
        double value = (element.aciertos / element.preguntas)*100;
        porcentaje = value.toInt().toString() +'%';
      } catch (e) {
      }

      Widget temp = ListTile(
        title: Text(element.area),
        trailing: Text(porcentaje),
      );
      results.add(temp);
    });
    return ListView(
      children: results,
    );
  }
}
