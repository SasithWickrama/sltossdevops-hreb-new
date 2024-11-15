import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../providers/attendence_provider.dart';
import '../utils/constants/colors.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AttendenceProvider>(context, listen: false).loadCurrentAttendance(context)
          .then((value) {setState(() {

      });});
    });

  }

  DateTime _selectedDate = DateTime.now();



  @override
  Widget build(BuildContext context) {

    final attendanceproviderService = Provider.of<AttendenceProvider>(context);

    double width = MediaQuery.of(context).size.width ;
    double height = MediaQuery.of(context).size.height;

    final dateFormat = DateFormat('MMMM - yyyy');
    final formattedDate = dateFormat.format(_selectedDate);

    // Define the start and end dates
    final startDate = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final endDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);

    // Define the date format for displaying the range
    final dateFormatDay = DateFormat('EEEE, MMM dd, yyyy');

    // Generate the list of dates for the month
    List<String> dates = [];
    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate.add(const Duration(days: 1)))) {
      dates.add(dateFormatDay.format(currentDate));
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0.1,
                    0.4,
                    0.6,
                  ],
                  colors: [
                    Colors.blueAccent,
                    Colors.blue,
                    Colors.teal,
                  ],
                ),
              ),
            ),
            // Back button
            SingleChildScrollView(
              child: Column(
                children:  [
                  const SizedBox(height: 40,),
                  const Center(
                    child: Text("ATTENDANCE", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                  ),
                  const SizedBox(height: 50,),
                  Container(
                    width: width * 0.88,
                    height: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.date_range_outlined,color: Colors.white),
                        hintText: 'SELECT MONTH',
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 5)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 3)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 3)),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),
                      controller: attendanceproviderService.dateInputController,
                      readOnly: true,
                      onTap: ()  async {

                        var pickedDate = await DatePicker.showSimpleDatePicker(
                          context,
                          titleText: 'Select Month',
                          dateFormat: "MMMM-yyyy",
                          itemTextStyle: TextStyle(fontSize: 22,color: Colors.lightBlue),
                          locale: DateTimePickerLocale.en_us,
                          looping: true,
                        );
                        if (pickedDate != null) {
                          attendanceproviderService.dateInputController.text =
                              DateFormat('MMM-yyyy').format(pickedDate).toUpperCase();
                          context.loaderOverlay.show();
                          await Provider.of<AttendenceProvider>(context, listen: false).loadSelectedAttendance(context);

                        }else{
                          attendanceproviderService.dateInputController.text = attendanceproviderService.cmonth;
                        }
                        setState(() {

                        });



                      },
                    ),
                  ),
                  SizedBox(height: 35,),

                  Container(
                      height: height * 0.65,
                      width: width * 0.89,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: attendanceproviderService.attCount,
                          itemBuilder: (BuildContext context, int index) {
                            return  Card(
                              shadowColor: Colors.grey.shade600,
                              child: ExpansionTile(

                                title:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${DateFormat("EEEE, MMM d, yyyy").format(DateTime.parse(attendanceproviderService.attendanceList[index]['LOGDATE']))}',
                                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700,
                                        color: (attendanceproviderService.attendanceList[index]['HOLDAY'] == 'Y') ? tileColorHoy : (DateFormat("EEEE").format(DateTime.parse(attendanceproviderService.attendanceList[index]['LOGDATE']))== 'Sunday') ? tileColorSun : (DateFormat("EEEE").format(DateTime.parse(attendanceproviderService.attendanceList[index]['LOGDATE']))== 'Saturday') ? tileColorSat :  signInButton,),
                                    ),
                                    //Icon(Icons.add,color: Colors.red,)
                                  ],
                                ),
                                children: <Widget>[
                                  const Divider(
                                    color: Colors.black,
                                    height: 25,
                                    thickness: 2,
                                    indent: 5,
                                    endIndent: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    child: Column(
                                      children:  [
                                        Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              child: Text("In Time   :",style: TextStyle(color: signInButton,fontSize: 17,fontWeight: FontWeight.w500),),
                                            ),
                                            Container(
                                              width: 150,
                                              child: (attendanceproviderService.attendanceList[index]['IN_TIME'] == null) ? Text("-",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),) :
                                              Text(attendanceproviderService.attendanceList[index]['IN_TIME'].toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              child: Text("Out Time   :",style: TextStyle(color: signInButton,fontSize: 17,fontWeight: FontWeight.w500),),
                                            ),
                                            Container(
                                              width: 150,
                                              child: (attendanceproviderService.attendanceList[index]['OUT_TIME'] == null) ? Text("-",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),) :
                                              Text(attendanceproviderService.attendanceList[index]['OUT_TIME'].toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),



                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
