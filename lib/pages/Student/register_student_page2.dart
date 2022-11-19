import 'package:discalapp_proy/Services/register_service.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class RegisterStudentPage2 extends StatefulWidget {
  RegisterStudentPage2({Key? key}) : super(key: key);
  @override
  _RegisterStudentPage2State createState() => _RegisterStudentPage2State();
}

enum Opcion { si, no }

class _RegisterStudentPage2State extends State<RegisterStudentPage2> {
  
  String? userID;
  String? passwd;
  late RegisterService registerService;
  bool userVerified = false;
  Opcion? _character = Opcion.no;
  bool passValid = true;
  bool userValid = true;
  @override
  void initState() {
    super.initState();
   
    registerService = new RegisterService();
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
            SizedBox(height: 20),
            helpText(),
            SizedBox(height: 20),
            inputUserId(),
            userValid?Container():lengthError(),
            SizedBox(height: 20),
            inputPassword(),
            passValid?Container():lengthError(),
            SizedBox(height: 20),
            submitRegister()
          ],
        ),
      )),
    );
  }

  Widget helpText() {
    return 
      Container(
        child: Text("¡Crea tu usuario!",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
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

  Widget inputUserId() {
    return TextField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: kAlumnColor, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: 'Usuario',
          labelText: 'Usuario',
          suffixIcon: userVerified ? Icon(Icons.verified_user) : null,
          icon: Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {
          userID = valor;
          userValid = (valor.length>=3);
        });
      },
    );
  }

  Widget inputPassword() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: kAlumnColor, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: 'Contraseña',
          labelText: 'Contraseña',
          suffixIcon: Icon(Icons.verified_user),
          icon: Icon(Icons.lock)),
      onChanged: (valor) {
        setState(() {
          passwd = valor;
          passValid = (valor.length>=3);
        });
      },
    );
  }
  Widget lengthError(){
    return Container(
      margin: EdgeInsets.only(left:40,top: 5),
      child: Text('Ingresa al menos 3 caracteres',style: TextStyle(color: Colors.red),));
  }

  Widget submitRegister() {
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
            _registrarEstudiante();
          },
          child: Text('Registrar',
              style: TextStyle(fontSize: 25, color: Colors.white))),
    );
  }

  _registrarEstudiante() {

    var stud = ModalRoute.of(context)!.settings.arguments as Student;
    if(userID!.length<3){
      userValid = false;
    }else if(passwd!.length<3){
      passValid = false;
    }else{
      stud.userId = userID;
      stud.password = passwd;
      final usuarioTemporal = Provider.of<ActiveUser>(context, listen: false);
      registerService.registerStudent(stud).then((value) {
        if (value.state == 0) {
          usuarioTemporal.student = stud;
          Navigator.pushReplacementNamed(context, 'selectclass');
        } else {
          Navigator.pop(context);
        }
      });
    }
  }
}
