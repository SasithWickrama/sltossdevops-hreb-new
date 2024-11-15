import 'package:flutter/material.dart';

import '../widgets/layer_one.dart';
import '../widgets/layer_three.dart';
import '../widgets/layer_two.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 100,
                  left: 45,
                  child: Container(
                    child: const Text(
                      'HRMS - GB',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  )),
              Positioned(top: 200, right: 0, bottom: 0, child: LayerOne()),
              Positioned(top: 220, right: 0,left: 20, bottom: 28, child: LayerTwo()),
              Positioned(top: 224, right: 0, left: 20,bottom: 48, child: LayerThree()),
            ],
          ),
        ),
      ),
    );
  }
}
