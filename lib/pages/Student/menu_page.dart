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
      endDrawer: drawer(context),
      appBar: AppBar(
        backgroundColor: kAlumnColor,
        title: Text('Inicio'),
      ),
      body: Center(
          child: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          children: [
            ListTile(
              title: Text("Sesion1"),
              onTap: () {
                Navigator.pushNamed(context, 'sesion1');
              },
            ),
            ListTile(
              title: Text("Sesion2"),
            ),
            ListTile(
              title: Text("Sesion3"),
            ),
            ListTile(
              title: Text("Sesion4"),
            ),
          ],
        ),
      )),
    );
  }
}

Drawer drawer(context) {
  return Drawer(
      child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: CircleAvatar(child: Image(image: AssetImage('assets/images/iconoProfesor.png'),),),
        decoration: BoxDecoration(
          color: kAlumnColor,
        ),
      ),
      ListTile(
          contentPadding: EdgeInsets.only(left: 10),
          leading: Icon(
            Icons.exit_to_app,
            size: 30,
            color: kAlumnColor,
          ),
          title: Text("Cerrar Sesión"),
          onTap: () {
            final prefs = new PreferenciasUsuario();
            prefs.logOutStudent();
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/');
          }),
      
    ],
  ));
}

// Widget appbarMenu() {
//   return PopupMenuButton<int>(
//     onSelected: (int result) {
//       if (result == 1) {}
//     },
//     itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
//       PopupMenuItem<int>(
//           value: 1,
//           child: ListTile(
//               contentPadding: EdgeInsets.only(left: 1),
//               leading: Icon(
//                 Icons.exit_to_app,
//                 size: 30,
//                 color: kAlumnColor,
//               ),
//               title: Text("Cerrar Sesión"),
//               onTap: () {
//                 final prefs = new PreferenciasUsuario();
//                 prefs.logOutStudent();
//                 Navigator.pushReplacementNamed(context, '/');
//               })),
//     ],
//   );
// }
