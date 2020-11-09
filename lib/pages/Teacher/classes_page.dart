import 'dart:html';

import 'package:flutter/material.dart';

class ClassesPage extends StatefulWidget {
  ClassesPage({Key key}) : super(key: key);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clases'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 40),
        children: [

        ],
      ),

    );
  }


  Widget crearListaClases(){

    return Text('data');
  }
}