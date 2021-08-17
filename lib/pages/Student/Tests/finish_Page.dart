import 'package:flutter/material.dart';

import '../../../constants.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF3a74a6),
        appBar: AppBar(
            backgroundColor: kAlumnColor, title: Text('Prueba finalizada')),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Container(margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),width: 200, child: Image(image: AssetImage('assets/images/starListo.jpg'))),
              Text(
                'Los resultados de la prueba se han enviado a tu docente.\n\n¡Puedes empezar a estudiar con las sesiones diarias!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              siguiente(context)
            ],
          ),
        ));
  }

  Widget siguiente(context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 60),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            primary: kTeacherColor,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'menuStudent');
          },
          child: Text('Comenzar',
              style: TextStyle(fontSize: 25, color: Colors.white))),
    );
  }
}
