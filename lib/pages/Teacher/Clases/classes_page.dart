import 'dart:ui';

import 'package:discalapp_proy/Services/classes_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/classgroup_model.dart';
import 'package:discalapp_proy/pages/Teacher/Clases/class_detail_page.dart';
import 'package:discalapp_proy/pages/Teacher/Results/student_list_page.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:flutter/material.dart';

class ClassesPage extends StatefulWidget {
  ClassesPage({Key? key}) : super(key: key);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  late ClassgroupService classgroupService;
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    classgroupService = new ClassgroupService();
    super.initState();
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
        onPressed: () async {
          await Navigator.pushNamed(context, 'addclasses');
          setState(() {});
        },
        backgroundColor: kTeacherColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget crearListaClases() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<SearchAllClassgroupResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image(
              image: AssetImage('assets/images/loadinggreen.gif'),
              width: 100,
            ),
          );
        }
        if (snapshot.data != null) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.classgroups!.isEmpty) {
            print('lista empty');
            return emptyList();
          }
          return ListView(
            children: listaClassgroups(snapshot.data!.classgroups!),
          );
        } else {
          print('data null');
          return Container();
        }
      },
      future: classgroupService.getAllClassgroup(prefs.teacherUserId),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: Row(
                  children: [
                    Text(
                      clase.name!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                height: 35,
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
                  Text('Código: ' + clase.code!,
                      style:
                          TextStyle(fontSize: 18)),
                  Expanded(child: SizedBox()),
                  Container(
                    width: 50,
                    margin: EdgeInsets.only(right: 2),
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentListPage(classcode: clase.code),
                          ),
                        );
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal:1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      child: Icon(Icons.search, color: Colors.green),
                    ),
                  ),
                  Container(
                    width: 50,
                    margin: EdgeInsets.only(right: 2),
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ClassDetailPage(code: clase.code),
                          ),
                        );
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal:1),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      child: Icon(Icons.edit, color: Colors.blue),
                    ),
                  ),
                  Container(
                    width: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          classgroupService
                              .deleteClassgroup(clase.code!)
                              .then((value) {
                            setState(() {});
                          });
                        },
                        child: Icon(Icons.delete, color: Colors.red),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal:1),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )),
                  ),
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

  Widget emptyList() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "No has creado ninguna clase aun",
        style: TextStyle(
            color: kTeacherColor, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      Center(
          child: Image(
        image: AssetImage('assets/images/emptygif.gif'),
      )),
    ]);
  }
}
