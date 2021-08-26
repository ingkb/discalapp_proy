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
  Color colorOPT1 = kAlumnColor;
  Color colorOPT2 = kAlumnColor;
  double borderOPT1 = 1;
  double borderOPT2 = 1;

  int selectedOption = 3;

  late String imagen1;
  late String imagen2;

  @override
  void initState() {
    super.initState();
    student = new Student();
  }

  @override
  Widget build(BuildContext context) {
    imagen1 = 'assets/images/avatar1.png';
    imagen2 = 'assets/images/avatar2.png';
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kAlumnColor, title: Text('Registro estudiante')),
      body: Center(
          child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          children: [
            //avatarImage(),
            seleccionSexo(),
            SizedBox(height: 20),
            inputEdad(),
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

  /* Widget inputGrado() {
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
 */

  Widget seleccionSexo() {
    return Container(
        width: double.infinity,
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: borderOPT1, color: colorOPT1)),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      seleccionarOPT(1);
                    });
                  },
                  child: CircleAvatar(
                    child: Image(
                      fit: BoxFit.fitHeight,
                      height: 500,
                      image: AssetImage(imagen1),
                    ),
                  ),
                )),
            SizedBox(height: 30),
            Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: borderOPT2, color: colorOPT2)),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      seleccionarOPT(2);
                    });
                  },
                  child: CircleAvatar(
                    child: Image(
                      fit: BoxFit.fill,
                      height: 200,
                      image: AssetImage(imagen2),
                    ),
                  ),
                ))
          ],
        ));
  }

  seleccionarOPT(int opt) {
    switch (opt) {
      case 1:
        colorOPT1 = kTeacherColor;
        borderOPT1 = 5;
        colorOPT2 = kAlumnColor;
        borderOPT2 = 1;
        selectedOption = 1;
        break;
      case 2:
        colorOPT1 = kAlumnColor;
        borderOPT1 = 1;
        colorOPT2 = kTeacherColor;
        borderOPT2 = 5;
        selectedOption = 2;
        break;
    }
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
