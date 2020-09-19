import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'logInpage.dart';

FirebaseAuth  auth=FirebaseAuth.instance;
GoogleSignIn googleSignIn=GoogleSignIn();

class DashBoard extends StatefulWidget {

final User users; 
 const DashBoard({
    Key key,
   this.users,
  }) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  Future<void>signout()async{
  await auth.signOut().then((value) {
    googleSignIn.signOut();
    
  });
  
  Navigator.pushReplacement(context, 
  MaterialPageRoute(builder: (context) => LogInPage())
  );
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: SafeArea(
            child: Scaffold(
              body: Center(
            child: Column(
                        children: [
                          Text('log in successfull'),
                          CircleAvatar(
                            backgroundImage:NetworkImage(widget.users.photoURL) ,
                            backgroundColor: Colors.yellowAccent,
                            radius: 50.0,
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Text(widget.users.displayName),
                          SizedBox(
                            height: 50.0,
                          ),
                          Text(widget.users.email),
                          SizedBox(
                            height: 50.0,
                          ),
                           FlatButton(
                            onPressed: (){
                               signout();
                             },
                            child: Text('Sign Out'),
                          ),
                       ],
                     ),
          ),
        ),
      ),
    );
  }
}




                          
                         