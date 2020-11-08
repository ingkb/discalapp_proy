
import 'package:discalapp_proy/Services/register_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:flutter/material.dart';

class RegisterStudentPage extends StatefulWidget {
  RegisterStudentPage({Key key}) : super(key: key);

  @override
  _RegisterStudentPageState createState() => _RegisterStudentPageState();
}

class _RegisterStudentPageState extends State<RegisterStudentPage> {


  Student student;
  RegisterService registerService;
  bool userVerified = false;

  @override
  void initState() {
    super.initState();
    student = new Student();
    registerService = new RegisterService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAlumnColor,
        title:Text('Resgitro estudiante')
      ),
      body: Center(
        child:Container(
          child: ListView(
             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            children: [
              avatarImage(),
              SizedBox(height: 20),
              inputEdad(),
              SizedBox(height: 20),
              inputNombre(),
              SizedBox(height: 20),
              inputUserId(),
              SizedBox(height: 20),
              inputPassword(),
              SizedBox(height: 20),
              submitLogin()
            ],
          ),
        )
      ),
    );
  }

  Widget inputEdad(){
    return TextField(
       keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Edad',
        labelText: 'Edad',
        helperText: 'Ingrese su edad',
        suffixIcon: userVerified?Icon(Icons.verified_user):null,
        icon: Icon(Icons.cake)
      ),
      onChanged: (valor){
        setState(() {
           student.age = int.parse(valor);
        });
      }
      ,
    );
  }

  Widget inputNombre(){
     return TextField(
       
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre',
        labelText: 'Nombre',
        helperText: 'Ingrese su nombre',
        suffixIcon: userVerified?Icon(Icons.verified_user):null,
        icon: Icon(Icons.person)
      ),
      onChanged: (valor){
        setState(() {
           student.name = valor;
        });
      }
      ,
    );
  }

  Widget avatarImage(){

    return Container(
      width: 100,
      height: 100,
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
        suffixIcon: userVerified?Icon(Icons.verified_user):null,
        icon: Icon(Icons.person)
      ),
      onChanged: (valor){
        setState(() {
           student.userId = valor;
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
           student.password = valor;
        });
      }
      ,
    );
  }


  Widget submitLogin(){
    return 
    
     Container(
       height: 50,
       margin: EdgeInsets.symmetric(horizontal: 50),
       child: RaisedButton(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
         color: kAlumnColor,
          onPressed: (){
            _registrarEstudiante();
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

  _registrarEstudiante() {

    registerService.registerStudent(student).then((value){
     print(value.message + ' Respuestaa');
    }
   );
        
  }
}