import 'dart:ui';

import 'package:discalapp_proy/constants.dart';
import 'package:discalapp_proy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InicialResult extends StatefulWidget {
  InicialResult({Key key}) : super(key: key);

  @override
  _InicialResultState createState() => _InicialResultState();
}

class _InicialResultState extends State<InicialResult> {

  ActiveUser usuarioResultados;
  @override
  Widget build(BuildContext context) {
    usuarioResultados = Provider.of<ActiveUser>(context);
   
   
    String comparePointsResults = usuarioResultados.getResultArea('puntos');
    String compareLinesResults = usuarioResultados.getResultArea('lineas');
    String setLineResults = usuarioResultados.getResultArea('UbicarLinea');
    String sumaResults = usuarioResultados.getResultArea('suma');
    String restaResults = usuarioResultados.getResultArea('resta');
    String multiplicaResults = usuarioResultados.getResultArea('multiplicacion');
    
    
    
    return Container(
      color: kAlumnColor,
       child: Center(
         
         child: Container(
           width: double.infinity,
           height: 500,
           child: Card(
             margin: EdgeInsets.all(20),
             color: Colors.white,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
             child: Padding(
               padding: const EdgeInsets.all(10),
               child: Column(
                 children: [
                   Text("Resultados",textAlign: TextAlign.center,style: TextStyle(color: kAlumnColor,fontSize: 25,fontWeight: FontWeight.w600),),
                   Divider(thickness: 3,),
                   SizedBox(height: 20),
                   Text("Sumas: $sumaResults",textAlign: TextAlign.left,style: TextStyle(fontSize:20),),
                   Text("Restas: $restaResults",textAlign: TextAlign.left,style: TextStyle(fontSize:20),),
                   Text("Multiplicacion: $multiplicaResults",textAlign: TextAlign.left,style: TextStyle(fontSize:20),),
                   Text("Ubicar en la linea: $setLineResults",textAlign: TextAlign.left,style: TextStyle(fontSize:20),),
                   Text("Comparación de puntos: $comparePointsResults",textAlign: TextAlign.left,style: TextStyle(fontSize:20),),
                   Text("Comparación de lineas: $compareLinesResults",textAlign: TextAlign.left,style: TextStyle(fontSize:20),),
                   Spacer(),
                   FlatButton(child: Text("salir",style: TextStyle(color:Colors.white),), color:kAlumnColor, onPressed: (){Navigator.pushReplacementNamed(context, '/');},)
                 ],
               ),
             ),),
         ),),
    );
  }

}