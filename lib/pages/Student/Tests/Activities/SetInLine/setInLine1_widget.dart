import 'dart:ui';

import 'package:flutter/material.dart';

class SetInLine1 extends StatefulWidget {
  SetInLine1({Key key}) : super(key: key);

  @override
  _SetInLine1State createState() => _SetInLine1State();
}

class _SetInLine1State extends State<SetInLine1> {
  Offset pos = Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[900].withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(2, 5), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
                top: pos.dy,
                left: pos.dx,
                child: Draggable(
                  dragAnchor: DragAnchor.child,
                  feedback: Container(
                    height: 120,
                    width: 120,
                    alignment: Alignment.center,
                    child: Text('4',style: TextStyle(fontSize: 25,color: Colors.orange,fontWeight: FontWeight.bold)),
                    decoration: BoxDecoration(
                      color:Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage('assets/images/circulonumero.png')
                      )
                    ),
                  ),
                  child: Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    child: Text('4',style: TextStyle(fontSize: 25,color: Colors.orange,fontWeight: FontWeight.bold),),
                    decoration: BoxDecoration(
                      color:Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage('assets/images/circulonumero.png')
                      )
                    ),
                  ),
                  childWhenDragging: Container(),
                  onDraggableCanceled: (view, offset) {
                    setState(() {
                      pos = getNewPosition(offset);
                    });
                  },
                ))
          ],
        ),
      ),
    );
  }

  Offset getNewPosition(Offset offset) {
    double posX = offset.dx - 20;
    double posY = offset.dy - 100;
    if (posX < 10) {
      posX = 10;
    }
    if (posX>150){
      posX=150;
    }
    if(posY>400){
      posY=400;
    }
    if(posY<10){
      posY=10;
    }
    return new Offset(posX,posY);
  }
}
