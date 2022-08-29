import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../providers/user_preference.dart';

/// Creates list of video players
class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  
  final List<YoutubePlayerController> _controllers = [
    'VumaYtVeJuc', // sumas
    'VeyWehidri4', // restas
    'htgr3pvBr-I', // multiplicacion
    '4N1iwQxiHrs', // comparacion
    '_ZyD4n5zqxA', // secuencia
    'RIyjY7o_yww', // Recta Numerico
    'CjUVTEExfBg',
  ]
      .map<YoutubePlayerController>(
        (videoId) => YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ),
        ),
      )
      .toList();

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
            children: [botonesTop(), Reproductor()],
          )),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget Reproductor() {
    var opcion =  ModalRoute.of(context)!.settings.arguments as int;
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: YoutubePlayer(
      key: ObjectKey(_controllers[opcion]),
      controller: _controllers[opcion],
      actionsPadding: const EdgeInsets.only(left: 16.0),
      bottomActions: [
        CurrentPosition(),
        const SizedBox(width: 10.0),
        ProgressBar(isExpanded: true),
        const SizedBox(width: 10.0),
        RemainingDuration(),
        FullScreenButton(),
      ],
    ));
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
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
