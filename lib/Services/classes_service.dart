import 'dart:convert';
import 'package:discalapp_proy/models/classgroup_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class ClassgroupService{

  Future<RegisterClassgroupResponse> addClassgroup(Classgroup classgroup) async{
    final http.Response response = await http.post(BaseUrl+'/classgroups', 
      body: json.encode(classgroup.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if(response.statusCode == 201){
      return RegisterClassgroupResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al agregar clase');
    }
  }

   Future<RegisterClassgroupResponse> getClassgroup(String code) async{
    final response = await http.get(BaseUrl+'/classgroups/'+code, 
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if(response.statusCode == 200){
      return RegisterClassgroupResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar clase');
    }
  }
}

class SearchAllClassgroupResponse {
    SearchAllClassgroupResponse({
        this.student,
    });

    String message;
    Classgroup student;

    factory SearchAllClassgroupResponse.fromJson(Map<String, dynamic> json) => SearchAllClassgroupResponse(
        student: Classgroup.fromJson(json["student"]),
    );
}

class SearchClassgroupResponse {
    SearchClassgroupResponse({
        this.message,
        this.student,
    });

    String message;
    Classgroup student;

    factory SearchClassgroupResponse.fromJson(Map<String, dynamic> json) => SearchClassgroupResponse(
        message: json["message"],
        student: Classgroup.fromJson(json["student"]),
    );
}

class RegisterClassgroupResponse {
    RegisterClassgroupResponse({
        this.message,
    });

    String message;

    factory RegisterClassgroupResponse.fromJson(Map<String, dynamic> json) => RegisterClassgroupResponse(
        message: json["message"],
    );
}



