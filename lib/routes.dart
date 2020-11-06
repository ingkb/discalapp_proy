import 'package:discalapp_proy/pages/initial_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes(){

  return <String, WidgetBuilder>{
    '/' :(BuildContext context) => InitialPage()
  };
}