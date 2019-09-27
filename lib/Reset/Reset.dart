import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Reset extends StatefulWidget {
  @override
  _ResetState createState() => _ResetState();
}

final email = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final FirebaseAuth _auth = FirebaseAuth.instance;

class _ResetState extends State<Reset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
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
              ArgonButton(
                height: 50,
                width: 350,
                borderRadius: 5.0,
                color: Color(0xFF7866FE),
                child: Text(
                  "Reset Password",
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
                  if (_formKey.currentState.validate()) {
                    _auth
                        .sendPasswordResetEmail(email: email.text)
                        .whenComplete(() {
                      debugPrint('Reset Link Sent');
                    }).catchError((e) {
                      debugPrint(e.toString());
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
