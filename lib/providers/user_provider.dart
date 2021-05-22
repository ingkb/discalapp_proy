
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/models/teacher_model.dart';
import 'package:flutter/material.dart';

class ActiveUser with ChangeNotifier{


  Teacher? _teacher;
  Student? _student;
  
  String _sesionId = '';
  List<ActivityResult>? _resultados;

  String get sesionId{
    return _sesionId;
  }
  Teacher? get teacher {
    return _teacher;
  }

  Student? get student {
    return _student;
  }

  List<ActivityResult>? get resultados {
    return _resultados;
  }

  set teacher(Teacher? teach){
    this._teacher = teach;
    notifyListeners();
  }

 set student(Student? stud){
    this._student = stud;
    notifyListeners();
  }

  set sesionId(String id){
    this._sesionId = id;
    notifyListeners();
  }

  set resultados(List<ActivityResult>? results){
    this._resultados = results;
    notifyListeners();
  }

  addResults(ActivityResult result){
    if(this._resultados==null){
      this._resultados=[];
    }
    this._resultados!.add(result);
    notifyListeners();
  }

  getAciertosArea(String area){
    int aciertos=0;
    for (ActivityResult result in _resultados!) {
      if(result.area == area ){
        if(result.resultado!){
          aciertos++;
        }
      }
    }
    return aciertos;
  }

  getTotalArea(String area){
    int totalArea = 0;
    for (ActivityResult result in _resultados!) {
      if(result.area == area ){
        totalArea++;
      }
    }
    return totalArea;
  }

}