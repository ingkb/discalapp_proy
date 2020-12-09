import 'dart:ui';
import 'package:discalapp_proy/Services/login_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginStudentPage extends StatefulWidget {
 LoginStudentPage({Key key}) : super(key: key);

  @override
  _LoginStudentPageState createState() =>  _LoginStudentPageState();
}

class _LoginStudentPageState extends State<LoginStudentPage> {

  String _userId = '';
  String _password='';
  LoginService loginService;

  bool userVerified = false;

  @override
  void initState() {

    super.initState();
    loginService = new LoginService();
  }
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
             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            children: [
              avatarImage(),
              SizedBox(height: 40),
              inputUserId(),
              SizedBox(height: 30),
              inputPassword(),
              SizedBox(height: 30),
              submitLogin()
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
        suffixIcon: userVerified?Icon(Icons.verified_user):Icon(Icons.visibility_off),
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
        suffixIcon:  Icon(Icons.verified_user),
        icon: Icon(Icons.lock)
      ),
      onChanged: (valor){
        setState(() {
           _password = valor;
        });
      }
      ,
    );
  }

  Widget submitLogin(){
    return  Container(
       height: 50,
       margin: EdgeInsets.symmetric(horizontal: 50),
       child: RaisedButton(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
         color: kAlumnColor,
          onPressed: (){
            loguear();
          },
          child: Text('Entrar', style: TextStyle(
            fontSize: 25,
            color: Colors.white
          )
          )
        ),
     )
      ;
    
  }

  loguear(){
    final usuarioTemporal = Provider.of<ActiveUser>(context,listen:false);
    usuarioTemporal.resultados = [];
    final prefs = new PreferenciasUsuario();
    loginService.loginStudent(_userId, _password).then((res) {

      if(res.student != null){
        usuarioTemporal.student = res.student;
        prefs.userId = _userId;

        if(res.student.classgroup != null){
          Navigator.pushReplacementNamed(context, 'initialTest');
        }else{
          Navigator.pushReplacementNamed(context, 'selectclass');
        }
        
      }else{
        setState(() {
          userVerified = false;
        });
      }
    });
    
  }
}