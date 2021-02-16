import 'dart:convert';
import 'package:discalapp_proy/models/sesion_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class SesionService{

  Future<RegisterSesionResponse> addSesion(Sesion sesion) async{
    final http.Response response = await http.post(BaseUrl+'/sesions', 
      body: json.encode(sesion.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    if(response.statusCode == 201){
      return RegisterSesionResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al agregar sesion');
    }
  }

   Future<SearchSesionResponse> getSesion(String code) async{
    final response = await http.get(BaseUrl+'/sesions/'+code);


    if(response.statusCode == 200){
      return SearchSesionResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar sesion');
    }
  }

  Future<SearchAllSesionResponse> getAllSesion(String studentId) async{
    final response = await http.get(BaseUrl+'/sesions/student/'+studentId);

    if(response.statusCode == 200){
      return SearchAllSesionResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar sesion');
    }
  }

  Future<RegisterSesionResponse> deleteSesion(String code) async{
    final http.Response response = await http.delete(BaseUrl+'/sesions/'+code, 
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return RegisterSesionResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al eliminar sesion');
    }
  }

  Future<RegisterSesionResponse> updateSesion(String code, Sesion sesion) async{
    final http.Response response = await http.patch(BaseUrl+'/sesions/'+code, 
     body: json.encode(sesion.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return RegisterSesionResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al eliminar sesion');
    }
  }
}

class SearchAllSesionResponse {
    SearchAllSesionResponse({
        this.state,
        this.sesions,
    });

    int state;
    List<Sesion> sesions;

    factory SearchAllSesionResponse.fromJson(Map<String, dynamic> json) => SearchAllSesionResponse(
        state: json["state"],
        sesions: List<Sesion>.from(json["sesions"].map((x) => Sesion.fromJson(x))),
    );
}

class SearchSesionResponse {
    SearchSesionResponse({
        this.state,
        this.message,
        this.sesion,
    });

    int state;
    String message;
    Sesion sesion;

    factory SearchSesionResponse.fromJson(Map<String, dynamic> json) => SearchSesionResponse(
        state: json["state"],
        message: json["message"],
        sesion: json["sesion"] == null ? null : Sesion.fromJson(json["sesion"]),
    
    );
}

class RegisterSesionResponse {
    RegisterSesionResponse({
        this.state,
        this.message,
        this.sesionId
    });
    int state;
    String message;
    String sesionId;

    factory RegisterSesionResponse.fromJson(Map<String, dynamic> json) => RegisterSesionResponse(
       state: json["state"],
       message: json["message"],
       sesionId: json["sesionId"],
    );
}



