import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';


class LoginTeacherPage extends StatefulWidget {
  LoginTeacherPage({Key key}) : super(key: key);

  @override
  _LoginTeacherPageState createState() => _LoginTeacherPageState();
}

class _LoginTeacherPageState extends State<LoginTeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: kTeacherColor,
         title:Text('Login de docente')
       ),
    );
  }
}