
// Home page screen


import 'package:chatbox/viewprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chatbox/exitpopup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'chatpage.dart';

import 'loginpage.dart';
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          actions: [
            IconButton(onPressed: () {
Navigator.push(context, MaterialPageRoute(
builder: (context) {
return ViewProfile();
},
));
            }, icon:const Icon(Icons.more_vert),),
            IconButton(onPressed: () {
signOut();
            }, icon:const Icon(Icons.logout),)
          ],
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:Color(0xff113162),),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor:Color(0xff113162) ,
          title: Text("CHATTER",style: TextStyle(fontSize: 20)),centerTitle: true,),
      body: WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').where("senderemail",isNotEqualTo: auth.currentUser?.email,  ).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(

              children: snapshot.data!.docs.map((document) {
                return Container(
                  child: Column(
                    children: [

                      Container(
                        color: Colors.white,
                        child: ListTile(
                         title: Row(
                           children: [
                             SizedBox(
                               width: 15,
                               height: 20,
                             ),
                             document['image'] == null || document['image'].isEmpty
                                 ? Center(
                               child: ClipOval(
                                 child: Container(
                                   height: 60,
                                   width: 60,
                                   child: FittedBox(
                                     fit: BoxFit.fill,
                                   ),
                                 ),
                               ),
                             )
                                 : Center(
                               child: ClipOval(
                                 child: Container(
                                   height: 60,
                                   width: 60,
                                   child: FittedBox(
                                     child:
                                     Image.network('${document['image']}'),
                                     fit: BoxFit.fitWidth,
                                   ),
                                 ),
                               ),
                             ),
                             SizedBox(
                               width: 15,
                             ),
                             Column(
                               mainAxisAlignment:
                               MainAxisAlignment.start,
                               crossAxisAlignment:
                               CrossAxisAlignment.start,
                               children: [

                                 Center(child: Text(document['name'].toString())),
                                 Center(child: Text(document['senderemail'].toString(),)),

                               ],
                             )
                           ],
                         ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => chatpage(senderemail: auth.currentUser?.email,
                                  image:document['image'] ,name:document['name'] ,
                                  receiveremail: document['senderemail'],)));
                          },
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black38,
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  //signout function
  signOut() async {

    print("SIGNOUT FUNCTION IS CALLED-----------");
    print("Below Mention User Logout-");
    print(auth.currentUser!.displayName);

    Fluttertoast.showToast(
      msg: "${auth.currentUser?.displayName} is successfully logout", // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.CENTER, // location
      timeInSecForIosWeb: 1, // duration
    );
    await auth.signOut();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

}
