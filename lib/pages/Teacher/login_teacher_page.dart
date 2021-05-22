import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:discalapp_proy/Services/login_service.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:provider/provider.dart';


class LoginTeacherPage extends StatefulWidget {
  LoginTeacherPage({Key? key}) : super(key: key);

  @override
  _LoginTeacherPageState createState() => _LoginTeacherPageState();
}

class _LoginTeacherPageState extends State<LoginTeacherPage> {
  
  String _userId = '';
  String _password='';
  late LoginService loginService;
  bool userVerified = false;
  bool _isButtonDisabled = false;
  final prefs = new PreferenciasUsuario();

  @override
    void initState() {
      super.initState();
      loginService = new LoginService();
      
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: kTeacherColor,
         title:Text('Bienvenido  Docente')
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
          image: AssetImage('assets/images/iconoProfesor.png'),
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
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kTeacherColor, width: 2),
          borderRadius: BorderRadius.circular(10.0)
        ),
        labelText: 'Usuario',
        helperText: 'Ingrese su usuario',
        suffixIcon: userVerified?Icon(Icons.verified_user):null,
        icon: Icon(Icons.person, color: kTeacherColor ),
      ),
         onChanged: (valor){
           
       setState(() {
           _userId = valor;
        });
      }
    );
  }

Widget inputPassword(){
     return TextField(
       obscureText: true,
      decoration: InputDecoration(
        fillColor: kTeacherColor,
        focusColor: kTeacherColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kTeacherColor, width: 2),
          borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: 'Contraseña',
        labelText: 'Contraseña',
        helperText: 'Ingrese su usuario',
        suffixIcon:  userVerified?Icon(Icons.verified_user):null,
        icon: Icon(Icons.lock,color: kTeacherColor,)
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
       child: ElevatedButton(
         style: ElevatedButton.styleFrom(primary:_isButtonDisabled ? Colors.grey: kTeacherColor,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)) ),
          onPressed: _isButtonDisabled ? null: loguear,
          child: Text('Entrar', style: TextStyle(
            fontSize: 25,
            color: Colors.white
          )
          )
        ),
     )
      ;
    
  }

  loguear() {
    final usuarioTemporal = Provider.of<ActiveUser>(context, listen: false);
    usuarioTemporal.resultados = [];
    final prefs = new PreferenciasUsuario();
    
    //Desactiva el boton de entrar mientras busca el usuario
    setState(() {
      _isButtonDisabled = true;
    });
    try {
      //Llama al servicio para loguear
      loginService.loginTeacher(_userId, _password).then((res) {
      setState(() {
      _isButtonDisabled = false;
      });
      if (res.teacher!= null) {

      //si el profesor existe lo pone en las preferencias para que cuando vuelva a entrar no tenga que iniciar sesion
        usuarioTemporal.teacher = res.teacher;
        prefs.teacherUserId = _userId;
        prefs.teacherUserPasw = _password;
        Navigator.pushNamed(context, 'classes');
        
      } else {
        setState(() {
          userVerified = false;
        });
        showAlertDialog(context, "Usuario o contraseña equivocada", "Error");
      }
    });
    } catch (e) {
      setState(() {
      _isButtonDisabled = false;
      });
      showAlertDialog(context, "Vuelve a intentar", "Error");
    }
    
  }

  showAlertDialog(BuildContext context, String mensaje, String titulo) {
    // set up the button
    Widget okButton = TextButton(

      child: Text(
        "Ok",
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        titulo,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
      content: Text(
        mensaje,
        style: TextStyle(fontSize: 18),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}