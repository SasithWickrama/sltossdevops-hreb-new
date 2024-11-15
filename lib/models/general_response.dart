
class GeneralResponse {
  final bool error;
  final String message;
  var data;

  GeneralResponse({this.error= true, this.message = '', this.data=null});

  factory GeneralResponse.fromJson(Map<String, dynamic> responsejson) {
    final error   = responsejson['error'] as bool;
    final message = responsejson['message'] as String;
    final data    = responsejson['data'] ?? "";

    return GeneralResponse(error: error, message: message, data: data);
  }

}