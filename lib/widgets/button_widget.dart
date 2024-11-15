import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../services/location_service.dart';

class buttonWidget extends StatelessWidget {
  const buttonWidget({
    required this.text,
    required this.fontSize,
    required this.color1,
    required this.color2,
    required this.event,


    Key? key,
  }) : super(key: key);


  final String text;
  final Color color1;
  final Color color2;
  final double fontSize;
  final String event;



  @override
  Widget build(BuildContext context) {

    final homeproviderService = Provider.of<HomeProvider>(context, listen: false);
    final locationService = LocationService();

    return Container(
      width: 160,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            color1,
            color2,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: () async {
           var aa = await locationService.getlocation(context);
           Logger().i(aa);
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  content: const Text('Please confirm the attendance request'),
                  actions: [
                    // The "Yes" button
                    MaterialButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: const Text('YES'),
                      onPressed: () {
                        //context.loaderOverlay.show();
                       // homeproviderService.submitAttendence(context,homeproviderService.userLoad.sID.toString(),homeproviderService.userLoad.cONTACTNO.toString(), event);
                       // Navigator.of(context).pop();

                      },
                    ),
                    MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: const Text('CANCEL'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child:  Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

}

