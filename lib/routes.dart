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
  };
}