import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/bottomNavigationBar.dart';
import 'login_Screen.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late Query usersStream = FirebaseFirestore.instance
      .collection('Questions')
      .where("kullaniciID", isEqualTo: auth.currentUser!.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarMenu(),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'My Questions',
            style: TextStyle(fontFamily: 'MobilRegular', fontSize: 30),
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: usersStream.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                return ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Card(
                          child: ListTile(
                            title: Text(data['baslik']),
                            subtitle: Text(data['icerik']),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Text(
                                            data['baslik'],
                                            style: TextStyle(
                                                fontFamily: 'MobilRegular',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              'Are you sure you want to delete?'),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed: () {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfilPage(),
                                                    ),
                                                    ((route) => false));
                                                FirebaseFirestore.instance
                                                    .collection('Questions')
                                                    .doc(data['baslik'])
                                                    .delete();

                                                ;
                                              },
                                              child: Text('Delete')),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      })
                      .toList()
                      .cast(),
                );
              },
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                      ((route) => false));
                });
              },
              child: Text('Log out'))
        ],
      ),
    );
  }
}
