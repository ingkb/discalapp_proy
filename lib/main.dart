import 'package:discalapp_proy/pages/initial_page.dart';
import 'package:discalapp_proy/providers/user_preference.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:discalapp_proy/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  await initializeDateFormatting();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => 
   runApp(MyApp()));
 
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_)=> new ActiveUser(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DiscalApp',
          initialRoute: '/',
          routes: getRoutes(),
          onGenerateRoute: (RouteSettings routeSettings){
            return MaterialPageRoute(
              builder: (BuildContext context)=>InitialPage()
            );
        },
      ),
    );
  }
}