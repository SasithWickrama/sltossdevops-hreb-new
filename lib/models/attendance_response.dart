class AttendanceResponse {
  final bool success;
  final int totDays;
  var data;

  AttendanceResponse({this.success= true, required this.totDays , this.data=null});

  factory AttendanceResponse.fromJson(Map<String, dynamic> responsejson) {
    final success   = responsejson['success'] as bool;
    final totDays = responsejson['total_days_count'];
    final data    =  responsejson['data'] ?? "";

    return AttendanceResponse(success: success, totDays: totDays, data: data);
  }

}