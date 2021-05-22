import 'package:discalapp_proy/Services/student_service.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/pages/Teacher/Results/student_sesionslist_page.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class StudentListPage extends StatefulWidget {
  StudentListPage({Key? key, required this.classcode}) : super(key: key);
  final String? classcode;
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  late StudentService _studentService;
  @override
  void initState() {
    _studentService = new StudentService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTeacherColor,
        title: Text('Estudiantes'),
      ),
      body: createListStudents(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await Navigator.pushNamed(context, 'addclasses');
          // setState(() {});
        },
        backgroundColor: kTeacherColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget createListStudents() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<SearchStudentsResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
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
        if (snapshot.data != null) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.students!.isEmpty) {
            print('lista empty');
            return emptyList();
          }
          return ListView(
            children: listStudents(snapshot.data!.students!),
          );
        } else {
          print('data null');
          return Container();
        }
      },
      future: _studentService.getClassStudents(widget.classcode!),
    );
  }

  List<Widget> listStudents(List<Student> lista) {
    final List<Widget> clases = [];

    lista.forEach((student) {
      final widgetCard = Card(
        elevation: 10,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text('Nombre: ' + student.name!),
          trailing: 
           ElevatedButton(
                      onPressed: () 
                      async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentSesionsPage(student: student),
                          ),
                        );
                        setState(() {});
                      }
                      ,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal:1),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      child: Icon(Icons.search, color: Colors.blue, size: 30,),
                    )
          ,
          subtitle: Text("Edad: " + student.age.toString()),
        ),
      );

      clases..add(widgetCard)..add(Divider());
    });
    return clases;
  }

  Widget emptyList() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "No se ha registrado ningun alumno",
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
