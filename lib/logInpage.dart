import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Dashbord.dart';

FirebaseAuth  auth=FirebaseAuth.instance;
GoogleSignIn googleSignIn=GoogleSignIn();
User users;

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

Future<void> signinhandle()async{
 GoogleSignInAccount googlesigninaccount= await googleSignIn.signIn(); 
 GoogleSignInAuthentication googleSignInAuthentication=await googlesigninaccount.authentication;

 final GoogleAuthCredential credential = GoogleAuthProvider.credential( idToken: googleSignInAuthentication.idToken , accessToken: googleSignInAuthentication.accessToken);

 final userCred =  await auth.signInWithCredential(credential);
 users = userCred.user;
 
    Navigator.pushReplacement(context, 
  MaterialPageRoute(builder: (context) => DashBoard(users: users))
  );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: SafeArea(
              child: Scaffold(
              body: Center(
                child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Center(
                          child: FlatButton(
                              onPressed: (){ 
                                print('sign in pressed');
                                  signinhandle();
                              },
                              child: Text('Click Here to Sign In'),
                          ),
                      ),
                    ),
        ),
      ),
          ),
    );
  }
}