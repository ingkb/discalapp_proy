import 'dart:ui';
import 'package:discalapp_proy/Services/login_service.dart';
import 'package:discalapp_proy/Services/sesions_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialPageSimple extends StatefulWidget {
  InitialPageSimple({Key? key}) : super(key: key);

  @override
  _InitialPageSimpleState createState() => _InitialPageSimpleState();
}

class _InitialPageSimpleState extends State<InitialPageSimple> {

  bool intentandoLoguear = false;
  bool buscando = true;
  ButtonStyle style = ElevatedButton.styleFrom(
      primary: kTeacherColor,
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))));
  double _initLogoPos = 0.61;
  double _initBottomPos = 0.45;
  double _finalLogoPos = 0.15;
  double _finalBottomPos = 0;
  double _logoPos = 0.61;
  double _bottomPos = 0.45;
  double _buttonsOpacity = 1.0;
  double _backButtonOpacity = 0.0;
  double _menuOpacity = 0.0;
  double _menuPosition = -1;

  String _menuLabel = '';

  bool _isLogin = false;

  bool _isBackDisabled = true;
  bool _isButtonDisabled = false;

  late SesionService sesionService;
  late ActiveUser usuarioTemporal;
  @override
  void initState() {
    sesionService = new SesionService();
    super.initState();
    buscarUsuario();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
       child: null,
    );
  }


    Student? estudiante;
  buscarUsuario(){
    
    final prefs = new PreferenciasUsuario();
    if(prefs.userId!=''){
      try {
        LoginService loginService = new LoginService();
        loginService.loginStudent(prefs.userId, prefs.userPasw).then((value){
        estudiante = value.student;
        buscando=false;
        if(intentandoLoguear){
          loguearEstudiante();
        }
      });
      } catch (e) {
        print(e);
        estudiante = null;
        buscando = false;
      }
    }else{
      estudiante = null;
      buscando = false;
    }
  }
  loguearEstudiante(){
    usuarioTemporal = Provider.of<ActiveUser>(context, listen: false);
    usuarioTemporal.resultados = [];
    usuarioTemporal.student = estudiante;
    intentandoLoguear = true;

    if(estudiante!=null && !buscando){

      if (estudiante!.classgroup != null) {
          //Busca si el estudiante ya realizo el test inicial, si no lo ha realizado lo manda al test
          sesionService.getAllSesion(estudiante!.userId!).then((respuesta){
            if(respuesta.state == 0 && respuesta.sesions!.isEmpty){
              Navigator.pushReplacementNamed(context, 'initialTest');
            }else{
              Navigator.pushNamed(context, 'menuStudent');
            }
          });
        } else {
          Navigator.pushReplacementNamed(context, 'selectclass');
        } 
    }else{
      intentandoLoguear=false;
      Navigator.pushNamed(context, 'loginStudent');
    }
  }

}