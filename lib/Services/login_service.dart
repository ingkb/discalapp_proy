import 'dart:convert';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/models/teacher_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class LoginService{

  Future<StudentLoginResponse> loginStudent(String userId, String password) async{
    final http.Response response = await http.post(BaseUrl+'/students/login', 
      body: jsonEncode(<String, String>{
        'userId': userId,
        'password':password
      }),
       headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if(response.statusCode == 201){
      return StudentLoginResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al iniciar sesion');
    }
  }

  Future<TeacherLoginResponse> loginTeacher(String userId, String password) async{
    final http.Response response = await http.post(BaseUrl+'/teachers/login', 
      body: jsonEncode(<String, String>{
        'userId': userId,
        'password':password
      }),
       headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if(response.statusCode == 201){
      return TeacherLoginResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al iniciar sesion');
    }
  }

}

class StudentLoginResponse {
    StudentLoginResponse({
        this.message,
        this.student,
    });

    String message;
    Student student;

    factory StudentLoginResponse.fromJson(Map<String, dynamic> json) => StudentLoginResponse(
        message: json["message"],
        student: Student.fromJson(json["student"]),
    );
}

class TeacherLoginResponse {
    TeacherLoginResponse({
        this.message,
        this.teacher,
    });

    String message;
    Teacher teacher;

    factory TeacherLoginResponse.fromJson(Map<String, dynamic> json) => TeacherLoginResponse(
        message: json["message"],
        teacher: Teacher.fromJson(json["teacher"]),
    );
}



