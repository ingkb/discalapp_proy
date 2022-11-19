import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:discalapp_proy/Services/register_service.dart';
import 'package:discalapp_proy/models/teacher_model.dart';
import 'package:provider/provider.dart';

class RegisterTeacherPage extends StatefulWidget {
  RegisterTeacherPage({Key? key}) : super(key: key);

  @override
  _RegisterTeacherPageState createState() => _RegisterTeacherPageState();
}

class _RegisterTeacherPageState extends State<RegisterTeacherPage> {
  Teacher? teacher;
  late RegisterService registerService;
  bool userVerified = false;
  bool userValid = true, passValid = true, nameValid = true;
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    teacher = new Teacher();
    registerService = new RegisterService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTeacherColor,
        title: Text('Registro docente'),
      ),
      body: Center(
          child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          children: [
            avatarImage(),
            SizedBox(height: 20),
            inputNombre(),
            nameValid ? Container() : lengthError(),
            SizedBox(height: 20),
            inputUserId(),
            userValid ? Container() : lengthError(),
            SizedBox(height: 20),
            inputPassword(),
            passValid ? Container() : lengthError(),
            SizedBox(height: 20),
            submitLogin()
          ],
        ),
      )),
    );
  }

  Widget inputPassword() {
    return TextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: kTeacherColor, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: 'Password',
          labelText: 'Password',
          suffixIcon: userVerified ? Icon(Icons.verified_user) : null,
          icon: Icon(Icons.lock)),
      onChanged: (valor) {
        setState(() {
          teacher!.password = valor;
          passValid = valor.length >= 3;
        });
      },
    );
  }

  Widget inputNombre() {
    return TextField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: kTeacherColor, width: 2.0),
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
          teacher!.name = valor;
          nameValid = valor.length >= 3;
        });
      },
    );
  }

  Widget inputUserId() {
    return TextField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: kTeacherColor, width: 2.0),
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
          teacher!.userId = valor;
          userValid = valor.length >= 3;
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              primary: kTeacherColor),
          onPressed: () {
            _registrarDocente();
          },
          child: Text('Registrar',
              style: TextStyle(fontSize: 25, color: Colors.white))),
    );
  }

  Widget alerta(String msg) {
    return AlertDialog(
      content: Text(msg),
      actions: [
        TextButton(
            onPressed: () {},
            child: Text('OK'),
            autofocus: true,
            clipBehavior: Clip.antiAlias)
      ],
      elevation: 20,
    );
  }

  Widget avatarImage() {
    return Container(
        width: 100,
        height: 100,
        child: CircleAvatar(
            child: Image(
          image: AssetImage('assets/images/iconoProfesor.png'),
        )));
  }

  Widget lengthError() {
    return Container(
        margin: EdgeInsets.only(left: 40, top: 5),
        child: Text(
          'Ingresa al menos 3 caracteres',
          style: TextStyle(color: Colors.red),
        ));
  }

  _registrarDocente() {
    if (teacher!.userId!.length < 3) {
      userValid = false;
    } else if (teacher!.password!.length < 3) {
      passValid = false;
    } else if (teacher!.name!.length < 3) {
      nameValid = false;
    } else {
      final usuarioTemporal = Provider.of<ActiveUser>(context, listen: false);
      registerService.registerTeacher(teacher!).then((value) {
        if (value.state == 0) {
          usuarioTemporal.teacher = teacher;
          prefs.teacherUserId = teacher!.userId!;
          Navigator.pushReplacementNamed(context, 'classes');
        } else {
          showDialog(
            context: context,
            builder: (_) => alerta(value.message!),
          );
        }
      });
    }
  }
}
