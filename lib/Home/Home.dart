import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final email;
  Home(this.email);
  @override
  _HomeState createState() => _HomeState(email);
}

class _HomeState extends State<Home> {
  final email;
  _HomeState(this.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Center(child: Text(email))],
        ),
      ),
    );
  }
}
