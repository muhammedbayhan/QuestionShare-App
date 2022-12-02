import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_firebaseproject/screens/main_Screen.dart';

import 'package:flutter_application_firebaseproject/widgets/loginForm.dart';

import '../widgets/bottomNavigationBar.dart';

class AddQuestionPage extends StatefulWidget {
  const AddQuestionPage({super.key});

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  TextEditingController soruBaslikContoller = TextEditingController();
  TextEditingController soruIcerikContoller = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarMenu(),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(
                  "assets/question.gif",
                  height: 200,
                ),
                LoginForm('Question Title', Icon(Icons.question_answer), false,
                    soruBaslikContoller),
                SizedBox(
                  height: 10,
                ),
                LoginForm('Your question...', Icon(Icons.question_mark), false,
                    soruIcerikContoller),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    addQuestion();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),
                        ((route) => false));
                  },
                  child: Text("To Ask"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  addQuestion() {
    FirebaseFirestore.instance
        .collection("Questions")
        .doc(soruBaslikContoller.text)
        .set({
      'baslik': soruBaslikContoller.text,
      'icerik': soruIcerikContoller.text,
      'kullaniciID': auth.currentUser!.email,
    });
  }
}
