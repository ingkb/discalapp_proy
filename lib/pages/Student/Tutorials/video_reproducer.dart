import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
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

/*   @override
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
 */

  @override
  Widget build(BuildContext context) {
    return Reproductor();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget Reproductor() {
    var opcion = ModalRoute.of(context)!.settings.arguments as int;
    return YoutubePlayer(
      key: ObjectKey(_controllers[opcion]),
      controller: _controllers[opcion],
      actionsPadding: const EdgeInsets.only(left: 16.0),
      bottomActions: [
        CurrentPosition(),
        const SizedBox(width: 10.0),
        ProgressBar(isExpanded: true),
        const SizedBox(width: 10.0),
        RemainingDuration(),
        //FullScreenButton(),
      ],
    );
  }
}
