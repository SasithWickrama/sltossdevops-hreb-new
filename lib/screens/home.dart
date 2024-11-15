import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hrgb/screens/attendance.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../providers/visits_provider.dart';
import '../utils/constants/colors.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_page_route.dart';
import '../widgets/world_clock.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      Provider.of<HomeProvider>(context, listen: false).loadUserPrefs().then((value) {setState(() {
      });});
    });

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageIndex = index; // Update pageIndex for CurvedNavigationBar
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          FadePageRoute(page: const Home()), // Stay on the HomePage
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          FadePageRoute(page: const Attendance()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          FadePageRoute(page: const Home()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width ;
    double height = MediaQuery.of(context).size.height;
    var imgVariable;

    final homeproviderService = Provider.of<HomeProvider>(context, listen: false);
    String uImage = 'https://serviceportal.slt.lk/ApiNeylie/img/${homeproviderService.userLoad.sID.toString()}.png';
    //String uImage = 'https://serviceportal.slt.lk/ApiNeylie/img/default.png';



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
            Positioned(
              top: 20.0, // Adjust as needed
              right: 20.0, // Adjust as needed
              child: InkWell(
                  onTap: (){
                    homeproviderService.logout(context);
                  } ,
                  child: Icon(Icons.logout,color: Colors.white,size: 30,)),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: SizedBox(
                      width: 110.0,
                      height: 110.0,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        width: 75,
                        height: 75,
                        decoration:  BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(uImage),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    homeproviderService.userLoad.nAME.toString(),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    homeproviderService.userLoad.tITLE.toString(),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // const WorldClock(),
                  const SizedBox(height: 10.0),
                  Container(
                    width: width * 0.9,
                    height: height * 0.3,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(173, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(6, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: WorldClock(),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 5.0),
                                          buttonWidget(text: 'WORK IN',color1: btnteal,color2: btngreenAccent,fontSize: 14,event: 'IN'),
                                            const SizedBox(height: 35.0),
                                            Column(
                                              children: [
                                                Text(
                                                  "In Time",
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                Text(
                                                  homeproviderService.wIn,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 5.0),
                                          buttonWidget(text: 'WORK OUT',color1: btnRed,color2: btnOrange,fontSize: 14,event: 'OUT'),
                                            const SizedBox(height: 35.0),
                                            Column(
                                              children: [
                                                Text(
                                                  "Out Time",
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                Text(
                                                  homeproviderService.wOut,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    ],
                  ),
                  const SizedBox(height: 32.0), // Add spacing between rows
                  Container(
                    width: width * 0.9,
                    height: 55,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.lightBlueAccent,
                          Colors.blue,
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(21),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _showAddNotesDialog, // Call the method to show the popup
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'ADD NOTES',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                      
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _showAddNotesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Visit Notes'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: Provider.of<VisitsProvider>(context).visitNoteController,
                  maxLines: 3,// Set max lines to make it a text area
                  decoration: const InputDecoration(
                    hintText: 'Enter your notes here',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            MaterialButton(
            color: Colors.red,
            textColor: Colors.white,
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {

              });

            },
          ),
          MaterialButton(
          color: Colors.green,
          textColor: Colors.white,
          child: const Text('UPDATE'),
          onPressed: () {
          context.loaderOverlay.show();
          Provider.of<VisitsProvider>(context, listen: false).submitVisits(context);
          },
          ),
        ],
        );
      },
    );
  }
}
