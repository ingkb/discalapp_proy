import 'dart:ui';

import 'package:discalapp_proy/Services/classes_service.dart';
import 'package:discalapp_proy/Services/student_service.dart';
import 'package:discalapp_proy/models/classgroup_model.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class SelectClassPage extends StatefulWidget {
  SelectClassPage({Key? key}) : super(key: key);

  @override
  _SelectClassPageState createState() => _SelectClassPageState();
}

class _SelectClassPageState extends State<SelectClassPage> {

  late ClassgroupService classgroupService;
  late StudentService studentService;
  String codigoClase = '';

  @override
  Widget build(BuildContext context) {

    classgroupService = new ClassgroupService();
    studentService = new StudentService();
    return Scaffold(
       appBar: AppBar(
        backgroundColor: kAlumnColor,
        title: Text('Clases'),
      ),

      body: 
      Center(
        child:Container(
          child: ListView(
             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            children: [
              searchImage(),
              SizedBox(height: 40),
              inputCode(),
              SizedBox(height: 30),
              getClass()
            ],
          ),
        )
      ),
    );
  }

  Widget searchImage(){
    return Container(
      width: 130,
      height: 130,
      child: CircleAvatar(
        child: Image(
          image: AssetImage('assets/images/search.png'),
        ) 
      )
    );
  }

   Widget inputCode(){
     return TextField(
       
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        labelText: 'Código de la clase',
        helperText: 'Ingresa el código que te dio tu tutor',
        icon: Icon(Icons.book)
      ),
      onSubmitted: (valor){
        setState(() {
           codigoClase = valor;
        });
      }
      ,
    );
  }

  Widget getClass(){

    if(codigoClase!=''){
      return FutureBuilder(
      builder: (context, AsyncSnapshot<SearchClassgroupResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image(
              image: AssetImage('assets/images/loading1.gif'),
              width: 100,
            ),
          );
        }
        if (snapshot.data != null) {
          print(snapshot.data!.message);
          if(snapshot.data!.classgroup != null){
            return cardClass(snapshot.data!.classgroup!);
          }else{
            return Center(
            child: Text('no se encontro la clase',style: TextStyle( fontSize: 18),),
            );
          }
        } else {
          return Center(
            child: Text('. . . .',style: TextStyle( fontSize: 18)),
          );
        }
      },
      future: classgroupService.getClassgroup(codigoClase),
    );
    }else{
       return Center(
            child: Text('. . . .',style: TextStyle( fontSize: 18)),
          );
    }
  }

  Widget cardClass(Classgroup clase){

    return Card(
        elevation: 10,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      clase.name!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: kAlumnColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('código: ' + clase.code!,
                      style:
                          TextStyle(fontSize: 20)),
                  Expanded(child: SizedBox()),
                  ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: Colors.green,
                    ),
                    onPressed: (){
                      asignarClase(clase.code);
                    },
                    child: Text('Unirse',style: TextStyle(fontSize:20, color: Colors.white)),
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }

  asignarClase(String? code){
    final usuarioTemporal = Provider.of<ActiveUser>(context,listen:false);
    Student temp = usuarioTemporal.student!;
    temp.classgroup = code;
    usuarioTemporal.student = temp;

    studentService.upadateStudent(temp).then((res){
      if(res.state==0){
      Navigator.pushReplacementNamed(context, 'initialTest');
      }else{
        print('Error modificando al estudiante');
      }
    });


  }

}