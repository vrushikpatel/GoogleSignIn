import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _init=false;
  void intializeFirebase()async{
    await Firebase.initializeApp();
    _init=true;
  }
  @override
  void initState() {
    intializeFirebase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: (){

          if(_init){
            print('button pressed and firebase initialized');
          }
          else
            print('button pressed');
        },
        splashColor: Colors.blueAccent,
        child: Text('Sign In with google'),
      ),
    );
  }
}