import 'dart:convert';
import 'package:discalapp_proy/models/sesion_model.dart';
import 'package:http/http.dart' as http;
import '../enviroment.dart';


class SesionService{

  Future<RegisterSesionResponse> addSesion(Sesion sesion) async{
    var url = Uri.parse(BaseUrl+'/sesions');
    final http.Response response = await http.post(url, 
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
    var url = Uri.parse(BaseUrl+'/sesions/'+code);
    final response = await http.get(url);


    if(response.statusCode == 200){
      return SearchSesionResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar sesion');
    }
  }

  Future<SearchAllSesionResponse> getAllSesion(String studentId) async{
    var url = Uri.parse(BaseUrl+'/sesions/student/'+studentId);
    final response = await http.get(url);

    if(response.statusCode == 200){
      return SearchAllSesionResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al encontrar sesion');
    }
  }

  Future<RegisterSesionResponse> deleteSesion(String code) async{
    var url = Uri.parse(BaseUrl+'/sesions/'+code);
    final http.Response response = await http.delete(url, 
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

  Future<RegisterSesionResponse> updateSesion(String sesionid, bool estado) async{
    var url = Uri.parse(BaseUrl+'/sesions');
    final http.Response response = await http.patch(url, 
     body: json.encode(new UpdateSesionRequest(sesionId: sesionid,estado:estado).toJson()),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    print(response.body);
    if(response.statusCode == 200){
      return RegisterSesionResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fallo al modificar sesion');
    }
  }
}

class UpdateSesionRequest{
  UpdateSesionRequest({
    this.estado,
    this.sesionId
  });
  bool estado;
  String sesionId;

  Map toJson() => {
    "sesionId": sesionId == null ? null : sesionId,
    "estado": estado == null ? null : estado,
  };
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



