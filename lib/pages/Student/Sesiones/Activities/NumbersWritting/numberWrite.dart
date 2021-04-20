import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/Activities/NumbersWritting/textBox.dart';
import 'package:discalapp_proy/pages/Student/Sesiones/baseActivity.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:discalapp_proy/shared/AnswerDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NumberWrite extends StatefulWidget {
  NumberWrite({Key key,  this.pasarActividad}) : super(key: key);
  final ValueChanged<int> pasarActividad;

  @override
  NumberWriteState createState() => NumberWriteState();
}

class NumberWriteState extends BaseActivity<NumberWrite> {

  double borderWidth1;
  double borderWidth2;
  double borderWidth3;
  int selectedOption;
  int respuesta;

  @override
  void initState() {
    selectedOption = 0;
    borderWidth1 = 1;
    borderWidth2 = 2;
    borderWidth3 = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return marcoActividad("Selecciona la forma correcta de escribir el siguiente número",
      [
        textBox(1,'Ochocientos nueve', borderWidth1, seleccionarTextbox),
        textBox(2,'Novecientos ocho',borderWidth2, seleccionarTextbox),
        textBox(3,'Novecientos ochenta',borderWidth3, seleccionarTextbox)
      ]
    );
  }

  seleccionarTextbox(int n){
    borderWidth1 = 1;
    borderWidth2 = 1;
    borderWidth3 = 1;
    switch (n) {
      case 1:
        borderWidth1 = 5;
        break;
       case 2:
        borderWidth2 = 5;
        break;
       case 3:
        borderWidth3 = 5;
        break;
      default:
    }
    setState(() {
      selectedOption = n;
    });
  }

  @override
  validarResultado() {
    ActiveUser usuarioResultados =
        Provider.of<ActiveUser>(context, listen: false);
    if (selectedOption == respuesta) {
      usuarioResultados.addResults(new ActivityResult(
          area: "Escritura",
          resultado: true,
          tiempo: 1));
      showCorrectAnsDialog(context, widget.pasarActividad);
    } else {
      usuarioResultados.addResults(new ActivityResult(
          area: "Escritura",
          resultado: false,
          tiempo: 1));
      showWrongAnsDialog(context,  widget.pasarActividad);
    }
  }
}