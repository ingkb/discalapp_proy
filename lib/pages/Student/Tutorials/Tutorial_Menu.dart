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
            children: [botonesTop(), CartelActividad(), listaNiveles(context)],
          )),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  Widget CartelActividad() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.06),
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
        margin: EdgeInsets.only(top: 200),
        width: 250,
        height: 150,
        child: GridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 2,
          crossAxisSpacing: 0,
          childAspectRatio: 3.5,
          children: [
            botonNivel("Sumas", 'videoReproducer', context, 0),
            botonNivel("Restas", 'videoReproducer', context, 1),
            botonNivel("Multiplicación", 'videoReproducer', context, 2),
            botonNivel("Comparación", 'videoReproducer', context, 3),
            botonNivel("Secuencias", 'videoReproducer', context, 4),
            botonNivel("Recta Numérica", 'videoReproducer', context, 5),
          ],
        ),
      ),
    );
  }

  Widget botonNivel(
      String name, String direccion, BuildContext context, int numSesion) {
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
                name,
                textAlign: TextAlign.center,
                style: GoogleFonts.permanentMarker(
                    fontSize: 25, color: Colors.black54),
              )
            ],
          )),
    );
  }

  Widget botonesTop() {
    return Container(
      margin: EdgeInsets.only(top: 25, right: 15, left: 15, bottom: 20),
      child: Row(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(), primary: Colors.transparent),
            child: Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image(image: AssetImage('assets/images/botonBack.png')),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(child: SizedBox()),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(), primary: Colors.transparent),
            child: Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image(image: AssetImage('assets/images/botonMenu.png')),
            ),
            onPressed: () {
              _openEndDrawer();
            },
          ),
        ],
      ),
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
