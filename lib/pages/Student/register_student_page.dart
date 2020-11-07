
import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';

class RegisterStudentPage extends StatefulWidget {
  RegisterStudentPage({Key key}) : super(key: key);

  @override
  _RegisterStudentPageState createState() => _RegisterStudentPageState();
}

class _RegisterStudentPageState extends State<RegisterStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: kAlumnColor,
         title: Text('Registro alumno'),
       ),
    );
  }
}