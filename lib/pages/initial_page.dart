import 'dart:ui';

import 'package:discalapp_proy/constants.dart';
import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  InitialPage({Key key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {


    double _initLogoPos =0.61;
    double _initBottomPos = 0.45;
    double _finalLogoPos =0.15;
    double _finalBottomPos = 0;
    double _logoPos = 0.61; 
    double _bottomPos = 0.45; 
    double _buttonsOpacity=1.0;
    double _backButtonOpacity = 0.0;
    bool _isBackDisabled=false;
    bool _isButtonDisabled=false;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    

    return Scaffold(
      backgroundColor: kPrimaryColor,
      
       body: Stack(
         fit: StackFit.expand,
         children: [
           
           Positioned(
             child:topImage(size),
           ),
           AnimatedPositioned(
             duration: Duration(milliseconds: 300),
             top: size.height * _bottomPos,
             child:bottomImage(size),
           ),
           AnimatedPositioned(
             duration: Duration(milliseconds: 300),
             top:size.height * _logoPos,
             child:logoImage(size),
           ),
           Positioned(
             top:size.height * 0.75,
             child:buttonLogin(size),
           ),
           Positioned(
             top:size.height * 0.85,
             child:buttonRegister(size),
           ),
           Positioned(
             bottom: 10,
             child: backButton()
           )
    
         ],
       )
       
    );
  }

Widget backButton(){

  return AnimatedOpacity(
    duration: Duration(milliseconds: 300),
    opacity: _backButtonOpacity,
    child: RaisedButton(
      shape: CircleBorder(),
      padding: EdgeInsets.all(10),
      child: Icon(Icons.arrow_back),
      elevation: 10,
      onPressed: _isBackDisabled ? null :  () => {
            setState(() {
              _buttonsOpacity = 1.0;
              _backButtonOpacity = 0.0;
              _isBackDisabled = true;
              _isButtonDisabled = false;
              _logoPos = _initLogoPos;
              _bottomPos = _initBottomPos;
            })
          }
      ),
  );
}

  Widget logoImage(Size size){
  return Container(
    width: size.width,
    alignment: Alignment.center,
    child: Image(
    width: size.width * 0.7,
    image: AssetImage('assets/images/LogoTemp.png'),
  )
  );
}

  Widget topImage( Size size){

    return Container(
      color: Colors.transparent,
      child: Image(
        alignment: Alignment.topCenter,
        width: size.width,
        fit: BoxFit.contain,
        image: AssetImage('assets/images/LoginTop.png'),
      ),
    );
  }

  Widget bottomImage( Size size){

    return Container(
      color: Colors.transparent,
      child: Image(
        alignment: Alignment.topCenter,
        width: size.width,
        image: AssetImage('assets/images/LoginBottom.png'),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buttonLogin(Size size){
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: _buttonsOpacity,
      child:Container(
        width: size.width,
        alignment: Alignment.center,
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          minWidth: size.width*0.7,
          color: Colors.white,
          onPressed:_isButtonDisabled ? null :  () => {
            setState(() {
              _buttonsOpacity = 0.0;
              _backButtonOpacity = 1.0;
              _isBackDisabled = false;
              _isButtonDisabled = true;
              _logoPos = _finalLogoPos;
              _bottomPos = _finalBottomPos;
            })
          }
          , child: Text('Entrar',style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          )
          ),
      )
      
      );
  }

  Widget buttonRegister(Size size){
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: _buttonsOpacity,
      child:Container(
        width: size.width,
        alignment: Alignment.center,
        child: OutlineButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          onPressed:_isButtonDisabled ? null :  () => {
            setState(() {
             _buttonsOpacity = 0.0;
              _backButtonOpacity = 1.0;
              _isBackDisabled = false;
              _isButtonDisabled = true;
              _logoPos = _finalLogoPos;
              _bottomPos = _finalBottomPos;
            })
          }, child: Text('Registrarse',style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          )
          ),
      )
      
      );
  }
}