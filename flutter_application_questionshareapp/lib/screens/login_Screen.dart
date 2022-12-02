import 'package:flutter/material.dart';
import 'package:flutter_application_firebaseproject/screens/main_Screen.dart';
import 'package:flutter_application_firebaseproject/screens/register_Screen.dart';
import 'package:flutter_application_firebaseproject/widgets/loginForm.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isLogin = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/logint1.gif",
              height: 200,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  LoginForm('Email', Icon(Icons.mail), false, emailController),
                  SizedBox(
                    height: 20,
                  ),
                  LoginForm('Password', Icon(Icons.key), true, passwordController),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: login,
                    child: Text("Log in"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              width: 300,
              child: Divider(
                color: Colors.black,
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                      ((route) => false));
                },
                child: Text(
                  'Don’t have an account?',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          ((route) => false));
    }).catchError((dynamic error) {
      if (error.toString().contains('invalid-email')) {
        errorMessage('invalid-email');
      }
      if (error.toString().contains('user-not-found')) {
        errorMessage('user-not-found');
      }
      if (error.toString().contains('wrong-password')) {
        errorMessage('wrong-password');
      }
    });
  }

  errorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
