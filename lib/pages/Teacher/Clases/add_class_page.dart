import 'package:discalapp_proy/Services/classes_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/classgroup_model.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:flutter/material.dart';

class AddClassgroup extends StatefulWidget {
  AddClassgroup({Key? key}) : super(key: key);

  @override
  _AddClassgroupState createState() => _AddClassgroupState();
}

class _AddClassgroupState extends State<AddClassgroup> {
  late Classgroup classgroup;
  late ClassgroupService classesService;
  bool userVerified = false;
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    classgroup = new Classgroup();
    classesService = new ClassgroupService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: kTeacherColor, title: Text('Crear clase')),
      body: Center(
          child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          children: [
            avatarImage(),
            SizedBox(height: 20),
            inputNombre(),
            SizedBox(height: 20),
            inputGrado(),
            SizedBox(height: 20),
            submitLogin()
          ],
        ),
      )),
    );
  }

  Widget inputNombre() {
    return TextField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: kAlumnColor, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: 'Nombre',
          labelText: 'Nombre',
          suffixIcon: userVerified ? Icon(Icons.verified_user) : null,
          icon: Icon(Icons.person)),
      onChanged: (valor) {
        setState(() {
          classgroup.name = valor;
        });
      },
    );
  }

  Widget inputGrado() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: kAlumnColor, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: 'Grado',
          labelText: 'Grado',
          suffixIcon: userVerified ? Icon(Icons.class_) : null,
          icon: Icon(Icons.class_)),
      onChanged: (valor) {
        setState(() {
          classgroup.grade =  int.tryParse(valor);
        });
      },
    );
  }

  Widget avatarImage() {
    return Container(
        width: 120,
        height: 120,
        child: CircleAvatar(
            child: Image(
          width: 100,
          image: AssetImage('assets/images/books.png'),
        )));
  }

  Widget submitLogin() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            primary: kTeacherColor,
          ),
          onPressed: () {
            _registrarClase();
          },
          child: Text('Crear',
              style: TextStyle(fontSize: 25, color: Colors.white))),
    );
  }

  _registrarClase() {
    classgroup.teacher = prefs.teacherUserId;
    classesService.addClassgroup(classgroup).then((value) {
      setState(() {
        Navigator.pop(context, 'classes');
        //  Navigator.pop(context);
      });
    });
  }
}
