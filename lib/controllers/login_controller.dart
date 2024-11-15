import '../models/general_response.dart';
import '../services/api_services.dart';

class LoginController{

  Future<GeneralResponse> loginRequest(String sid, String passwd, String app) async {
    return await ApiServices().userLogin(sid, passwd, app);
  }

  Future<dynamic> hrloginRequest(String sid, String passwd) async {
    return await ApiServices().hrUserLogin(sid, passwd);
  }

  Future<GeneralResponse> getAttendance (String sid) async {
    return await ApiServices().getAttendance(sid);
  }

}


