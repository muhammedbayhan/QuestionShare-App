import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebaseproject/screens/login_Screen.dart';
import 'package:flutter_application_firebaseproject/widgets/loginForm.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailControllerRegister = TextEditingController();
  TextEditingController passwordControllerRegister = TextEditingController();
  TextEditingController emailControllerRegister1 = TextEditingController();
  TextEditingController passwordControllerRegister1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/logint1.gif",
              height: 190,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Create new account! ',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'MobilRegular',
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LoginForm('Email', Icon(Icons.mail), false,
                      emailControllerRegister),
                  SizedBox(
                    height: 10,
                  ),
                  LoginForm('re-enter email', Icon(Icons.mail), false,
                      emailControllerRegister1),
                  SizedBox(
                    height: 10,
                  ),
                  LoginForm('Password', Icon(Icons.key), true,
                      passwordControllerRegister),
                  SizedBox(
                    height: 10,
                  ),
                  LoginForm('re-enter Password', Icon(Icons.key), true,
                      passwordControllerRegister1),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (emailControllerRegister.text ==
                              emailControllerRegister1.text &&
                          passwordControllerRegister.text ==
                              passwordControllerRegister1.text &&
                          emailControllerRegister.text != '' &&
                          passwordControllerRegister.text != '') {
                        register();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            ((route) => false));
                        errorMessage('Registration Successful!');
                      } else {
                        errorMessage('Please Enter Correct Values!');
                      }
                    },
                    child: Text("Sign Up"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      ((route) => false));
                },
                child: Text(
                  'sign in instead',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'MobilRegular',
                      color: Colors.blue),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> register() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailControllerRegister.text,
              password: passwordControllerRegister.text)
          .then((value) {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(emailControllerRegister.text)
            .set({
          'email': emailControllerRegister.text,
          'sifre': passwordControllerRegister.text,
        });
      });
    } catch (e) {
      errorMessage('Something went wrong, check again!');
    }
  }

  errorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
