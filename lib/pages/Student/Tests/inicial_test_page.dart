import 'package:discalapp_proy/pages/Student/Tests/Activities/CompareQuantities/compare1_widget.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          progress(),
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


  Widget progress(){
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blueGrey
      ),);
  }
  Widget getActivities(){
    return compare1();
  }
}