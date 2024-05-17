
// ignore_for_file: unused_import

import 'package:quizzler/screens/chat_screen.dart';
import 'package:quizzler/screens/registration_screen.dart';
import 'package:quizzler/screens/signin_screens.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget{
  static const  String screenRoute = 'welcome_screens';
  const WelcomeScreen({Key? key}):super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();

}
class _WelcomeScreenState extends State<WelcomeScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 239, 239),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
      
          children: [
          Column(children: [
            Container(
              child: Image.asset('images/lop.webp'),
            ),
            Text('MessageMe',
            style: TextStyle(fontSize: 40 , fontWeight: FontWeight.w900 , color: Color(0xff2e386b),),
            ),
          ],
          ),
          SizedBox(height: 30),
          MyButton(
            color: Colors.yellow[900]!,
            title: 'sign in',
            onPressed: () {
              Navigator.pushNamed(context, signinscreens.screenRoute);
            },
          ),
          MyButton(
            color: Colors.blue[800]!,
            title: 'register',
            onPressed: () {
              Navigator.pushNamed(context,Registrationscreen.screenRoute);
            },
            )
        ],
        ),
      ),
    );
  }
}



