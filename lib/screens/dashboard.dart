import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hrgb/screens/attendance.dart';
import 'package:hrgb/screens/profile.dart';
import 'package:hrgb/screens/visits.dart';
import 'home.dart';


class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  int selectedpage =0;
  final _pageNo = [Home() ,Attendance() ,Visits(), Profile()];

  @override
  Widget build(BuildContext context) {

    var data = ModalRoute.of(context)?.settings.arguments;
    data != null ? selectedpage = int.parse(data.toString()) : selectedpage =0 ;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false ,
        child: Scaffold(
          body: Container(
            child: _pageNo[selectedpage],
          ),
          bottomNavigationBar: ConvexAppBar(
            height: 50,
            color: Colors.white,
            backgroundColor: Colors.lightBlue,
            items: const [
              TabItem(icon: Icons.home, title: 'Home',),
              TabItem(icon: Icons.calendar_month, title: 'Attendance'),
              TabItem(icon: Icons.newspaper, title: 'Visits'),
              TabItem(icon: Icons.manage_accounts, title: 'Profile'),
            ],
            initialActiveIndex: selectedpage,
            onTap: (int index){
              print(index);
              setState(() {
                Navigator.pushNamed(context, '/dashboard',arguments: index);
                selectedpage = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
