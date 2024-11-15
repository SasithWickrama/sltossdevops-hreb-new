import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../controllers/attendence_controller.dart';
import '../controllers/location_controller.dart';
import '../models/shared_pref.dart';
import '../models/user.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../services/location_service.dart';

class HomeProvider extends ChangeNotifier{

  final SharedPref prefs =  SharedPref();

  String wIn="-", wOut="-";

  Users userLoad = Users();
  Users get users => userLoad;

  HrUsers hruserLoad = HrUsers();
  HrUsers get hrusers => hruserLoad;

  Position? _currentPosition;
  final LocationController _locController = LocationController();

  Future<void> loadUserPrefs() async {

    Users user = Users.fromJson(await prefs.read("users"));
    userLoad = user;

    HrUsers hrusers = HrUsers.fromJson(await prefs.read("hrusers") );
    hruserLoad = hrusers;

    wIn = await prefs.readvalue("win");
    wOut = await prefs.readvalue("wout");


  }

  Future<void> logout(BuildContext context) async {
    SharedPref prefs = await SharedPref();
    prefs.savevalue("isLogged", "false");

    Navigator.pushNamed(context, '/login');
  }

  Future<void> submitAttendence(BuildContext context,String sid,String mobile, String event) async {
    final AttendenceController _attendenceController = AttendenceController();


    await _attendenceController.attendanceUpdate(sid,mobile, event).then(
    (value) async {
      print(value);
      if(!value.error) {
        context.loaderOverlay.hide();
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: value.message,
            confirmBtnText: 'Ok',
            onConfirmBtnTap: (){

              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/main_home');
            }

        );

      }else{
        context.loaderOverlay.hide();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: value.message,
        );
      }
    });

  }


}









