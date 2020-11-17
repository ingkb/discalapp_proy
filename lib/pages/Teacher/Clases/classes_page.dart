import 'dart:ui';

import 'package:discalapp_proy/Services/classes_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/classgroup_model.dart';
import 'package:discalapp_proy/pages/Teacher/Clases/class_detail_page.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassesPage extends StatefulWidget {
  ClassesPage({Key key}) : super(key: key);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  
  ClassgroupService classgroupService;
  ActiveUser user;
  
  @override
  void initState() {
    super.initState();
    classgroupService = new ClassgroupService();
   
  }

  @override
  Widget build(BuildContext context) {

     user = Provider.of<ActiveUser>(context);
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTeacherColor,
        title: Text('Clases'),
      ),
      body: crearListaClases(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addclasses');
        },
        backgroundColor: kTeacherColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget crearListaClases() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<SearchAllClassgroupResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image(
              image: AssetImage('assets/images/loading1.gif'),
              width: 100,
            ),
          );
        }
         print(snapshot);
        if (snapshot.data != null) {
          return ListView(
            children: listaClassgroups(snapshot.data.classgroups),
          );
        } else {
          return Container();
        }
      },
      future: classgroupService.getAllClassgroup(user.userId),
    );
  }

  List<Widget> listaClassgroups(List<Classgroup> lista) {
    final List<Widget> clases = [];

    lista.forEach((clase) {
      final widgetCard = Card(
        elevation: 10,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      clase.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: kTeacherColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Codigo: ' + clase.code,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Expanded(child: SizedBox()),
                  ButtonTheme(
                    minWidth: 50,
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ClassDetailPage(code: clase.code),
                          ),
                        );
                      },
                      child: Icon(Icons.edit, color: Colors.blue),
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 50,
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: RaisedButton(
                      onPressed: () {
                        classgroupService
                            .deleteClassgroup(clase.code)
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Icon(Icons.delete, color: Colors.red),
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );


      clases..add(widgetCard)..add(Divider());
    });
    return clases;
  }
}
