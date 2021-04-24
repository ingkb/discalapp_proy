
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  
  ProgressBar({Key key, @required this.porcentaje}) : super(key: key);
  final double porcentaje;
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
     double maxWidth =260;
    double progressLenght = (maxWidth * widget.porcentaje)-20;
    if(progressLenght<0){
      progressLenght=0;
    }
   return Row(
     mainAxisAlignment: MainAxisAlignment.start,
     children: [
       
      SizedBox(
        width: maxWidth,
        child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10, left: 10, right: 20, bottom: 10),
            height: 30,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue[900].withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(1, 2), // changes position of shadow
              ),
              ],
            ),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1200),
              height: 30,
              width: progressLenght,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage('assets/images/greenbars.png'),
                    fit: BoxFit.none,
                    scale: 6,
                    alignment: Alignment.centerLeft,
                    repeat: ImageRepeat.repeatX
                    ),
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  )
                ),
              )
          ),
        Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.only(top:2, right: 10, bottom:2),
        child: CircleAvatar(
          child: Image(
            image: AssetImage('assets/images/avatar1.png'),
          ) 
        ),
      ),
      
     ],
   );
  }
}
