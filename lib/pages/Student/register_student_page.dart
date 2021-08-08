import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:flutter/material.dart';

class RegisterStudentPage extends StatefulWidget {
  RegisterStudentPage({Key? key}) : super(key: key);

  @override
  _RegisterStudentPageState createState() => _RegisterStudentPageState();
}

class _RegisterStudentPageState extends State<RegisterStudentPage> {
  Student? student;
  bool userVerified = false;

  @override
  void initState() {
    super.initState();
    student = new Student();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kAlumnColor, title: Text('Registro estudiante')),
      body: Center(
          child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          children: [
            avatarImage(),
            SizedBox(height: 20),
            inputEdad(),
            SizedBox(height: 20),
            inputGrado(),
            SizedBox(height: 20),
            inputNombre(),
            SizedBox(height: 20),
            nextPage()
          ],
        ),
      )),
    );
  }

  Widget inputEdad() {
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
          hintText: 'Edad',
          labelText: 'Edad',
          suffixIcon: userVerified ? Icon(Icons.verified_user) : null,
          icon: Icon(Icons.cake)),
      onChanged: (valor) {
        setState(() {
          student!.age = int.parse(valor);
        });
      },
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
          student!.name = valor;
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
          suffixIcon: userVerified ? Icon(Icons.verified_user) : null,
          icon: Icon(Icons.class_)),
      onChanged: (valor) {
        setState(() {
          student!.grade = int.parse(valor);
        });
      },
    );
  }

  Widget avatarImage() {
    return Container(
        width: 200,
        height: 200,
        child: CircleAvatar(
            child: Image(
          image: AssetImage('assets/images/avatar1.png'),
        )));
  }

  Widget nextPage() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            primary: kAlumnColor,
          ),
          onPressed: () {
            if (student!.age != null && student!.name != null)
              Navigator.pushNamed(context, 'registerStudent2',
                  arguments: student);
          },
          child: Text('Siguiente',
              style: TextStyle(fontSize: 25, color: Colors.white))),
    );
  }
}
