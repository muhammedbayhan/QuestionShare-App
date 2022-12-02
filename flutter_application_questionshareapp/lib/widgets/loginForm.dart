import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  TextEditingController controllerText = TextEditingController();
  String formText = "";
  bool obsureTextShow;
  Icon formIcon;
  LoginForm(this.formText,this.formIcon,this.obsureTextShow,this.controllerText);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsureTextShow,
      keyboardType: TextInputType.emailAddress,
      controller: controllerText,
      decoration:
          InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)), labelText: formText,prefixIcon: formIcon),
    );
  }
}
