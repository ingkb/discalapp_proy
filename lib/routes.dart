import 'package:discalapp_proy/pages/Student/Sesiones/sesion1.dart';
import 'package:discalapp_proy/pages/Student/Tests/finish_Page.dart';
import 'package:discalapp_proy/pages/Student/Tests/sesion_Test.dart';
import 'package:discalapp_proy/pages/Student/Tutorials/video_reproducer.dart';
import 'package:discalapp_proy/pages/Student/menu_page.dart';
import 'package:discalapp_proy/pages/Student/register_student_page2.dart';
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

import 'pages/Student/Tutorials/Tutorial_Menu.dart';


Map<String, WidgetBuilder> getRoutes(){

  return <String, WidgetBuilder>{
    '/'               :(BuildContext context) => InitialPage(),
    'registerStudent' :(BuildContext context) => RegisterStudentPage(),
    'registerStudent2' :(BuildContext context) => RegisterStudentPage2(),
    'registerTeacher' :(BuildContext context) => RegisterTeacherPage(),
    'loginStudent'    :(BuildContext context) => LoginStudentPage(), 
    'loginTeacher'    :(BuildContext context) => LoginTeacherPage(), 
    'inprogess'       :(BuildContext context) => InProgressPage(), 
    'classes'         :(BuildContext context) => ClassesPage(),
    'addclasses'      :(BuildContext context) => AddClassgroup(),
    'classdetail'     :(BuildContext context) => ClassDetailPage(),
    'selectclass'     :(BuildContext context) => SelectClassPage(),
    'initialTest'     :(BuildContext context) => SesionTestPage(),
    'menuStudent'     :(BuildContext context) => MenuPage(),
    'sesion1'         :(BuildContext context) => Sesion1(),
    'finish'          :(BuildContext context) => FinishPage(),
    'tutorial'        :(BuildContext context) => TutorialPage(),
    'videoReproducer' :(BuildContext context) => videoReproducer()

  };
}