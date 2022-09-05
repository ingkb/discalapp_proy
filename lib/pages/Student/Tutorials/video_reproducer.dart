import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../providers/user_preference.dart';

/// Creates list of video players
class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final List<YoutubePlayerController> _controllers = [
    'B-45r9WVwjk', // sumas
    '-71Lr6KGqIM', // restas
    'tx_10w2AaXM', // multiplicacion
    'OO-rXUDq9jc', // comparacion
    '3upen55S9Ac', // secuencia
    '3JSF1YMtnOI', // Prop. Asociativa
    'CjUVTEExfBg', // este por ocio
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

  Future<bool> _onWillPop() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Reproductor());
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
        FullScreenButton(),
      ],
    );
  }
}
