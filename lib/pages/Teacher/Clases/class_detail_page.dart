import 'package:discalapp_proy/Services/classes_service.dart';
import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/models/classgroup_model.dart';
import 'package:discalapp_proy/pages/Teacher/Clases/classes_page.dart';
import 'package:flutter/material.dart';

class ClassDetailPage extends StatefulWidget {
  ClassDetailPage({Key key, this.code}) : super(key: key);
  final String code;
  @override
  _ClassDetailPageState createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  Classgroup classgroup;
  ClassgroupService classesService;
  String code='';
  bool userVerified = false;

  @override
  void initState() {
    super.initState();
    code = widget.code;
    classgroup = new Classgroup();
    classgroup.name = '';
    classesService = new ClassgroupService();
    classesService.getClassgroup(code).then((value){
      setState(() {
      classgroup=value.classgroup;
      });});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTeacherColor,
        title:Text('Clase ${classgroup.name}')
      ),
      body: Center(
        child:ListView(
             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            children: [
              SizedBox(height:50),
              avatarImage(),
              SizedBox(height: 40),
              inputNombre(),
              SizedBox(height: 20),
              inputCodigo(),
              SizedBox(height: 40),
              submitLogin()
            ],
    )
    ),
    );
  }
 
  Widget inputNombre(){
     return TextField(
      controller: new TextEditingController(
        text: classgroup.name.toString()
      ),
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
           classgroup.name = valor;
      }
      ,
    );
  }

   Widget inputCodigo(){
     return  TextField(
       enabled: false,
      controller: new TextEditingController(
        text: classgroup.code.toString()
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: kAlumnColor, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: classgroup.code,
        labelText: 'Codigo',
        suffixIcon: userVerified?Icon(Icons.verified_user):null,
        icon: Icon(Icons.person)
      ),
      onChanged: null,
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
       child: ElevatedButton(
         style: ElevatedButton.styleFrom(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
         primary: kTeacherColor,
         ),
          onPressed: (){
            _modificarClase();
          },
          child: Text('Guardar', style: TextStyle(
            fontSize: 25,
            color: Colors.white
          )
          )
        ),
     )
      ;
  }

  _modificarClase() {

    classesService.updateClassgroup(classgroup.code,classgroup).then((value){
     setState(() {
       Navigator.push(context, MaterialPageRoute(
            builder: (context) => ClassesPage(),
          )).then((value){
            setState(() {
              
            });
          });
     });
    });
        
  }
}