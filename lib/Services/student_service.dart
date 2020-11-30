import 'dart:convert';
import 'package:discalapp_proy/models/student_model.dart';
import 'package:discalapp_proy/models/teacher_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class StudentService{

  Future<DefaultResponse> upadateStudent(Student student) async{
    final http.Response response = await http.patch(BaseUrl+'/students/'+student.userId, 
      body: json.encode(student.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return DefaultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al iniciar sesion');
    }
  }

  Future<DefaultResponse> registerTeacher(Teacher teacher) async{
    final http.Response response = await http.post(BaseUrl+'/teachers', 
      body: json.encode(teacher.toJson()),
       headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    print(response.body);
    if(response.statusCode == 201){
      return DefaultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al iniciar sesion');
    }
  }

}

class DefaultResponse {
    DefaultResponse({
        this.state,
        this.message,
    });

    int state;
    String message;
    factory DefaultResponse.fromJson(Map<String, dynamic> json) => DefaultResponse(
        state: json["state"],
        message: json["message"]
    );
}


