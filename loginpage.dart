import 'package:chatbox/homepage.dart';
import 'package:chatbox/unused/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'exitpopup.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// creating firebase instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
    return Scaffold(
      appBar: AppBar(

          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:Color(0xff113162),),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor:Color(0xff113162) ,
          title: Text("CHATTER"),centerTitle: true,),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: WillPopScope(
            onWillPop: () => showExitPopup(context),
            child: Builder(builder: (context) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Please Login",
                        style: TextStyle(

                          color: Color(
                            0xff113162,
                          ),
                          fontSize: 40,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        child: Image.asset('assets/images/google.png',),onTap: () {
                        signup();
                      },),

                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Made by",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Color(
                                    0xff113162,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "InstaItTechnology",
                                style: TextStyle(

                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Color(
                                    0xff113162,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              );
            }),
          ),
        ),
      ),
    );
  }

  signup() async {
    debugPrint("SIGNUP FUNCTION IS CALLED--------------------");
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(

          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      print("USER INFORMATION IS AS FOLLOWS--------------------");

      if (user!=null) {
        print(result.user?.displayName);


        // FirebaseFirestore.instance
        //     .collection('data').
        //     add({'name': '${auth.currentUser!.displayName}',"image":"${auth.currentUser!.photoURL}","email":"${auth.currentUser!.email}"})
        //     .then((value) => print("User Added"))
        //     .catchError((error) => print("Failed to add user: $error"));

        FirebaseFirestore.instance.collection('users').
        doc('${auth.currentUser!.email}')
            .set({'name': '${auth.currentUser!.displayName}',
          "image":"${auth.currentUser!.photoURL}",
          // "email":"${auth.currentUser!.email}",
          "senderemail":"${auth.currentUser?.email}",
          "messagetype":"Text",
          "time":"${DateTime.now().millisecondsSinceEpoch}",
            });

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        Fluttertoast.showToast(
          msg: "${auth.currentUser?.displayName} is successfully login", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER, // location
          timeInSecForIosWeb: 1, // duration
        );
      }else  if (user==null) {
        print(result.user?.displayName);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        Fluttertoast.showToast(
          msg: "Something Went Wrong!", // message
          toastLength: Toast.LENGTH_SHORT, // length
          gravity: ToastGravity.CENTER, // location
          timeInSecForIosWeb: 1, // duration
        );
      }
    }
  }
}
