import 'package:flutter/material.dart';

class InProgressPage extends StatelessWidget {
  const InProgressPage({ Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina en progreso'),
      ),
      body: Center(
        child: Image(
          image: AssetImage('assets/images/monkey.jpg')
        )
      ),
    );
  }
}