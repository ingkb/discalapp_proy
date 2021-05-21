import 'package:discalapp_proy/Services/activityResult_service.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../constants.dart';

class StudentSesionsPage extends StatefulWidget {
  StudentSesionsPage({Key key,this.student}) : super(key: key);
  final Student student;
  @override
  _StudentSesionsPageState createState() => _StudentSesionsPageState();
}

class _StudentSesionsPageState extends State<StudentSesionsPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
 // DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: kTeacherColor,
        title: Text('Sesiones de ' + widget.student.name),
      ),
    );
  }
}