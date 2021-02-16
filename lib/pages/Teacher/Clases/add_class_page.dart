import 'package:discalapp_proy/Services/classes_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/classgroup_model.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:flutter/material.dart';

class AddClassgroup extends StatefulWidget {
  AddClassgroup({Key key}) : super(key: key);

  @override
  _AddClassgroupState createState() => _AddClassgroupState();
}

class _AddClassgroupState extends State<AddClassgroup> {

  Classgroup classgroup;
  ClassgroupService classesService;
  bool userVerified = false;
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    classgroup = new Classgroup();
    classesService = new ClassgroupService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTeacherColor,
        title:Text('Crear clase')
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
              inputCodigo(),
              SizedBox(height: 20),
              submitLogin()
            ],
          ),
        )
      ),
    );
  }

 
  Widget inputNombre(){
     return TextField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: kAlumnColor, width: 2.0),
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
           classgroup.name = valor;
        });
      }
      ,
    );
  }

   Widget inputCodigo(){
     return TextField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: kAlumnColor, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Codigo',
        labelText: 'Codigo',
 
        suffixIcon: userVerified?Icon(Icons.verified_user):null,
        icon: Icon(Icons.person)
      ),
      onChanged: (valor){
        setState(() {
           classgroup.code = valor;
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


 
  Widget submitLogin(){
    return 
    
     Container(
       height: 50,
       margin: EdgeInsets.symmetric(horizontal: 50),
       child: RaisedButton(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
         color: kTeacherColor,
          onPressed: (){
            _registrarClase();
          },
          child: Text('Crear', style: TextStyle(
            fontSize: 25,
            color: Colors.white
          )
          )
        ),
     )
      ;
  }

  _registrarClase() {
    classgroup.teacher = prefs.teacherUserId;
    print('usuario ' + prefs.teacherUserId);
    classesService.addClassgroup(classgroup).then((value){
     setState(() {
       Navigator.pop(context, 'classes');
      //  Navigator.pop(context);
     });
    }
   );
        
  }
}