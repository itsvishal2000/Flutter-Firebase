import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

Future<FirebaseUser> _register() async {
  final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
    email: email.text,
    password: password.text,
  ))
      .user;
  if (user != null) {
    user.sendEmailVerification().whenComplete(() {
      debugPrint('Email Verification Sent');
    });
  }
  return user;
}

class _SignUpState extends State<SignUp> {
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
            ArgonButton(
              height: 50,
              width: 350,
              borderRadius: 5.0,
              color: Color(0xFF7866FE),
              child: Text(
                "SignUp",
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
                _register().then((FirebaseUser user) {}).catchError((e) {
                  e.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
