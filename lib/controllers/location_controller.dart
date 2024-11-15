import '../models/general_response.dart';
import '../services/api_services.dart';

class LocationController {

  Future<GeneralResponse> updateVisits (String sid,String lat, String lon, String notes) async {
    return await ApiServices().visitsUpdate(sid,lat, lon,notes);
  }


}

