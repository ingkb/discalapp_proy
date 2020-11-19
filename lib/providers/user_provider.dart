
import 'package:flutter/material.dart';

class ActiveUser with ChangeNotifier{

  String _userId;
  String _teacherUserId;


  get userId {
    return _userId;
  }

  get teacherUserId {
    return _teacherUserId;
  }

  set teacherUserId(String teacherId){
    this._teacherUserId = teacherId;
    notifyListeners();
  }

 set userId(String userId){
    this._userId = userId;
    notifyListeners();
  }

}