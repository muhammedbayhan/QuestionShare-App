import 'package:flutter/material.dart';

import '../screens/addQuestion_Screen.dart';
import '../screens/main_Screen.dart';
import '../screens/profil_Screen.dart';

class BottomNavigationBarMenu extends StatelessWidget {
Color colorCounterColor=Colors.green;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(1),
          topRight: Radius.circular(1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                  ((route) => false));
            },
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AddQuestionPage()),
                  ((route) => false));
            },
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),

          IconButton(
            enableFeedback: false,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilPage()),
                  ((route) => false));
            },
            icon: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
