import 'package:discalapp_proy/Services/sesions_service.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int mayor = 0;

  @override
  void initState() {
    super.initState();
    buscarSesiones();
  }

  buscarSesiones() {
    ActiveUser usuario = Provider.of<ActiveUser>(context, listen: false);

    if (usuario.student!.userId != '') {
      try {
        SesionService sesionService = new SesionService();
        sesionService.getAllSesion(usuario.student!.userId!).then((value) {
          if (value.state == 0 && value.sesions!.length > 0) {
            setState(() {
              for (var item in value.sesions!) {
                if (item.tipo! > mayor && item.estado == true)
                  mayor = item.tipo!;
              }
            });
          }
        });
      } catch (e) {
        print(e);
      }
    } else {
      print("id no encontrado");
    }
  }

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
            children: [botonesTop(), CartelTutorial(), listaNiveles(context)],
          )),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  // void _closeEndDrawer() {
  //   Navigator.of(context).pop();
  // }

  // child: Image(image: AssetImage('assets/images/botonBack.png')),
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

  Widget listaNiveles(context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 150),
        width: 200,
        height: 400,
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            botonNivel("Nivel 1", 'sesion1', context, 1),
            botonNivel("Nivel 2", 'sesion1', context, 2),
            botonNivel("Nivel 3", 'sesion1', context, 3),
            botonNivel("Test Final", 'initialTest', context, 4),
          ],
        ),
      ),
    );
  }

  Widget CartelTutorial() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/cartelTituloTutoriales.png'))),
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'tutorial');
        },
        child: Text(
          'Tutoriales',
          style:
              GoogleFonts.permanentMarker(fontSize: 25, color: Colors.black54),
        ),
      ),
    );
  }

  Widget botonNivel(
      String sesion, String direccion, BuildContext context, int numSesion) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/notaPapel.png'))),
      child: TextButton(
          onPressed: (numSesion == mayor + 1)
              ? () {
                  Navigator.pushNamed(context, direccion, arguments: numSesion);
                }
              : null,
          // onPressed: () {
          //   Navigator.pushNamed(context, direccion, arguments: numSesion);
          // },
          child: Stack(
            fit: StackFit.expand,
            children: [
              imagen(numSesion),
              Text(
                sesion,
                textAlign: TextAlign.center,
                style: GoogleFonts.permanentMarker(
                    fontSize: 25, color: Colors.black54),
              )
            ],
          )),
    );
  }

  Widget imagen(int numSesion) {
    if (numSesion <= mayor) {
      return chulitoImage();
    } else if (numSesion > mayor + 1) {
      return candadoImage();
    } else {
      return Container();
    }
  }

  Widget candadoImage() {
    return Positioned(
      top: 5,
      left: 15,
      child: Container(
        color: Colors.transparent,
        child: Image(
          alignment: Alignment.topCenter,
          width: 45,
          fit: BoxFit.contain,
          image: AssetImage('assets/images/candado.png'),
        ),
      ),
    );
  }

  Widget chulitoImage() {
    return Positioned(
      bottom: 5,
      right: 10,
      child: Container(
        color: Colors.transparent,
        child: Image(
          alignment: Alignment.topCenter,
          width: 40,
          fit: BoxFit.contain,
          image: AssetImage('assets/images/chulo.png'),
        ),
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
