import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizzler/screens/welcome_screen.dart';

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({super.key});

  static const String screenRoute = 'main_chat_screen';

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(
          Icons.play_arrow_rounded,
        ),
      ),
      appBar: AppBar(
        title: const Text("Chat Page"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context, WelcomeScreen.screenRoute);
            },
            icon: Icon(
              Icons.logout_rounded,
            ),
          )
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "المجموعات",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, chatScreen.screenRoute);
              },
              leading: CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.groups_rounded,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              title: Text(
                "المجموعة",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Hi : s@s.com",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "الدردشات الفردية",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('users')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  );
                }
                return Column(
                  children: snapshot.data!.docs
                      .map(
                        (e) => ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            radius: 30,
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                          title: Text(
                            e['name'],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "s@s.com",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
