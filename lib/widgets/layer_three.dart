//import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hrgb/widgets/text_formfield.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../models/shared_pref.dart';
import '../providers/login_provider.dart';
import '../utils/constants/colors.dart';

class LayerThree extends StatefulWidget {
  const LayerThree({Key? key}) : super(key: key);

  @override
  State<LayerThree> createState() => _LayerThreeState();
}

class _LayerThreeState extends State<LayerThree> {

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final validationService = Provider.of<LoginProvider>(context);
    bool isChecked = false;
    String _buttonText = 'Sign In';


    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30,),
              Text("LOGIN",style: TextStyle(color: signInButton, fontWeight: FontWeight.w900,fontSize: 30),),
              const SizedBox(height: 30,),
              TextFormFieldWidget(errortext1: "Service ID",errortext2: "", hinttext: "Service ID",
                  labletext: "Service ID",keyboardType: TextInputType.text,icon: Icons.person,
                  customController: Provider.of<LoginProvider>(context).sidController),
              const SizedBox(height: 20,),
              TextFormFieldWidget(errortext1: "Password",errortext2: "", hinttext: "Password",
                  labletext: "Password",keyboardType: TextInputType.text,icon: Icons.lock,isObscureText: true,
                  customController: Provider.of<LoginProvider>(context).passwdController),
              const SizedBox(height: 50,),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: (){
                    if (_formKey.currentState!.validate()) {
                      context.loaderOverlay.show();
                      Provider.of<LoginProvider>(context, listen: false).submitData(context);
                    }
                    //Navigator.pushNamed(context, '/dashboard');
                  },
                  child: Container(
                    width: 150,
                    height: 60,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.teal,
                          Colors.greenAccent,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Text(
                        _buttonText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
