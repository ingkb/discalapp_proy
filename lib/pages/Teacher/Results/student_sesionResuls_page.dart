import 'package:discalapp_proy/Services/generalArea_service.dart';
import 'package:discalapp_proy/models/areaResult_model.dart';
import 'package:discalapp_proy/models/sesion_model.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class StudentSesionResult extends StatefulWidget {
  StudentSesionResult({Key? key, this.sesion, this.student}) : super(key: key);
  final Sesion? sesion;
  final Student? student;
  @override
  _StudentSesionResultState createState() => _StudentSesionResultState();
}

class _StudentSesionResultState extends State<StudentSesionResult> {
  GeneralAreaService generalAreaService = new GeneralAreaService();
  List<AreaResult>? areaResults = [];
  String resultado = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kTeacherColor,
          title: Text('Resultados sesion'),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 20, right: 10, left: 10),
            child: loaderListResults()));
  }

  Widget initialTestResult() {
    Color backColor =
        (this.resultado == "Bajo") ? Colors.green : Colors.orange;

    String textoDetalle = (this.resultado == "Bajo") 
    ? "Los resultados muestran un desempeño dentro de la normalidad.":
    "Los resultados muestran un desempeño fuera de la normalidad, existe la posibilidad de que el estudiante presente discalculia.";
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Nivel de riesgo:",textAlign: TextAlign.center, style:TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: 150,
            height: 40,
            child: Center(
              child: Text(
                this.resultado,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            decoration: BoxDecoration(color: backColor,
            borderRadius:BorderRadius.all(Radius.circular(20))),
          ),
          Text(textoDetalle,textAlign: TextAlign.center, style:TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
        ],
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom:10),
      decoration: BoxDecoration(
        border: Border.all(color:kTeacherColor,width:1),
        borderRadius: BorderRadius.all(Radius.circular(20))
      )
    );
  }

  Widget loaderListResults() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<CompareGeneralAreaResponse> snapshot) {
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
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data!.areaResults!.isEmpty) {
            print('lista empty');
            return Container(child: Text("empty"),);
          }
          this.areaResults = snapshot.data!.areaResults!;
          this.resultado = snapshot.data!.test!;
          return Column(
            children: [
              widget.sesion!.tipo == 0 ? initialTestResult() : Container(),
              listResults()
            ],
          );
        } else {
          print('data null');
          return Container();
        }
      },
      future: generalAreaService.compararResultado(
          new CompareGeneralAreaRequest(widget.sesion!.id!,
              widget.student!.userId!, widget.sesion!.tipo == 0)),
    );
  }

  Widget listResults() {
    List<Widget> results = [];

    this.areaResults!.forEach((element) {
      double porcenjateNum = 0;
      String porcentaje = "No";
      try {
        porcenjateNum = (element.resultado! / element.preguntas!);
        porcentaje = (porcenjateNum * 100).toInt().toString() + '%';
      } catch (e) {}
      if (element.preguntas! > 0) {
        Widget temp = Container(
          width: 400,
          height: 60,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(element.area!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(child: SizedBox()),
                  Text( element.tiempo!.round().toString()+" seg")
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
    return 
       ListView(
        shrinkWrap: true,
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
