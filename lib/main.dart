import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 FirebaseAuth  auth=FirebaseAuth.instance;
 GoogleSignIn googleSignIn=GoogleSignIn();
 FirebaseUser users;
 bool isSign = false;
  
// sign in
Future<void> signinhandle()async{
 GoogleSignInAccount googlesigninaccount= await googleSignIn.signIn(); 
 GoogleSignInAuthentication googleSignInAuthentication=await googlesigninaccount.authentication;

 final AuthCredential authCredential=GoogleAuthProvider.getCredential(
   idToken: googleSignInAuthentication.idToken , accessToken: googleSignInAuthentication.accessToken);


   final UserCredential authResult = await auth.signInWithCredential(authCredential) ;
 

   users = authResult.user;

   setState(() {
     isSign=true;
   });
   
}

//sign out
Future<void>signout()async{

await auth.signOut().then((value) {
googleSignIn.signOut();
setState(() {
  isSign=false;
});
});
}

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blueAccent,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Google Sign In'),),
          ),
          body:Center(
             child:  isSign ? Column(
                children: [
                  CircleAvatar(
                    backgroundImage:NetworkImage(users.photoUrl) ,
                    radius: 50.0,
                  ),
                  Text(users.displayName),
                  Text(users.email),
                  FlatButton(
                    onPressed: (){
                      signout();
                    },
                    child: Text('Sign Out'),
                     ),
               ],
             ) 
             : 
             Container(
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