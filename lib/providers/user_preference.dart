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

  get userPasw {
    return _prefs.getString('userPasw')  ?? '';
  }

  set userPasw(String userPasw){
     _prefs.setString('userPasw', userPasw);
  }

  get teacherUserId {
    return _prefs.getString('teacherUserId') ?? '';
  }

  set teacherUserId(String teacherUserId){
     _prefs.setString('teacherUserId', teacherUserId);
  }

  get teacherUserPasw {
    return _prefs.getString('teacherUserPasw') ?? '';
  }

  set teacherUserPasw(String teacherUserPasw){
     _prefs.setString('teacherUserPasw', teacherUserPasw);
  }

  logOutStudent(){
   _prefs.remove('userId');
   _prefs.remove('userPasw');
  }
  logOutTeacher(){
   _prefs.remove('teacherUserId');
   _prefs.remove('teacherUserPasw');
  }

}