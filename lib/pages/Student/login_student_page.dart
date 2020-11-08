import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';

class LoginStudentPage extends StatefulWidget {
 LoginStudentPage({Key key}) : super(key: key);

  @override
  _LoginStudentPageState createState() =>  _LoginStudentPageState();
}

class _LoginStudentPageState extends State<LoginStudentPage> {

  String _userId = '';
  String _password='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAlumnColor,
        title:Text('Login de estudiante')
      ),
      body: Center(
        child:Container(
          child: ListView(
             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: [
              avatarImage(),
              SizedBox(height: 40),
              inputUserId(),
              SizedBox(height: 30),
              inputPassword()
            ],
          ),
        )
      ),
    );
  }

  Widget avatarImage(){

    return Container(
      width: 200,
      height: 200,
      child: CircleAvatar(
        child: Image(
          image: AssetImage('assets/images/avatar1.png'),
        ) 
      )
    );
  }

  Widget inputUserId(){
     return TextField(
       
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Usuario',
        labelText: 'Usuario',
        helperText: 'Ingrese su usuario',
        suffixIcon: Icon(Icons.verified_user),
        icon: Icon(Icons.person)
      ),
      onChanged: (valor){
        setState(() {
           _userId = valor;
        });
      }
      ,
    );
  }

   Widget inputPassword(){
     return TextField(
       obscureText: true,
      decoration: InputDecoration(
        fillColor: kAlumnColor,
        focusColor: kTeacherColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Contraseña',
        labelText: 'Contraseña',
        helperText: 'Ingrese su usuario',
        suffixIcon: Icon(Icons.verified_user),
        icon: Icon(Icons.person)
      ),
      onChanged: (valor){
        setState(() {
           _password = valor;
        });
      }
      ,
    );
  }
}