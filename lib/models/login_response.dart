
import 'package:hrgb/models/user.dart';

class LoginResponse{

  LoginResponse({required this.error, required this.message, required this.data});

  final bool error;
  final String message;
  final List<Users> data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final error = json['error'] as bool;
    final message = json['message'] as String;
    final resdata = json['data'] as List<dynamic>;

    final List<Users> data = resdata.map((dynamic item) => Users.fromJson(item)).toList();

    return LoginResponse(error: error, message: message, data: data);
  }


}