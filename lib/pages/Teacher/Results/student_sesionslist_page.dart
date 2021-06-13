import 'package:discalapp_proy/Services/sesions_service.dart';
import 'package:discalapp_proy/models/sesion_model.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/pages/Teacher/Results/student_sesionResuls_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../constants.dart';

class StudentSesionsPage extends StatefulWidget {
  StudentSesionsPage({Key? key, this.student}) : super(key: key);
  final Student? student;
  @override
  _StudentSesionsPageState createState() => _StudentSesionsPageState();
}

class _StudentSesionsPageState extends State<StudentSesionsPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  SesionService sesionsservice = new SesionService();
  List<Sesion> sesions = [];
  List<Sesion> daySesions = [];
  DateTime? _firstday;
  DateTime _lastday = DateTime.now().add(const Duration(days: 30));
  @override
  void initState() {
    getSesions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kTeacherColor,
          title: Text('Sesiones de ' + widget.student!.name!),
        ),
        body: Column(
          children: [calendario(), sesionesDia()],
        ));
  }

  getSesions() {
    String userid = widget.student?.userId ?? '';
    sesionsservice.getAllSesion(userid).then((value) {
      print(userid);
      sesions = value.sesions ?? [];
      if (sesions.length > 1) {
        DateTime firstday = sesions[0].fecha ?? DateTime.now();
        DateTime lastday = sesions[0].fecha ?? DateTime.now();

        sesions.forEach((sesion) {
          if (sesion.fecha!.compareTo(firstday) < 0) {
            firstday = sesion.fecha!;
          }
          if (sesion.fecha!.compareTo(lastday) > 0) {
            lastday = sesion.fecha!;
          }
        });
        if (firstday.day == lastday.day) {
          lastday.add(const Duration(days: 7));
        }

        setState(() {
          _firstday = firstday;
          _focusedDay = lastday;
          _lastday = lastday;
        });
      }
    });
  }

  Widget calendario() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1, color: Colors.blue)),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: TableCalendar(
          rowHeight: 35,
          calendarStyle: CalendarStyle(
              cellMargin: EdgeInsets.all(0),
              selectedDecoration:
                  BoxDecoration(color: kTeacherColor, shape: BoxShape.circle),
              todayDecoration: BoxDecoration(
                  color: Colors.grey[400], shape: BoxShape.circle),
              todayTextStyle: TextStyle(fontWeight: FontWeight.w600)),
          firstDay: _firstday ?? DateTime.now(),
          lastDay: _lastday  ,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day

              daySesions = [];
              daySesions = _getEventsForDay(selectedDay);
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          locale: 'es_CL',
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
          calendarBuilders: CalendarBuilders(
            singleMarkerBuilder: (context, day, obj) {
              return Center(
                  child: Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 15,
              ));
            },
            selectedBuilder: (context, day, focusedDay) {
              return Center(
                child: Container(
                  height: 40,
                  width: 40,
                  child: Center(child: Text(day.day.toString())),
                  decoration: BoxDecoration(
                      color: kTeacherColor, shape: BoxShape.circle),
                ),
              );
            },
          ),
          eventLoader: _getEventsForDay,
        ),
      ),
    );
  }

  List<Sesion> _getEventsForDay(DateTime day) {
    List<Sesion> sesionsday = [];
    sesions.forEach((sesion) {
      if (sesion.fecha!.day == day.day &&
          sesion.fecha!.month == day.month &&
          sesion.fecha!.year == day.year) {
        sesionsday.add(sesion);
      }
    });
    return sesionsday;
  }

  Widget sesionesDia() {
    List<Widget> sesiones = [];
    daySesions.forEach((element) {
      final sesion = Card(
          child: ListTile(
        title: Text(
          element.estado! ? 'Finalizada' : 'Sin terminar',
          style: TextStyle(
              color: kTeacherColor, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        trailing: ElevatedButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    StudentSesionResult(sesion: element),
              ),
            );
            setState(() {});
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 1),
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          child: Icon(
            Icons.search,
            color: Colors.blue,
            size: 30,
          ),
        ),
        subtitle: Text("Numero: " + element.tipo.toString()),
      ));
      sesiones.add(sesion);
    });

    return sesiones.isEmpty
        ? Container()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 250,
            child: ListView(children: sesiones));
  }
}
