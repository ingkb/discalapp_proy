import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCorrectAnsDialog(BuildContext context, ValueChanged<int> funcion) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "Siguiente",
      ),
      onPressed: () {
        Navigator.of(context).pop();
        funcion(0);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        '¡Geniaaaal!',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      content: Text(
        'Respuesta Correcta',
        style: TextStyle(fontSize: 18),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
}

showWrongAnsDialog(BuildContext context, ValueChanged<int> funcion) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "Siguiente",
      ),
      onPressed: () {
        Navigator.of(context).pop();
        funcion(0);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        'Ups..',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      content: Text(
        'Respuesta incorrecta',
        style: TextStyle(fontSize: 18),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }