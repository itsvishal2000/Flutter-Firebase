import 'package:flutter/material.dart';
import 'package:sinup/GoogleLogin/GoogleLogin.dart';
import 'package:sinup/PhoneVerification/Phone.dart';
import 'package:sinup/SignIn/SignIn.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'SignUp/SignUp.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ArgonButton(
          height: 50,
          width: 350,
          borderRadius: 5.0,
          color: Color(0xFF7866FE),
          child: Text(
            "SignUp",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          loader: Container(
            padding: EdgeInsets.all(10),
            child: SpinKitRotatingCircle(
              color: Colors.white,
              // size: loaderWidth ,
            ),
          ),
          onTap: (startLoading, stopLoading, btnState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        ArgonButton(
          height: 50,
          width: 350,
          borderRadius: 5.0,
          color: Colors.brown,
          child: Text(
            "SignIn",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          loader: Container(
            padding: EdgeInsets.all(10),
            child: SpinKitRotatingCircle(
              color: Colors.white,
              // size: loaderWidth ,
            ),
          ),
          onTap: (startLoading, stopLoading, btnState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignIn()));
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        ArgonButton(
          height: 50,
          width: 350,
          borderRadius: 5.0,
          color: Colors.red,
          child: Text(
            "SignIn with Google",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          loader: Container(
            padding: EdgeInsets.all(10),
            child: SpinKitRotatingCircle(
              color: Colors.white,
              // size: loaderWidth ,
            ),
          ),
          onTap: (startLoading, stopLoading, btnState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GoogleLogin()));
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        ArgonButton(
          height: 50,
          width: 350,
          borderRadius: 5.0,
          color: Colors.green,
          child: Text(
            "Phone Verification",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          loader: Container(
            padding: EdgeInsets.all(10),
            child: SpinKitRotatingCircle(
              color: Colors.white,
              // size: loaderWidth ,
            ),
          ),
          onTap: (startLoading, stopLoading, btnState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Phone()));
          },
        ),
      ],
    ));
  }
}
