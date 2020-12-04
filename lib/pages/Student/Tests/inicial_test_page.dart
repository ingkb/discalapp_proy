import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/pages/Student/Tests/Activities/CompareQuantities/compare1_widget.dart';
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
      appBar: AppBar(title: Text('Test Inicial'),),
      backgroundColor: kAlumnColor,
      body: Column(
        children: [
          ProgressBar(porcentaje: 0.8),
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
    
    return CompareActivity1();
  }
}