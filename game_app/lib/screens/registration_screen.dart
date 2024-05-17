import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/screens/chat_screen.dart';
import 'package:quizzler/screens/main_chat_screen.dart';
import 'package:quizzler/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Registrationscreen extends StatefulWidget {
  static const String screenRoute = 'registration_screen';

  const Registrationscreen({Key? key}) : super(key: key);
  @override
  State<Registrationscreen> createState() => _RegistrationscreenState();
}

class _RegistrationscreenState extends State<Registrationscreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  late String name;
  late String email;
  late String password;

  bool show = false;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var blue = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: show,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
                child: Image.asset('images/lop.webp'),
              ),
              SizedBox(height: 50),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your Emal',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              MyButton(
                color: Colors.blue[800]!,
                title: 'register',
                onPressed: () async {
                  setState(
                    () {
                      show = true;
                    },
                  );

                  try {
                    // ignore: unused_local_variable
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    await _firestore.collection('users').doc().set({
                      'name': name,
                      'email': email,
                    });

                    Navigator.pushNamed(context, MainChatScreen.screenRoute);
                    setState(() {
                      show = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
