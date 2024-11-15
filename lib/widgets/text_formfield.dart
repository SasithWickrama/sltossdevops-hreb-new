import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.errortext1,
    required this.errortext2,
    required this.hinttext,
    required this.labletext,
    required this.icon,
    required this.keyboardType,
    this.isObscureText = false,
    required this.customController,
  }) : super(key: key);

  final String errortext1;
  final String errortext2;
  final String hinttext;
  final String labletext;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isObscureText;
  final TextEditingController customController;

  @override
  Widget build(BuildContext context) {
    late  int maxline;
    hinttext == "Notes"? maxline = 3: maxline = 1;
    return TextFormField(
      controller: customController,
      obscureText: isObscureText,
      keyboardType: keyboardType,
      maxLines: maxline,
      validator: MultiValidator([
        RequiredValidator(errorText: errortext1,),
        //MinLengthValidator(3, errorText: errortext2),
        //EmailValidator(errorText: errortext2),
        //PatternValidator(r'(^[0,9]{10}$)', errorText: errortext2),
      ]),
      decoration:  InputDecoration(
          hintText: hinttext,
          labelText: labletext,
          prefixIcon: Icon(icon, color: Colors.lightBlue,),
          errorStyle: const TextStyle(fontSize: 14.0),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius:
              BorderRadius.all(Radius.circular(9.0)))),
    );
  }
}