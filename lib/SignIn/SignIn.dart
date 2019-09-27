import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sinup/Home/Home.dart';
import 'package:sinup/Reset/Reset.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;
Future<FirebaseUser> _signInWithEmailAndPassword(_) async {
  final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
    email: email.text,
    password: password.text,
  ))
      .user;
  if (user != null) {
    //To Check if User Email Is Verified
    //You can create contiditions if email is not verified and all

    if (user.isEmailVerified)
      Navigator.push(
          _, MaterialPageRoute(builder: (context) => Home(user.email)));
    else
      debugPrint(user.isEmailVerified.toString().toUpperCase() +
          ' Email Not Verified');
  } else {
    debugPrint('User Not Found');
  }
  return user;
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val.isEmpty ||
                          !val.contains('@') ||
                          !val.contains('.com')) {
                        return 'Not a valid Email.';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    autocorrect: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        EvaIcons.email,
                        color: Colors.black,
                      ),
                      hintText: 'Email',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    maxLength: 12,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter Password To Continue';
                      }
                      return null;
                    },
                    buildCounter: (BuildContext context,
                            {int currentLength,
                            int maxLength,
                            bool isFocused}) =>
                        null,
                    controller: password,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        EvaIcons.lock,
                        color: Colors.black,
                      ),
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Reset()));
                    },
                    child: Text(
                      'Reset Password ?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ArgonButton(
              height: 50,
              width: 350,
              borderRadius: 5.0,
              color: Color(0xFF7866FE),
              child: Text(
                "SignIn",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              loader: Container(
                padding: EdgeInsets.all(10),
                child: SpinKitRotatingCircle(
                  color: Colors.white,
                  // size: loaderWidth ,
                ),
              ),
              onTap: (startLoading, stopLoading, btnState) {
                _signInWithEmailAndPassword(context)
                    .then((FirebaseUser user) {})
                    .catchError((e) {
                  debugPrint(e.toString());
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
