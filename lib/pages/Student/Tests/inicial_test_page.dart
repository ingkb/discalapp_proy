import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/pages/Student/Tests/Activities/SetInLine/setInLine1_widget.dart';
import '../../Student/Tests/Activities/multiplication/multiply1_widget.dart';
import 'package:flutter/material.dart';

import 'Activities/progress_barr_widget.dart';

class InitialTestPage extends StatefulWidget {
  InitialTestPage({Key key}) : super(key: key);

  @override
  _InitialTestPageState createState() => _InitialTestPageState();
}

class _InitialTestPageState extends State<InitialTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
        ProgressBar(porcentaje: 0.5),
      ],),
      backgroundColor: kAlumnColor,
      body: Column(
        children: [
          
          SizedBox(height: 10,),
          getActivities()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: (){},
      ),


    );
  }


  
  Widget getActivities(){
    
   // return SetInLine1();
    //return CompareActivity1(numero: 2);
    return MultipliActivity1();
  }
}