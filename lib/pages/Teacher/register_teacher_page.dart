import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';
import 'package:discalapp_proy/Services/register_service.dart';
import 'package:discalapp_proy/models/teacher_model.dart';

class RegisterTeacherPage extends StatefulWidget {
  RegisterTeacherPage({Key key}) : super(key: key);

  @override
  _RegisterTeacherPageState createState() => _RegisterTeacherPageState();
}

class _RegisterTeacherPageState extends State<RegisterTeacherPage> {
  Teacher teacher;
  RegisterService registerService;
  bool userVerified = false;
  
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
        child:Container(
          child: ListView(
             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            children: [
              avatarImage(),
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

  Widget inputPassword(){
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
        suffixIcon: userVerified?Icon(Icons.verified_user):null,
        icon: Icon(Icons.lock)
      ),
      onChanged: (valor){
        setState(() {
           teacher.password = valor;
        });
      }
      ,
    );
  }

  Widget inputNombre(){
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
 
        suffixIcon: userVerified?Icon(Icons.verified_user):null,
        icon: Icon(Icons.person)
      ),
      onChanged: (valor){
        setState(() {
           teacher.name = valor;
        });
      }
      ,
    );
  }

  Widget inputUserId(){
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
        suffixIcon: userVerified?Icon(Icons.verified_user):null,
        icon: Icon(Icons.account_circle)
      ),
      onChanged: (valor){
        setState(() {
           teacher.userId = valor;
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
         color: kTeacherColor,
          onPressed: (){
            _registrarDocente();
          },
          child: Text('Registrar', style: TextStyle(
            fontSize: 25,
            color: Colors.white
          )
          )
        ),
     )
      ;
  }

  Widget alerta(String msg){
    return AlertDialog(
      content: Text(msg),
      actions: [
        FlatButton(
          onPressed: (){},
          child: Text('OK'),
          autofocus: true,
          clipBehavior: Clip.antiAlias)
      ],
      elevation: 20,
    );
  }

  _registrarDocente() {

    registerService.registerTeacher(teacher).then((value){
     print(value.message + ' Respuestaa');
     if(value.message=='Estudiante registrado'){
        Navigator.pushReplacementNamed(context, 'classes');
     }else{
       showDialog(
         context: context,
         builder:(_)=>alerta(value.message),
       );
     }
    }
   );
        
  }

Widget avatarImage(){

    return Container(
      width: 100,
      height: 100,
      child: CircleAvatar(
        child: Image(
          image: AssetImage('assets/images/iconoProfesor.png'),
        ) 
      )
    );
  }

}