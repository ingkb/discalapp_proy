import 'package:discalapp_proy/pages/Student/Sesiones/sesion1.dart';
import 'package:discalapp_proy/pages/Student/Tests/inicial_test_page.dart';
import 'package:discalapp_proy/pages/Student/Tests/inicial_test_results_page.dart';
import 'package:discalapp_proy/pages/Student/menu_page.dart';
import 'package:discalapp_proy/pages/Student/select_class_page.dart';
import 'package:discalapp_proy/pages/Teacher/Clases/add_class_page.dart';
import 'package:discalapp_proy/pages/Teacher/Clases/class_detail_page.dart';
import 'package:discalapp_proy/pages/Teacher/Clases/classes_page.dart';
import 'package:discalapp_proy/pages/inProgress_page.dart';
import 'package:discalapp_proy/pages/Student/login_student_page.dart';
import 'package:discalapp_proy/pages/Student/register_student_page.dart';
import 'package:discalapp_proy/pages/Teacher/login_teacher_page.dart';
import 'package:discalapp_proy/pages/Teacher/register_teacher_page.dart';
import 'package:discalapp_proy/pages/initial_page.dart';
import 'package:flutter/material.dart';


Map<String, WidgetBuilder> getRoutes(){

  return <String, WidgetBuilder>{
    '/'               :(BuildContext context) => InitialPage(),
    'registerStudent' :(BuildContext context) => RegisterStudentPage(),
    'registerTeacher' :(BuildContext context) => RegisterTeacherPage(),
    'loginStudent'    :(BuildContext context) => LoginStudentPage(), 
    'loginTeacher'    :(BuildContext context) => LoginTeacherPage(), 
    'inprogess'       :(BuildContext context) => InProgressPage(), 
    'classes'         :(BuildContext context) => ClassesPage(),
    'addclasses'      :(BuildContext context) => AddClassgroup(),
    'classdetail'     :(BuildContext context) => ClassDetailPage(),
    'selectclass'     :(BuildContext context) => SelectClassPage(),
    'initialTest'     :(BuildContext context) => InitialTestPage(),
    'initialResult'   :(BuildContext context) => InicialResult(),
    'menuStudent'     :(BuildContext context) => MenuPage(),
    'sesion1'         :(BuildContext context) => Sesion1()
  };
}