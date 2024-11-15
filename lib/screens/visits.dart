import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:hrgb/providers/visits_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Visits extends StatefulWidget {
  const Visits({super.key});

  @override
  State<Visits> createState() => _VisitsState();
}

class _VisitsState extends State<Visits> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VisitsProvider>(context, listen: false).loadCurrentVisits(context)
          .then((value) {setState(() {
      });});
    });

  }

  DateTime _selectedDate = DateTime.now();

  void _showMonthYearPicker(BuildContext context) async {
    var pickedDate = await DatePicker.showSimpleDatePicker(
      context,
      titleText: 'Select Month',
      dateFormat: "MMMM-yyyy",
      itemTextStyle: const TextStyle(fontSize: 22, color: Colors.lightBlue),
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = DateTime(pickedDate.year, pickedDate.month);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final visitsService = Provider.of<VisitsProvider>(context);
    TextEditingController dateInputController = TextEditingController(text: visitsService.cmonth);

    double width = MediaQuery.of(context).size.width ;
    double height = MediaQuery.of(context).size.height;

    final dateFormat = DateFormat('MMMM - yyyy');
    final formattedDate = dateFormat.format(_selectedDate);

    final startDate = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final endDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);

    final dateFormatDay = DateFormat('EEEE, MMM dd, yyyy');

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
                  const SizedBox(height: 50,),
                  const Center(
                    child: Text("VISITS DETAILS", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    width: width * 0.88,
                    height: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.date_range_outlined,color: Colors.white),
                        hintText: 'Date',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1)),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w700),
                      controller: dateInputController,
                      readOnly: true,
                      onTap: () async {
                        var pickedDate = await DatePicker.showSimpleDatePicker(
                          context,
                          titleText: 'Select Month',
                          dateFormat: "MMMM-yyyy",
                          itemTextStyle: TextStyle(fontSize: 22,color: Colors.lightBlue),
                          locale: DateTimePickerLocale.en_us,
                          looping: true,
                        );
                        if (pickedDate != null) {
                          dateInputController.text =
                              DateFormat('MMM-yyyy').format(pickedDate).toUpperCase();
                          Provider.of<VisitsProvider>(context, listen: false).loadCurrentVisits(context);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10,),

                  Container(
                      height: height * 0.70,
                      width: width * 0.89,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: visitsService.visitCount,
                          itemBuilder: (BuildContext context, int index) {
                            return  Card(
                              shadowColor: Colors.grey.shade600,
                              child: ExpansionTile(

                                title:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${DateFormat("EEEE, MMM d, yyyy").format(DateTime.parse(visitsService.dateList[index]['DATEONLY']))}',
                                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700,color: Colors.blue),),
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
                                  SingleChildScrollView(
                                    child: Container(
                                      height: 500,
                                      width: width * 0.89,
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: visitsService.listCount(index),
                                          itemBuilder: (BuildContext context, int index2) {
                                            return Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Card(
                                                shadowColor: Colors.green.shade500,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(visitsService.dateList[index]['VISITS'][index2]['SDATE'],
                                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700,color: Colors.green)),
                                                    SizedBox(height: 10,),
                                                    Text(visitsService.dateList[index]['VISITS'][index2]['VNOTE'],
                                                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700,color: Colors.blue)),
                                                    SizedBox(height: 10,),
                                                    Text(visitsService.dateList[index]['VISITS'][index2]['LAT'],
                                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700,color: Colors.red)),
                                                    SizedBox(height: 10,),
                                                    Text(visitsService.dateList[index]['VISITS'][index2]['LON'],
                                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700,color: Colors.red)),
                                                    SizedBox(height: 10,),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                  )

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
