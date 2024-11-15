
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../controllers/login_controller.dart';
import '../models/attendance_response.dart';
import '../models/general_response.dart';
import '../models/login_response.dart';
import '../models/shared_pref.dart';
import '../models/user.dart';
import '../utils/constants/asset_constant.dart';

class ApiServices{

  Future<GeneralResponse>userLogin(String sid,String password,String appversion) async {
    GeneralResponse generalResponce;

    Uri url = Uri.parse('${AssetConstants.baseUrl}/userlogin');
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',};

    var body = jsonEncode(<String, String>{
      'sid': sid,
      'password': password,
      'appversion': appversion,
    });

    try {
      final response = await http.post(url, headers: header, body: body);
      final data = json.decode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        generalResponce = GeneralResponse.fromJson(data);
      } else {
        generalResponce = GeneralResponse.fromJson(data);
      }
    }catch(e){
      generalResponce = GeneralResponse(
          error: true,
          message: 'Connection Error:${e.toString()} ');
    }
    return generalResponce;
  }

  Future<AttendanceResponse>dailyAttendenceRequest(String username,String adate,String authtoken) async {
    print(username+adate+authtoken);
    AttendanceResponse attendanceResponse;

    Uri url = Uri.parse('${AssetConstants.erpUrl}/attendance');
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'username': username,
      'searchdate': adate,
      'Authorization': 'Bearer $authtoken',
    };

    try {
      final response = await http.get(url, headers: header);
      final data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {
        attendanceResponse = AttendanceResponse.fromJson(data);
      } else {
        attendanceResponse = AttendanceResponse.fromJson(data);
      }
    }catch(e){
      attendanceResponse = AttendanceResponse(
          success: false,
          totDays: 0,
          );
    }

    return attendanceResponse;
  }

  Future<dynamic>hrUserLogin(String sid,String password,) async {
    String retValue = 'error';
    Uri url = Uri.parse('${AssetConstants.erpUrl}/login');
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',};

    var body = jsonEncode(<String, String>{
      'username': sid,
      'password': password,
    });

    try {
      final response = await http.post(url,headers: header, body:body);
      final data = json.decode(response.body);
      //print(response.body);
      if (response.statusCode == 200) {
        retValue = 'success';
        return data;
      }else{
        return data;
      }
    }catch(e){
      return {"success": false, "msg": e.toString()};
    }

  }

  Future<GeneralResponse>attendanceUpdate(String sid,String mobile,String action) async {
    GeneralResponse generalResponse;

    Uri url = Uri.parse('${AssetConstants.baseUrl}/attendenceUpdate');
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',};

    var body = jsonEncode(<String, String>{
      'sid': sid,
      'attend': action,
      'mobile': mobile,
    });

    try {
      final response = await http.post(url, headers: header, body: body);
      final data = json.decode(response.body);
      print(response.body);
      generalResponse = GeneralResponse.fromJson(data);

    }catch(e){
      print(e);
      generalResponse = GeneralResponse(
          error: true,
          message: 'Connection Error:${e.toString()}',
          data: [] );
    }
    return generalResponse;
  }

  Future<GeneralResponse>visitsUpdate(String sid,String lat,String lon,String notes) async {
    GeneralResponse generalResponse;

    Uri url = Uri.parse('${AssetConstants.baseUrl}/visitsUpdate');
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',};

    var body = jsonEncode(<String, String>{
      'sid': sid,
      'lat': lat,
      'lon': lon,
      'note': notes,
    });

    try {
      final response = await http.post(url, headers: header, body: body);
      final data = json.decode(response.body);
      print(response.body);
      generalResponse = GeneralResponse.fromJson(data);

    }catch(e){
      print(e);
      generalResponse = GeneralResponse(
          error: true,
          message: 'Connection Error:${e.toString()}',
          data: [] );
    }
    return generalResponse;
  }

  Future<GeneralResponse>getAttendance(String sid) async {
    GeneralResponse generalResponce;

    Uri url = Uri.parse('${AssetConstants.baseUrl}/getAttendance');
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',};

    var body = jsonEncode(<String, String>{
      'sid': sid,
    });

    try {
      final response = await http.post(url, headers: header, body: body);
      final data = json.decode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        generalResponce = GeneralResponse.fromJson(data);
      } else {
        generalResponce = GeneralResponse.fromJson(data);
      }
    }catch(e){
      generalResponce = GeneralResponse(
          error: true,
          message: 'Connection Error:${e.toString()} ');
    }
    return generalResponce;
  }

  Future<GeneralResponse>getVisits(String sid,String month) async {
    GeneralResponse generalResponce;

    Uri url = Uri.parse('${AssetConstants.baseUrl}/getVisits');
    var header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',};

    var body = jsonEncode(<String, String>{
      'sid': sid,
      'month': month,
    });

    try {
      final response = await http.post(url, headers: header, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        generalResponce = GeneralResponse.fromJson(data);
      } else {
        generalResponce = GeneralResponse.fromJson(data);
      }
    }catch(e){
      generalResponce = GeneralResponse(
          error: true,
          message: 'Connection Error:${e.toString()} ');
    }
    return generalResponce;
  }


}