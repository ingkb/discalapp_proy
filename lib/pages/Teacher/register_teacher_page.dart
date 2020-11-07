import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';

class RegisterTeacherPage extends StatefulWidget {
  RegisterTeacherPage({Key key}) : super(key: key);

  @override
  _RegisterTeacherPageState createState() => _RegisterTeacherPageState();
}

class _RegisterTeacherPageState extends State<RegisterTeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: kTeacherColor,
         title: Text('Registro docente'),
       ),
    );
  }
}