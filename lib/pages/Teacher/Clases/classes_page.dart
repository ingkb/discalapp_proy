

import 'dart:ui';

import 'package:discalapp_proy/Services/classes_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/classgroup_model.dart';
import 'package:discalapp_proy/pages/Teacher/Clases/class_detail_page.dart';
import 'package:flutter/material.dart';

class ClassesPage extends StatefulWidget {
  ClassesPage({Key key}) : super(key: key);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {

  
  ClassgroupService classgroupService;

  @override
  void initState() {
    super.initState();
    classgroupService = new ClassgroupService();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: kTeacherColor,
        title: Text('Clases'),
      ),
      body: crearListaClases(),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, 'addclasses');
        },
        backgroundColor: kTeacherColor,

        child: Icon(Icons.add),
        
      ),

    );
  }


  Widget crearListaClases(){

    return FutureBuilder(
    builder: ( context, AsyncSnapshot<SearchAllClassgroupResponse> snapshot) {
      if (snapshot.connectionState == ConnectionState.none &&
          snapshot.hasData == null) {
        return Container();
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return  Center(
          child: Image(
            image: AssetImage('assets/images/loading1.gif'),
            width: 100,
            ),
        );
      }
      return ListView(
        children: listaClassgroups(snapshot.data.classgroups),
      );
    },
    future: classgroupService.getAllClassgroup(),
  );
  }

  List<Widget> listaClassgroups(List<Classgroup> lista){

    final List<Widget> clases = [];

    lista.forEach((clase) {
      final widgetTemp = ListTile(
        title: Text(clase.name),
        onTap: (){
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClassDetailPage(code: clase.code),
          ),
        );
        },
        trailing: FlatButton(
          onPressed: (){
            classgroupService.deleteClassgroup(clase.code).then((value){
              setState(() {
                
              });
            });
          }, 
          child: Icon(Icons.delete,color: Colors.red,)
        ),
      );

      clases..add(widgetTemp)
            ..add(Divider());
    });
    return clases;
  }
}