import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';

class LoginStudentPage extends StatefulWidget {
 LoginStudentPage({Key key}) : super(key: key);

  @override
  _LoginStudentPageState createState() =>  _LoginStudentPageState();
}

class _LoginStudentPageState extends State<LoginStudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAlumnColor,
        title:Text('Login de estudiante')
      ),
    );
  }
}