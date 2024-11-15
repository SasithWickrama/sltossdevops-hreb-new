import '../models/attendance_response.dart';
import '../models/general_response.dart';
import '../models/login_response.dart';
import '../services/api_services.dart';

class AttendenceController{

  Future<AttendanceResponse> dailyAttendenceRequest(String username, String adate,String authorization ) async {
    return await ApiServices().dailyAttendenceRequest(username, adate,authorization);
  }

  Future<GeneralResponse> attendanceUpdate (String sid,String mobile, String action) async {
    return await ApiServices().attendanceUpdate(sid,mobile, action);
  }

  Future<GeneralResponse> getVisits(String sid,String month) async {
    return await ApiServices().getVisits(sid,month);
  }


}