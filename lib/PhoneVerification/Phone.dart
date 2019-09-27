import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sinup/Home/Home.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

TextEditingController phone = TextEditingController();
TextEditingController sms = TextEditingController();
GlobalKey<FormState> _formkey = GlobalKey<FormState>();
FirebaseAuth _auth = FirebaseAuth.instance;
String message;
String _verificationId;

class _PhoneState extends State<Phone> {
  var index = 0;

  Widget verifyNumberButton() {
    return ArgonButton(
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
      onTap: (startLoading, stopLoading, btnState) async {
        verifyPhoneNumber();
      },
    );
  }

  Widget verifyButton() {
    return ArgonButton(
      height: 50,
      width: 350,
      borderRadius: 5.0,
      color: Colors.green,
      child: Text(
        "Verify",
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
      onTap: (startLoading, stopLoading, btnState) async {
        _signInWithPhoneNumber().then((FirebaseUser user) {}).catchError((e) {
          debugPrint(e.toString());
        });
      },
    );
  }

  Widget resendButton() {
    return ArgonButton(
      height: 50,
      width: 150,
      borderRadius: 5.0,
      color: Colors.purple,
      child: Text(
        "Resend",
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
      onTap: (startLoading, stopLoading, btnState) async {
        verifyPhoneNumber();
      },
    );
  }

  Widget smsTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            maxLength: 6,
            buildCounter: (BuildContext context,
                    {int currentLength, int maxLength, bool isFocused}) =>
                null,
            controller: sms,
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val.isEmpty || val.length < 6 || val.length > 6) {
                return 'Not a valid OTP.';
              }
              return null;
            },
            cursorColor: Colors.black,
            autocorrect: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                EvaIcons.phoneCall,
                color: Colors.black,
              ),
              hintText: 'Enter Otp',
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            maxLength: 10,
            buildCounter: (BuildContext context,
                    {int currentLength, int maxLength, bool isFocused}) =>
                null,
            controller: phone,
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val.isEmpty || val.length < 10) {
                return 'Not a valid Phone Number.';
              }
              return null;
            },
            cursorColor: Colors.black,
            autocorrect: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                EvaIcons.phone,
                color: Colors.black,
              ),
              hintText: 'Phone NUmber',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: IndexedStack(
                  index: index,
                  children: <Widget>[phoneTextField(), smsTextField()],
                ),
              ),
              Container(
                height: 50,
                child: IndexedStack(
                  index: index,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    resendButton()
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                child: IndexedStack(
                  index: index,
                  children: <Widget>[verifyNumberButton(), verifyButton()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyPhoneNumber() async {
    print('Verifying...');
    final PhoneVerificationCompleted verificationCompleted = (user) {};

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print("Error: " + authException.code + " : " + authException.message);
      debugPrint('Check your Internet Connection');
    };

    final PhoneCodeSent codeSent =
        (String verId, [int forceResendingToken]) async {
      _verificationId = verId;
      setState(() {
        index = 1;
      });
      debugPrint('Otp Sent Sucessfully');
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verId) {
      _verificationId = verId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: "+91" + phone.text,
        timeout: const Duration(seconds: 30),
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        verificationCompleted: verificationCompleted,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Example code of how to sign in with phone.
  Future<FirebaseUser> _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: sms.text,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        debugPrint('Successfully signed in, uid: ' + user.uid);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user.uid)));
      } else {
        debugPrint('Sign in failed');
      }
    });
    return user;
  }
}
