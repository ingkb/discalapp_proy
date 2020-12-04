
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
     double maxWidth =330;
  double progressLenght = maxWidth * widget.porcentaje;
   return Row(
     mainAxisAlignment: MainAxisAlignment.start,
     children: [
       Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.only(left:10, top:10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
              BoxShadow(
                color: Colors.blue[900].withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(2, 5), // changes position of shadow
              ),
            ],
        ),
        child: CircleAvatar(
          child: Image(
            image: AssetImage('assets/images/avatar1.png'),
          ) 
        ),
      ),
      SizedBox(
        width: maxWidth,
        child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 20, left: 10, right: 20, bottom: 10),
            height: 40,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue[900].withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(2, 5), // changes position of shadow
              ),
              ],
            ),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1200),
              height: 40,
              width: progressLenght,
                
                //child: Image(image: AssetImage('assets/images/search.png'),fit: BoxFit.fill),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  
                ),
              )
          ) 
        ),
      
     ],
   );
  }
}
