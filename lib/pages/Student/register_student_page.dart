import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
  double tam1 = 150;
  double tam2 = 150;
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
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
      ),
    );
  }

  Widget inputNombre() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
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
      ),
    );
  }

  Widget seleccionSexo() {
    return Container(
        width: double.infinity,
        height: 220,
        child: Column(
          children: [
            Text("Seleccione su género", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),),
            SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      height: tam1,
                      width: tam1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(width: borderOPT1, color: colorOPT1)),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            seleccionarOPT(1);
                          });
                        },
                        child: CircleAvatar(
                          radius: (selectedOption == 1 || selectedOption == 3) ? 60 : 30,
                          child: Image(
                            fit: BoxFit.fill,
                            width: 200,
                            image: AssetImage(imagen1),
                          ),
                        ),
                      ),
                    ),
                    selectedOption == 1
                        ? Text("Hombre",
                            style: TextStyle(
                                fontWeight:  FontWeight.w400, fontSize: 18))
                        : Container()
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      height: tam2,
                      width: tam2,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(width: borderOPT2, color: colorOPT2)),
                      child: TextButton(
                        clipBehavior: Clip.hardEdge,
                        onPressed: () {
                          setState(() {
                            seleccionarOPT(2);
                          });
                        },
                        child: CircleAvatar(
                          radius: (selectedOption == 2 || selectedOption == 3)? 60 : 30,
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(imagen2),
                          ),
                        ),
                      ),
                    ),
                    selectedOption == 2
                        ? Text("Mujer",
                            style: TextStyle(
                                fontWeight:  FontWeight.w400, fontSize: 18))
                        : Container()
                  ],
                )
              ],
            ),
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
        tam1 = 150;
        tam2 = 80;
        student!.gender="Hombre";

        break;
      case 2:
        colorOPT1 = kAlumnColor;
        borderOPT1 = 1;
        colorOPT2 = kTeacherColor;
        borderOPT2 = 5;
        selectedOption = 2;
        tam1 = 80;
        tam2 = 150;
        student!.gender="Mujer";
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
            if (student!.age != null && student!.name != null && student!.gender != null)
              Navigator.pushReplacementNamed(context, 'registerStudent2',
                  arguments: student);
          },
          child: Text('Siguiente',
              style: TextStyle(fontSize: 25, color: Colors.white))),
    );
  }
}
