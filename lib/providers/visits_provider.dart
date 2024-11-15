import 'dart:async';
import 'package:hrgb/services/location_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import  'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../controllers/attendence_controller.dart';
import '../controllers/location_controller.dart';
import 'home_provider.dart';
import 'location_provider.dart';

class VisitsProvider extends ChangeNotifier{

  final cmonth = DateFormat("MMM-yyyy").format(DateTime.now());

  final _visitNoteController = TextEditingController();
  TextEditingController get visitNoteController => _visitNoteController;

  Position? _currentPosition;

  final LocationController _locController = LocationController();
  final AttendenceController _attendenceController = AttendenceController();

  String adate = DateFormat("MM/yyyy").format(DateTime.now()).toString();

  late List<dynamic> visitsList;
  List get visits => visitsList;

  late List<dynamic> dailyvisitsList;
  List get dailyvisits => dailyvisitsList;

  List<dynamic> dateList=[];
  List get datelist => dateList;

  late List<dynamic> finalList;
  List get finallist => finalList;

  int  _visitCount=0;
  get visitCount => _visitCount;


  Future<void> loadCurrentVisits(BuildContext context) async {
    _visitCount = 0;
    await _attendenceController.getVisits(Provider.of<HomeProvider>(context,listen: false).users.sID.toString(),
        adate).then(
            (value) async {
          //!value.error ? Navigator.pushNamed(context, '/profile'):null  );
          if(!value.error){
            context.loaderOverlay.hide();
            visitsList = value.data;

            for( int i = 0 ; i < visitsList.length; i++ ) {
              dateList.add(visitsList[i]);
              Logger().d(visitsList[i]["DATEONLY"]);
              _visitCount++;
            }
              Logger().d(dateList[0]['VISITS'][0]['SDATE']);
          }else{
            context.loaderOverlay.hide();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: value.message.toString(),
            );
          }
        }
    );
  }


  Future<void> submitVisits(BuildContext context) async {

    final homeproviderService = Provider.of<HomeProvider>(context, listen: false);
    final locationproviderService = Provider.of<LocationProvider>(context, listen: false);

    await locationproviderService.getCurrentPosition(context);

    await _locController.updateVisits(
        homeproviderService.userLoad.sID.toString(), locationproviderService.position!.latitude.toString(),
        locationproviderService.position!.longitude.toString(),_visitNoteController.text).then(
            (value) async {
          if(!value.error) {
            _visitNoteController.clear();
            context.loaderOverlay.hide();
            QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: 'Visit Notes Update Successfully!',
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
              text: 'Visit Notes Update Failed!',
            );
          }
        }
    );

  }

  int listCount(int index ){

    List<dynamic> dataList=[];
    dataList = datelist[index]['VISITS'];

    return dataList.length;
  }


}

