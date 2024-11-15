import 'package:flutter/material.dart';
import '../models/shared_pref.dart';
import '../models/user.dart';
import '../utils/constants/colors.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    loadSharedPrefs();

  }

  Users userLoad = Users();
  HrUsers hruserLoad = HrUsers() ;
  SharedPref prefs =  SharedPref();
  late String tdata;


  loadSharedPrefs() async {
    Users user = Users.fromJson(await prefs.read("users"));
    HrUsers hruser = HrUsers.fromJson(await prefs.read("hrusers") );
    setState(() {
      userLoad = user;
      hruserLoad = hruser;
    });
  }


  @override
  Widget build(BuildContext context) {

    String uImage = 'https://serviceportal.slt.lk/ApiNeylie/img/${userLoad.sID}.png';
    //String uImage = 'https://serviceportal.slt.lk/ApiNeylie/img/null.png';
    double width = MediaQuery.of(context).size.width ;
    double height = MediaQuery.of(context).size.height;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),

                          ]
                      ),
                      margin: EdgeInsets.only(top: 50,left: 15,right: 15,bottom: 40),
                      width: width * 0.92,
                      height: height *0.76,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                            width: 120,
                            height: 120,
                            decoration:  BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(uImage)),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Column(
                            children: [
                              Text(hruserLoad.name.toString(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24,color: signInButton,),),
                              const SizedBox(height: 10,),
                              Text(userLoad.tITLE.toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 14),),
                              const SizedBox(height: 75,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 60),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.mail,color: Colors.cyan,),
                                    const SizedBox(width: 15,),
                                    Text(userLoad.mAIL.toString(),style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 35,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 60),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.people,color: Colors.cyan,),
                                    const SizedBox(width: 15,),
                                    Text(userLoad.gROUP.toString(),style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 35,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 60),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.mobile_friendly,color: Colors.cyan,),
                                    const SizedBox(width: 15,),
                                    Text(userLoad.cONTACTNO.toString(),style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }
}

