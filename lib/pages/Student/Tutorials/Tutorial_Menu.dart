import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: drawer(context),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage('assets/images/Menu_marcoTutorialVacio.jpg'),
                  fit: BoxFit.fill)),
          child: ListView(
            children: [CartelActividad(), listaNiveles(context)],
          )),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  Widget CartelActividad() {
    return Container(
      margin: EdgeInsets.only(top: 150),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/cartelTituloTutoriales.png'))),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, 'menuStudent');
        },
        child: Text(
          'Actividades',
          style:
              GoogleFonts.permanentMarker(fontSize: 25, color: Colors.black54),
        ),
      ),
    );
  }

  Widget listaNiveles(context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 150),
        width: 200,
        height: 400,
        child: GridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          children: [
            botonNivel("Sumas", 'menuStudent', context, 1),
            botonNivel("Restas", 'menuStudent', context, 2),
            botonNivel("Multiplicación", 'menuStudent', context, 3),
            botonNivel("Propiedad Asociativa", 'menuStudent', context, 4),
          ],
        ),
      ),
    );
  }

  Widget botonNivel(
      String Name, String direccion, BuildContext context, int numSesion) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/opcionDeMenu.png'))),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, direccion, arguments: numSesion);
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Text(
                Name,
                textAlign: TextAlign.center,
                style: GoogleFonts.permanentMarker(
                    fontSize: 25, color: Colors.black54),
              )
            ],
          )),
    );
  }

  Drawer drawer(context) {
    return Drawer(
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: CircleAvatar(
            child: Image(
              image: AssetImage('assets/images/avatar1.png'),
            ),
          ),
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
}
