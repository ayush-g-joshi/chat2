// import 'dart:async';
//
// import 'package:chatbox/homepage.dart';
// import 'package:chatbox/loginpage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'login.dart';
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   void initState() {
//     splashScreen();
//     super.initState();
//   }
//
//   splashScreen() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var status = prefs.getBool('isLoggedIn') ?? false;
//     print(status);
//
//     Timer(
//         Duration(seconds: 3),
//             () => Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>const LoginPage())));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
//     return Scaffold(
//       backgroundColor: Color(0xff113162),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "CHATTER",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Be Connected With Your World !",
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               CircularProgressIndicator(
//                 color: Colors.white,
//                 strokeWidth: 5,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:chatbox/homepage.dart';
import 'package:chatbox/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    splashScreen();
    super.initState();
  }

  splashScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);

    Timer(
        Duration(seconds: 3),
            () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>const LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Color(0xff113162),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "CHATTER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Be Connected With Your World !",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

