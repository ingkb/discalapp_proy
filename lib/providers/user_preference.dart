import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario{

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  //String _userId;
  //String _teacherUserId;

  factory PreferenciasUsuario(){
    return _instancia;
  }
  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async{
    this._prefs = await SharedPreferences.getInstance();
  }

  get userId {
    return _prefs.getString('userId')  ?? '';
  }

  set userId(String userId){
     _prefs.setString('userId', userId);
  }

  get teacherUserId {
    return _prefs.getString('teacherUserId') ?? '';
  }

  set teacherUserId(String teacherUserId){
     _prefs.setString('teacherUserId', teacherUserId);
  }

}