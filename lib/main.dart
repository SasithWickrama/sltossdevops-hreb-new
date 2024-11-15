import 'package:flutter/material.dart';
import 'package:hrgb/providers/attendence_provider.dart';
import 'package:hrgb/providers/home_provider.dart';
import 'package:hrgb/providers/location_provider.dart';
import 'package:hrgb/providers/login_provider.dart';
import 'package:hrgb/providers/visits_provider.dart';
import 'package:hrgb/screens/dashboard.dart';
import 'package:hrgb/screens/home.dart';
import 'package:hrgb/screens/login.dart';
import 'package:hrgb/screens/splash.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await initializeService();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => LoginProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => AttendenceProvider()),
      ChangeNotifierProvider(create: (context) => VisitsProvider()),
      ChangeNotifierProvider(create: (context) => LocationProvider()),

    ],
    child: const MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) { //ignored progress for the moment
        return const Center(
          child: SpinKitCubeGrid(
            color: Colors.lightBlueAccent,
            size: 50.0,
          ),
        );
      },
      overlayColor: Colors.black.withOpacity(0.8),
      duration: Duration(seconds: 1),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hr Module',
        initialRoute: '/',
        routes: {
          '/': (context) => const Splash(),
          '/login': (context) => const Login(),
          '/dashboard': (context) => const MainHome(),
          '/home': (context) => const Home(),
        },
      ),
    );
  }
}


