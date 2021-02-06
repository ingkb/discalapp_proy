import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';


class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAlumnColor,
        title: Text('Inicio'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child:appbarMenu(),
          )
        ],
      ),
      body: Center(
          child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          children: [
            ListTile(title: Text("Sesion1"),onTap:(){Navigator.pushNamed(context, 'sesion1');} ,),
            ListTile(title: Text("Sesion2"),),
            ListTile(title: Text("Sesion3"),),
            ListTile(title: Text("Sesion4"),),
          ],
        ),
      )),
    );
  }
}

Widget appbarMenu(){
  return PopupMenuButton<int>(
  onSelected: (int result) { if(result==1){} },
  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
    PopupMenuItem<int>(
      value: 1,
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 1),
        leading: Icon(Icons.exit_to_app,size: 30,color: kAlumnColor,),
        title: Text("Cerrar Sesión"),
        onTap: (){
          final prefs = new PreferenciasUsuario();
          prefs.logOutStudent();
           Navigator.pushReplacementNamed(context, '/');}
      )
    ),
    
  ],
  );
}