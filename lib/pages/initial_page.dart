import 'dart:ui';
import 'package:discalapp_proy/Services/login_service.dart';
import 'package:discalapp_proy/Services/sesions_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  bool intentandoLoguear = false;
  bool buscando = true;
  double _initLogoPos = 0.61;
  double _finalLogoPos = 0.12;
  double _logoPos = 0.61;
  double _buttonsOpacity = 1.0;
  double _backButtonOpacity = 0.0;
  double _menuOpacity = 0.0;
  double _menuPosition = -1;

  String _logoBlanco = 'assets/images/Discalpp-LogoBlanco.png';
  String _logoNormal = 'assets/images/Discalpp-text1.png';
  String _logoActual = 'assets/images/Discalpp-LogoBlanco.png';
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: kColorVerdeClaro,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: topImage(size),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: size.height * 0.45,
              child: bottomImage(size),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: size.height * _logoPos,
              child: logoImage(size),
            ),
            Positioned(
              top: size.height * 0.75,
              child: buttonLogin(size),
            ),
            Positioned(
              top: size.height * 0.85,
              child: buttonRegister(size),
            ),
            Positioned(bottom: 20, left: 20, child: backButton()),
            Positioned(
              top: size.height * 0.20,
              right: size.width * _menuPosition,
              child: loginOptions(size),
            ),
          ],
        ));
  }

  Widget loginOptions(Size size) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: _menuOpacity,
      child: Container(
        width: size.width,
        child: Column(
          children: [
            SizedBox(height: 40),
            optionAlumno(),
            SizedBox(height: 20),
            optionDocente(),
          ],
        ),
      ),
    );
  }

  Widget optionDocente() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: kAlumnColor,
          elevation: 20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
      onPressed: () {
        if (_isLogin) {
          Navigator.pushNamed(context, 'loginTeacher');
        } else {
          Navigator.pushNamed(context, 'registerTeacher');
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Text(
              _menuLabel + '\nDocente',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image(
                height: 150,
                image: AssetImage('assets/images/iconoProfesor.png')),
          ],
        ),
      ),
    );
  }

  Widget optionAlumno() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: kAlumnColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        elevation: 20,
      ),
      onPressed: () {
        if (_isLogin) {
          loguearEstudiante();
        } else {
          Navigator.pushNamed(context, 'registerStudent');
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Text(
              _menuLabel + '\nAlumno',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image(height: 150, image: AssetImage('assets/images/avatar1.png')),
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: _backButtonOpacity,
        child: ButtonTheme(
          minWidth: 50.0,
          height: 50.0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
                elevation: 10,
              ),
              child: Icon(
                Icons.arrow_back,
                color: kTeacherColor,
              ),
              onPressed: _isBackDisabled
                  ? null
                  : () => {
                        setState(() {
                          _buttonsOpacity = 1.0;
                          _backButtonOpacity = 0.0;
                          _isBackDisabled = true;
                          _isButtonDisabled = false;
                          _logoActual = _logoBlanco;
                          _logoPos = _initLogoPos;
                          _menuOpacity = 0.0;
                          _menuPosition = -1;
                        })
                      }),
        ));
  }

  Widget logoImage(Size size) {
    return Container(
        width: size.width,
        alignment: Alignment.center,
        child: Image(
          width: size.width * 0.7,
          image: AssetImage(_logoActual),
        ));
  }

  Widget topImage(Size size) {
    return Container(
      color: Colors.transparent,
      child: Image(
        alignment: Alignment.topCenter,
        width: size.width,
        fit: BoxFit.contain,
        image: AssetImage('assets/images/LoginTop.png'),
      ),
    );
  }

  Widget bottomImage(Size size) {
    return Container(
      color: Colors.transparent,
      child: Image(
        alignment: Alignment.topCenter,
        width: size.width,
        image: AssetImage('assets/images/LoginBottom.png'),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buttonLogin(Size size) {
    return AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: _buttonsOpacity,
        child: Container(
          width: size.width,
          alignment: Alignment.center,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 8),
              ),
              autofocus: true,
              clipBehavior: Clip.none,
              onPressed: _isButtonDisabled
                  ? null
                  : () => {
                        setState(() {
                          _isLogin = true;
                          _buttonsOpacity = 0.0;
                          _backButtonOpacity = 1.0;
                          _isBackDisabled = false;
                          _isButtonDisabled = true;
                          _logoActual = _logoNormal;
                          _logoPos = _finalLogoPos;
                          _menuOpacity = 1.0;
                          _menuPosition = 0;
                          _menuLabel = 'Entrar como ';
                        })
                      },
              child: Text(
                'Entrar',
                style: TextStyle(
                  color: kColorVerdeClaro,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              )),
        ));
  }

  Widget buttonRegister(Size size) {
    return AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: _buttonsOpacity,
        child: Container(
          width: size.width,
          alignment: Alignment.center,
          child: OutlinedButton(

              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              onPressed: _isButtonDisabled
                  ? null
                  : () => {
                        setState(() {
                          _isLogin = false;
                          _buttonsOpacity = 0.0;
                          _backButtonOpacity = 1.0;
                          _isBackDisabled = false;
                          _isButtonDisabled = true;
                          _logoActual = _logoNormal;
                          _logoPos = _finalLogoPos;
                          _menuOpacity = 1.0;
                          _menuPosition = 0;
                          _menuLabel = 'Registrarse como ';
                        })
                      },
              child: Text(
                'Registrarse',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )),
        ));
  }

  Student? estudiante;
  buscarUsuario() {
    final prefs = new PreferenciasUsuario();
    if (prefs.userId != '') {
      try {
        LoginService loginService = new LoginService();
        loginService.loginStudent(prefs.userId, prefs.userPasw).then((value) {
          estudiante = value.student;
          buscando = false;
          if (intentandoLoguear) {
            loguearEstudiante();
          }
        });
      } catch (e) {
        print(e);
        estudiante = null;
        buscando = false;
      }
    } else {
      estudiante = null;
      buscando = false;
    }
  }

  loguearEstudiante() {
    usuarioTemporal = Provider.of<ActiveUser>(context, listen: false);
    usuarioTemporal.resultados = [];
    usuarioTemporal.student = estudiante;
    intentandoLoguear = true;

    if (estudiante != null && !buscando) {
      if (estudiante!.classgroup != null) {
        //Busca si el estudiante ya realizo el test inicial, si no lo ha realizado lo manda al test
        sesionService.getAllSesion(estudiante!.userId!).then((respuesta) {
          if (respuesta.state == 0 && respuesta.sesions!.isEmpty) {
            Navigator.pushReplacementNamed(context, 'initialTest');
          } else {
            Navigator.pushNamed(context, 'menuStudent');
          }
        });
      } else {
        Navigator.pushReplacementNamed(context, 'selectclass');
      }
    } else {
      intentandoLoguear = false;
      Navigator.pushNamed(context, 'loginStudent');
    }
  }
}
