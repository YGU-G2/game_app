import 'package:quizzler/screens/chat_screen.dart';
import 'package:quizzler/screens/main_chat_screen.dart';
import 'package:quizzler/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class signinscreens extends StatefulWidget {
  
  static const String screenRoute = 'signin_screens';

  const signinscreens({Key? key}):super(key: key)  ;

  @override
  State<signinscreens> createState() => _signinscreensState();
}

class _signinscreensState extends State<signinscreens> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  
  bool show = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: show,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Container(height: 180,
            child: Image.asset('images/lop.webp'),
            ),
      
            SizedBox(height: 50),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your Emal',
                contentPadding: EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10),
                  ),
                ),
      
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue,
                  width: 2 , ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ), 
      
                focusedBorder:  OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange,
                  width: 1 , ),
      
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
              
                MyButton(color: Colors.blue[800]!,
                  title: 'sign in',
                  onPressed: () async {
                    setState(() {
                      show = true;
                    });
                    try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    // ignore: unnecessary_null_comparison
                    if (user != null) {
                      Navigator.pushNamed(context, MainChatScreen.screenRoute);
                      setState(() {
                        show = false;
                      });
                    }
                    } catch (e) {
                      print(e);
                    }
                  },
                  ),
              
      
          ],),
        ),
      ),
    );
  }
}
  
