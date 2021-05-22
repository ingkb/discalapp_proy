import 'dart:convert';
import 'package:discalapp_proy/models/activityResult_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class ActivityResultService{

  Future<RegisterActivityResultResponse> addActivityResult(ActivityResult activityResult) async{
    
    var url = Uri.parse(BaseUrl+'/ActivityResult');
    final http.Response response = await http.post(url, 
      body: json.encode(activityResult.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 201){
      return RegisterActivityResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al agregar activityResult');
    }
  }


  Future<RegisterActivityResultResponse> addGroupActivityResult(RegisterAcitivityGroupRequest activityResults) async{
    var url = Uri.parse(BaseUrl+'/ActivityResult/group');
    final http.Response response = await http.post(url, 
      body: json.encode(activityResults.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 201){
      return RegisterActivityResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al agregar activityResult');
    }
  }

   Future<SearchActivityResultResponse> getActivityResult(String code) async{
     var url = Uri.parse(BaseUrl+'/ActivityResult/'+code);
    final response = await http.get(url);
    if(response.statusCode == 200){
      return SearchActivityResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar activityResult');
    }
  }

  Future<SearchAllActivityResultResponse> getAllActivityResult(String sesionId) async{
    var url = Uri.parse(BaseUrl+'/ActivityResult/sesion/'+sesionId);
    final response = await http.get(url);
    if(response.statusCode == 200){
      return SearchAllActivityResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar activityResult');
    }
  }

  Future<RegisterActivityResultResponse> deleteActivityResult(String code) async{
    var url = Uri.parse(BaseUrl+'/ActivityResult/'+code);
    final http.Response response = await http.delete(url, 
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return RegisterActivityResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al eliminar activityResult');
    }
  }

  Future<RegisterActivityResultResponse> updateActivityResult(String code, ActivityResult activityResult) async{
    var url = Uri.parse(BaseUrl+'/ActivityResult/'+code);
    final http.Response response = await http.patch(url, 
     body: json.encode(activityResult.toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if(response.statusCode == 200){
      return RegisterActivityResultResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al eliminar activityResult');
    }
  }
}

class SearchAllActivityResultResponse {
    SearchAllActivityResultResponse({
        this.state,
        this.activityResults,
    });

    int? state;
    List<ActivityResult>? activityResults;

    factory SearchAllActivityResultResponse.fromJson(Map<String, dynamic> json) => SearchAllActivityResultResponse(
        state: json["state"],
        activityResults: List<ActivityResult>.from(json["activityResults"].map((x) => ActivityResult.fromJson(x))),
    );
}

class SearchActivityResultResponse {
    SearchActivityResultResponse({
        this.state,
        this.message,
        this.activityResult,
    });

    int? state;
    String? message;
    ActivityResult? activityResult;

    factory SearchActivityResultResponse.fromJson(Map<String, dynamic> json) => SearchActivityResultResponse(
        state: json["state"],
        message: json["message"],
        activityResult: json["activityResult"] == null ? null : ActivityResult.fromJson(json["activityResult"]),
    
    );
}

class RegisterActivityResultResponse {
    RegisterActivityResultResponse({
        this.state,
        this.message,
    });
    int? state;
    String? message;

    factory RegisterActivityResultResponse.fromJson(Map<String, dynamic> json) => RegisterActivityResultResponse(
       state: json["state"],
       message: json["message"],
    );
}

class RegisterAcitivityGroupRequest{
  RegisterAcitivityGroupRequest({
    this.activities
  });

  Map toJson() => {"activities": activities == null ? null : activities};
  List<ActivityResult>? activities;
}

class SearchSesionResultResponse{
  SearchSesionResultResponse({
    this.state,
    this.suma,
    this.resta,
    this.multiplicacion,
    this.escritura,
    this.comparacion,
    this.conteo,
    this.rectaNumerica
  });
  int? state;
  double? suma;
  double? resta;
  double? multiplicacion;
  double? escritura;
  double? comparacion;
  double? conteo;
  double? rectaNumerica;
/* 
  factory SearchSesionResultResponse.fromJson(Map<String, dynamic> json) => SearchSesionResultResponse(
        state: json["state"],
        suma: json["suma"],
        resta: json["resta"],
        multiplicacion: json["multiplicacion"],
        escritura: json["escritura"],
        comparacion: json["comparacion"],
        conteo: json["conteo"],
        rectaNumerica: json["rectaNumerica"],
  ); */
}


