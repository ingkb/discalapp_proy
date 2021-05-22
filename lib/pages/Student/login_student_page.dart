import 'dart:ui';
import 'package:discalapp_proy/Services/login_service.dart';
import 'package:discalapp_proy/Services/sesions_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginStudentPage extends StatefulWidget {
  LoginStudentPage({ Key? key}) : super(key: key);

  @override
  _LoginStudentPageState createState() => _LoginStudentPageState();
}

class _LoginStudentPageState extends State<LoginStudentPage> {
  String _userId = '';
  String _password = '';
  late LoginService loginService;
  late SesionService sesionService;
  bool _isButtonDisabled = false;
  bool userVerified = false;

  @override
  void initState() {
    super.initState();
    loginService = new LoginService();
    sesionService = new SesionService();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kAlumnColor, title: Text('Login de estudiante')),
      body: Center(
          child: Container(
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
      )),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Usuario',
          labelText: 'Usuario',
          helperText: 'Ingrese su usuario',
          suffixIcon: userVerified
              ? Icon(Icons.verified_user)
              : Icon(Icons.visibility_off),
          icon: Icon(Icons.person)),
      onChanged: (valor) {
        setState(() {
          _userId = valor;
        });
      },
    );
  }

  Widget inputPassword() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          fillColor: kAlumnColor,
          focusColor: kTeacherColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Contraseña',
          labelText: 'Contraseña',
          helperText: 'Ingrese su usuario',
          suffixIcon: Icon(Icons.verified_user),
          icon: Icon(Icons.lock)),
      onChanged: (valor) {
        setState(() {
          _password = valor;
        });
      },
    );
  }

  Widget submitLogin() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary:_isButtonDisabled ? Colors.grey: kAlumnColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
          onPressed: _isButtonDisabled ? null: loguear,
          child: Text('Entrar',
              style: TextStyle(fontSize: 25, color: Colors.white))),
    );
  }

  loguear() {
    final usuarioTemporal = Provider.of<ActiveUser>(context, listen: false);
    usuarioTemporal.resultados = [];
    final prefs = new PreferenciasUsuario();
    
    //Desactiva el boton de entrar mientras busca el usuario
    setState(() {
      _isButtonDisabled = true;
    });

    //Llama al servicio para loguear
    loginService.loginStudent(_userId, _password).then((res) {
      setState(() {
      _isButtonDisabled = false;
      });
      if (res.student != null) {

      //si el estudiante existe lo pone en las preferencias para que cuando vuelva a entrar no tenga que iniciar sesion
        usuarioTemporal.student = res.student;
        prefs.userId = _userId;
        prefs.userPasw = _password;

        if (res.student!.classgroup != null) {
          //Busca si el estudiante ya realizo el test inicial, si no lo ha realizado lo manda al test
          sesionService.getAllSesion(_userId).then((respuesta){
            if(respuesta.state == 0 && respuesta.sesions!.isEmpty){
               Navigator.pushReplacementNamed(context, 'initialTest');
            }else{
                Navigator.pushReplacementNamed(context, 'menuStudent');
            }
          });
        } else {
          Navigator.pushReplacementNamed(context, 'selectclass');
        }
      } else {
        setState(() {
          userVerified = false;
        });
        showAlertDialog(context, "Usuario o contraseña equivocada", "Error");
      }
    });
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
