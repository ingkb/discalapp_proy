
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/models/teacher_model.dart';
import 'package:flutter/material.dart';

class ActiveUser with ChangeNotifier{


  Teacher _teacher;
  Student _student;


  get teacher {
    return _teacher;
  }

  get student {
    return _student;
  }

  set teacher(Teacher teach){
    this._teacher = teach;
    notifyListeners();
  }

 set student(Student stud){
    this._student = stud;
    notifyListeners();
  }

}