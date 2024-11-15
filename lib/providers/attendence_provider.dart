import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import  'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../controllers/attendence_controller.dart';
import 'home_provider.dart';

class AttendenceProvider extends ChangeNotifier{

  final AttendenceController _attendenceController = AttendenceController();



  String adate = '01-${DateFormat("MMM-yyyy").format(DateTime.now()).toUpperCase()}';

  List<String> years = ['2023', '2022', '2021', '2020']; // Option 2
  final List<String> months = <String>['Jan','Feb','May','Apr','May','Jun', 'Jul','Aug','Sep','Oct','Nov','Dec'];
  final cmonth = DateFormat("MMM-yyyy").format(DateTime.now());
  String _selectedLocation = DateFormat("yyyy").format(DateTime.now());
  String? cpresent , cleave, clate;

  late List<dynamic> attendanceList;
  List get attendance => attendanceList;

  int  _attCount=0 ;
  get attCount => _attCount;

  int _preset=0, _leave=0, _late=0;

  get present => _preset;
  get leave => _leave;
  get late => _late;

  get selectedLocation => _selectedLocation;


  void setLocation(String location ) {
    _selectedLocation = location;
    notifyListeners();
  }

  final _dateInputController = TextEditingController();
  TextEditingController get dateInputController => _dateInputController;


  Future<void> loadCurrentAttendance(BuildContext context) async {
    print("attendenc clicked");
    _preset=0;
    _late=0;
    _leave=0;
    await _attendenceController.dailyAttendenceRequest(Provider.of<HomeProvider>(context,listen: false).users.sID.toString(),
        adate, Provider.of<HomeProvider>(context,listen: false).hrusers.authtoken.toString()).then(
            (value) async {
          //!value.error ? Navigator.pushNamed(context, '/profile'):null  );
          if(value.success){
            context.loaderOverlay.hide();
             attendanceList = value.data;
            _attCount = value.totDays;


            for( int i = 0 ; i < attendanceList.length; i++ ) {
              attendanceList[i]['IN_TIME'] != null ?
                _preset++ :
              attendanceList[i]['HOLDAY'] == 'Y' ? _leave :
              DateFormat("EEEE").format(DateTime.parse(attendanceList[i]['LOGDATE']))== 'Sunday' ? _leave :
              DateFormat("EEEE").format(DateTime.parse(attendanceList[i]['LOGDATE']))== 'Saturday' ? _leave : _leave++;

            }

            print(_preset);
            print(_preset);

          }else{
            context.loaderOverlay.hide();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: value.success.toString(),
            );
          }
        }
    );
  }

  Future<void> loadSelectedAttendance(BuildContext context) async {
    print("attendenc clicked selected");
    print(_dateInputController.text);
    attendanceList.clear();
    _preset=0;
    _late=0;
    _leave=0;
    adate = '01-${_dateInputController.text}';
    await _attendenceController.dailyAttendenceRequest(Provider.of<HomeProvider>(context,listen: false).users.sID.toString(),
        adate, Provider.of<HomeProvider>(context,listen: false).hrusers.authtoken.toString()).then(
            (value) async {
          //!value.error ? Navigator.pushNamed(context, '/profile'):null  );
          if(value.success){
            context.loaderOverlay.hide();
            attendanceList = value.data;
            _attCount = value.totDays;

            for( int i = 0 ; i < attendanceList.length; i++ ) {
              attendanceList[i]['IN_TIME'] != null ?
              _preset++ :
              attendanceList[i]['HOLDAY'] == 'Y' ? _leave :
              DateFormat("EEEE").format(DateTime.parse(attendanceList[i]['LOGDATE']))== 'Sunday' ? _leave :
              DateFormat("EEEE").format(DateTime.parse(attendanceList[i]['LOGDATE']))== 'Saturday' ? _leave : _leave++;

            }

            print(_preset);
            print(_preset);

          }else{
            context.loaderOverlay.hide();
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text: value.success.toString(),
            );
          }
        }
    );
  }



}
