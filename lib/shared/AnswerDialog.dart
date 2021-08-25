import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCorrectAnsDialog(BuildContext context, validar()) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "Siguiente",
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    style: TextButton.styleFrom(
      elevation: 5,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
      validar();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      '¡Bien hecho!',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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

showWrongAnsDialog(BuildContext context, validar()) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "Siguiente",
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    style: TextButton.styleFrom(
      elevation: 5,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
      validar();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      '¡Oh, no...!',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    ),
    content: Text(
      'Te has equivocado en tu respuesta',
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

showConfirmationDialog(BuildContext context, validar()) {
  Widget okButton = TextButton(
    child: Text(
      "Continuar",
      style: TextStyle(fontSize: 18, color: Colors.green),
    ),
    onPressed: () {
      Navigator.of(context).pop();
      validar();
    },
  );
  Widget cancelButton = TextButton(
    child: Text(
      "No",
      style: TextStyle(fontSize: 18, color: Colors.red),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      '¿Seguro?',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actions: [
      cancelButton,
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

confirmationAnsDialog(BuildContext context, validar()) {
  Widget okButton = TextButton(
    child: Text(
      "Si",
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    style: TextButton.styleFrom(
      elevation: 5,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
      validar();
    },
  );

  Widget noButton = TextButton(
    child: Text(
      "No",
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    style: TextButton.styleFrom(
      elevation: 5,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(
      'Confirmacion',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
    content: Text(
      '¿Estas seguro?',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actions: [okButton, noButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
