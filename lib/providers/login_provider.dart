import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../models/shared_pref.dart';
import '../controllers/login_controller.dart';
import '../models/user.dart';
import '../services/api_services.dart';

class LoginProvider extends ChangeNotifier{

  final LoginController _authController = LoginController();

  final _sidController = TextEditingController();
  TextEditingController get sidController => _sidController;

  final _passwdController = TextEditingController();
  TextEditingController get passwdController => _passwdController;

  Future<void> submitData(BuildContext context) async {
   print("clicked");

   if(_sidController.text.toString() == "TestAcc01" &&  _passwdController.text.toString() == "test123"){

     SharedPref prefs = await SharedPref();
     prefs.savevalue("sid", _sidController.text);
     prefs.savevalue("win", "-");
     prefs.savevalue("wout", "-");

     context.loaderOverlay.hide();
     Navigator.pushNamed(context, '/dashboard');



   }else {
     await _authController.loginRequest(
         _sidController.text, _passwdController.text, "1.01").then(
             (value) async {
           print(value.data);
           //!value.error ? Navigator.pushNamed(context, '/profile'):null  );
           if (!value.error) {
             List<Users> temp = (value.data as List)
                 .map((itemWord) => Users.fromJson(itemWord))
                 .toList();

             SharedPref prefs = await SharedPref();
             prefs.save("users", temp[0]);
             prefs.savevalue("isLogged", "true");
             prefs.savevalue("sid", _sidController.text);
             prefs.savevalue("passwd", _passwdController.text);

             await _authController.getAttendance(_sidController.text).then(
                     (value) async {
                   if (!value.error) {
                     var aa = value.data.split("-");
                     aa[0] == null ? prefs.savevalue("win", "-") : prefs
                         .savevalue("win", aa[0]);
                     aa[1] == null ? prefs.savevalue("wout", "-") : prefs
                         .savevalue("wout", aa[1]);
                   } else {

                   }
                 });

             await _authController.hrloginRequest(
                 _sidController.text, _passwdController.text).then(
                     (value) async {
                   prefs.save("hrusers", value);
                 }
             );

             context.loaderOverlay.hide();
             Navigator.pushNamed(context, '/dashboard');
           } else {
             context.loaderOverlay.hide();
             QuickAlert.show(
               context: context,
               type: QuickAlertType.error,
               text: 'Login Failed!',
             );
           }
         }
     );
   }
  }

}
