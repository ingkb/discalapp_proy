import 'package:discalapp_proy/pages/initial_page.dart';
import 'package:discalapp_proy/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => 
   runApp(MyApp()));
 
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiscalApp',
      initialRoute: '/',
      routes: getRoutes(),
      onGenerateRoute: (RouteSettings routeSettings){
        return MaterialPageRoute(
          builder: (BuildContext context)=>InitialPage()
        );
      },
    );
  }
}