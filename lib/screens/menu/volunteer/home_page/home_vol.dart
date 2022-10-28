import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wol_pro_1/screens/intro_screen/option.dart';
import 'package:wol_pro_1/screens/register_login/volunteer/register/categories_choose.dart';

import '../../../../constants.dart';
import '../../../../service/local_push_notifications.dart';
import 'settings/settings_vol_info.dart';
import '../all_applications/new_screen_with_applications.dart';


List categoriesVolunteer = [];
// String? currentId_set = '';
String? currentNameVol = '';
List categoriesUserRegister = [];
String? token_vol;
// final FirebaseFirestore _db = FirebaseFirestore.instance;
// final FirebaseMessaging _fcm = FirebaseMessaging.instance;

class HomeVol extends StatefulWidget {
  const HomeVol({Key? key}) : super(key: key);

  @override
  State<HomeVol> createState() => _HomeVolState();
}

class _HomeVolState extends State<HomeVol> {
  // final Stream<int> _bids = (() {
  //   late final StreamController<int> controller;
  //   controller = StreamController<int>(
  //     onListen: () async {
  //       await Future<void>.delayed(const Duration(seconds: 1));
  //       controller.add(1);
  //       await Future<void>.delayed(const Duration(seconds: 1));
  //       await controller.close();
  //     },
  //   );
  //   return controller.stream;
  // })();
  /// Get the token, save it to the database for current user
  // _saveDeviceToken() async {
  //   // Get the current user
  //   // String uid = FirebaseAuth.instance.currentUser!.uid;
  //   // FirebaseUser user = await _auth.currentUser();
  //
  //   // Get the token for this device
  //   String? fcmToken = await _fcm.getToken();
  //
  //   // // Save it to Firestore
  //   // if (fcmToken != null) {
  //   //   var tokens = _db
  //   //       .collection('users')
  //   //       .doc(uid)
  //   //       .collection('tokens')
  //   //       .doc(fcmToken);
  //   //
  //   //   await tokens.set({
  //   //     'token': fcmToken,
  //   //     'createdAt': FieldValue.serverTimestamp(), // optional
  //   //
  //   //   });
  //   // }
  // }

  // String token = '';
  //
  storeNotificationToken() async {
    String? token_v = await FirebaseMessaging.instance.getToken();
    print(
        "------???---------RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    print(token_v);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token_vol': token_v}, SetOptions(merge: true));
    print(
        "RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    print(token_v);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {});
    storeNotificationToken();
    FirebaseMessaging.instance.subscribeToTopic('subscription');
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
  }

  // final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OptionChoose()),
        );
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: background,
          // appBar: AppBar(
          //   title: Padding(
          //     padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.1),
          //     child: Text(
          //       "Volunteer",
          //       style: GoogleFonts.sairaStencilOne(
          //         fontSize: 25,
          //         color: Colors.black.withOpacity(0.7),
          //
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          //   elevation: 0,
          //   backgroundColor: Colors.transparent,
          //   leading: IconButton(
          //       onPressed: (){
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => const OptionChoose()),
          //         );
          //       },
          //       icon: Icon(Icons.arrow_back_ios_new_rounded, color: blueColor,)),
          // ),
          // appBar: AppBar(
          //   backgroundColor: Color.fromRGBO(49, 72, 103, 0.8),
          //   elevation: 0.0,
          //   title: Text('Users Info',style: TextStyle(fontSize: 16),),
          //   leading: IconButton(onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => OptionChoose()),
          //     );
          //   }, icon: Icon(Icons.arrow_back),
          //
          //   ),
          //
          //   actions: <Widget>[
          //
          // IconButton(
          //     icon: const Icon(Icons.settings,color: Colors.white,),
          //     //label: const Text('logout',style: TextStyle(color: Colors.white),),
          //     onPressed: () async {
          //       //await _auth.signOut();
          //       // chosen_category_settings = [];
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => SettingsVol()),
          //       );
          //     },
          //   ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: TextButton.icon(
          //         icon: const Icon(Icons.person,color: Colors.white,),
          //         label: const Text('Logout',style: TextStyle(color: Colors.white),),
          //         onPressed: () async {
          //           await _auth.signOut();
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => OptionChoose()),
          //           );
          //         },
          //       ),
          //     ),
          //     /**TextButton.icon(
          //         onPressed: (){
          //         showSettingsPanel();
          //         },
          //         label: Text("Settings",style: TextStyle(color: Colors.white),),
          //         icon: Icon(Icons.settings,color: Colors.white,),)**/
          //   ],
          // ),
          body: Stack(
            children: [

              // IconButton(
              //   icon: const Icon(Icons.edit, color: Colors.white,),
              //   onPressed: (){
              //     print("K");
              //   },),
              // StreamBuilder(
              //   stream: FirebaseFirestore.instance
              //       .collection('users')
              //       .where('id_vol', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              //       .snapshots(),
              //
              //   builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              //     return ListView.builder(
              //         itemCount: !streamSnapshot.hasData? 1: streamSnapshot.data?.docs.length,
              //         itemBuilder: (ctx, index) {
              //           token_vol = streamSnapshot.data?.docs[index]['token_vol'];
              //           current_name_Vol = streamSnapshot.data?.docs[index]['user_name'];
              //           if (streamSnapshot.hasData){
              //           switch (streamSnapshot.connectionState){
              //             case ConnectionState.waiting:
              //               return  Column(
              //                 children: [
              //                   const SizedBox(
              //                     width: 60,
              //                     height: 60,
              //                     child: CircularProgressIndicator(),
              //                   ),
              //                   const Padding(
              //                     padding: EdgeInsets.only(top: 16),
              //                     child: Text('Awaiting data...'),
              //                   )
              //                 ]
              //
              //               );
              //
              //             case ConnectionState.active:
              //           return Padding(
              //             padding: const EdgeInsets.only(top: 120),
              //             child: Column(
              //                 children: [
              //
              //                   // Padding(
              //                   //   padding: const EdgeInsets.only(left: 15),
              //                   //   child: Align(
              //                   //     alignment: Alignment.topLeft,
              //                   //     child: Text(
              //                   //       streamSnapshot.data?.docs[index]['user_name'] ,
              //                   //       style: TextStyle(
              //                   //         fontWeight: FontWeight.bold,fontSize: 24,color: Colors.black,)
              //                   //     ),
              //                   //   ),
              //                   // ),
              //                   //
              //                   // Padding(
              //                   //   padding: const EdgeInsets.only(top: 15),
              //                   //   child: Row(
              //                   //     children: [
              //                   //       IconButton(onPressed: () {
              //                   //         print("Phone");
              //                   //       }, icon: Icon(Icons.phone)),
              //                   //       Align(
              //                   //         alignment: Alignment.topLeft,
              //                   //         child: Text(
              //                   //           streamSnapshot.data?.docs[index]['phone_number'],
              //                   //           style: TextStyle(color: Colors.grey[700],fontSize: 16),textAlign: TextAlign.left,),
              //                   //       ),
              //                   //     ],
              //                   //   ),
              //                   // ),
              //
              //
              //
              //                   // Text(
              //                   //   streamSnapshot.data?.docs[index]['date'],
              //                   //   style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,),
              //
              //                   const SizedBox(height: 250,),
              //                   Padding(
              //                     padding: const EdgeInsets.only(top: 40),
              //                     child: Center(
              //                       child: Container(
              //                         width: 300,
              //                         height: 50,
              //                         decoration: BoxDecoration(
              //                             borderRadius: BorderRadius.circular(20)
              //                         ),
              //                         child: MaterialButton(
              //                           color: const Color.fromRGBO(137, 102, 120, 0.8),
              //                           child: const Text('All applications', style: (TextStyle(color: Colors.white, fontSize: 15)),),
              //                           onPressed: () {
              //
              //                             categories_user_Register = streamSnapshot.data?.docs[index]['category'];
              //                             print("OOOOOOOOOOOOOOOO___________________TTTTTTTTTTTTTTTTTTTt");
              //                             print(categories_user_Register);
              //                             currentId_set = streamSnapshot.data?.docs[index].id;
              //                             current_name_Vol = streamSnapshot.data?.docs[index]['user_name'];
              //                             Navigator.push(context, MaterialPageRoute(builder: (context) => const Categories()));
              //                           },
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //
              //                   Padding(
              //                     padding: const EdgeInsets.only(top: 10),
              //                     child: Center(
              //                       child: Container(
              //                         width: 300,
              //                         height: 50,
              //                         decoration: BoxDecoration(
              //                             borderRadius: BorderRadius.circular(20)
              //                         ),
              //                         child: MaterialButton(
              //                           color: const Color.fromRGBO(137, 102, 120, 0.8),
              //                           child: const Text('My applications', style: (TextStyle(color: Colors.white, fontSize: 15)),),
              //                           onPressed: () {
              //
              //                             currentId_set = streamSnapshot.data?.docs[index].id;
              //                             current_name_Vol = streamSnapshot.data?.docs[index]['user_name'];
              //                             Navigator.push(context, MaterialPageRoute(builder: (context) => const ApplicationsOfVolunteer()));
              //                           },
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //
              //                   Padding(
              //                     padding: const EdgeInsets.only(top: 10),
              //                     child: Center(
              //                       child: Container(
              //                         width: 300,
              //                         height: 50,
              //                         decoration: BoxDecoration(
              //                             borderRadius: BorderRadius.circular(20)
              //                         ),
              //                         child: MaterialButton(
              //                           color: const Color.fromRGBO(137, 102, 120, 0.8),
              //                           child: const Text('Messages', style: (TextStyle(color: Colors.white, fontSize: 15)),),
              //                           onPressed: () {
              //                             Navigator.push(
              //                                     context,
              //                                     MaterialPageRoute(
              //                                         builder: (context) =>
              //                                             const ListofChatroomsVol()),
              //                                   );
              //                             // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage_3()));
              //                             // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(name: current_name,)));
              //                             // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(name: current_name)));
              //                             // Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(chatRoomId: '',)));
              //                           },
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //           );}}
              //           else{
              //
              //           }
              //           return Center(
              //             child: Padding(padding: const EdgeInsets.only(top: 100),
              //               child: Column(
              //                 children: [
              //                   const SpinKitChasingDots(
              //                     color: Colors.brown,
              //                     size: 50.0,
              //                   ),
              //                   const Align(
              //                     alignment: Alignment.center,
              //                     child: Text(
              //                         "Waiting...",
              //                         style: TextStyle(
              //                           fontWeight: FontWeight.bold,fontSize: 24,color: Colors.black,)
              //                     ),
              //                   ),
              //               const Padding(padding: EdgeInsets.only(top: 20),)
              //                 ],
              //               ),
              //             ),
              //           );
              //         });
              //   },
              // ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.55),
                child: Padding(
                  padding: padding,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('id_vol',
                              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (streamSnapshot.connectionState ==
                            ConnectionState.done) {
                          return Text('done');
                        } else if (streamSnapshot.hasError) {
                          return Text('Error!');
                        } else {
                          categoriesVolunteer
                              .add(streamSnapshot.data?.docs[0]["category"]);
                          print("UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU");
                          print(categoriesVolunteer[0][0]);
                          return ListView.builder(
                              itemCount: categoriesVolunteer[0].length,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.012),
                                  child: Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.075,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                        borderRadius: BorderRadius.circular(24)
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                          ),
                                          child: Icon(
                                            categoriesVolunteer[0][index]==categories_list_all[3]
                                                ?Icons.pets_rounded
                                                :categoriesVolunteer[0][index]==categories_list_all[4]
                                                ?Icons.local_grocery_store
                                                :categoriesVolunteer[0][index]==categories_list_all[2]
                                                ?Icons.emoji_transportation_rounded
                                                :categoriesVolunteer[0][index]==categories_list_all[1]
                                                ?Icons.house
                                                :categoriesVolunteer[0][index]==categories_list_all[6]
                                                ?Icons.sign_language_rounded
                                                :categoriesVolunteer[0][index]==categories_list_all[5]
                                                ?Icons.child_care_outlined
                                                :categoriesVolunteer[0][index]==categories_list_all[7]
                                                ?Icons.menu_book
                                                :categoriesVolunteer[0][index]==categories_list_all[8]
                                                ?Icons.medical_information_outlined
                                                :categoriesVolunteer[0][index]==categories_list_all[0]
                                                ?Icons.check_box
                                                :Icons.new_label_sharp,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          categoriesVolunteer[0][index],
                                          // streamSnapshot.data?.docs[index]
                                          //     ["category"][index],
                                          style: GoogleFonts.raleway(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height:
                                        //   MediaQuery.of(context).size.height *
                                        //       0.05,
                                        // ),
                                      ],
                                    ),
                                  ),
                                );
                                // }
                                // );
                                // return CircularProgressIndicator();
                              });
                        }
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                top: MediaQuery.of(context)
                    .size
                    .height *
                    0.68,),
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton.icon(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseCategory()));
                    },
                    icon: Icon(Icons.add, color: Colors.black, size: 30,),
                    label: Text("Add new preferences",
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    ),
                  ),
                ),

              ),
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: blueColor,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.53,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where('id_vol',
                              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                                itemCount: !streamSnapshot.hasData
                                    ? 1
                                    : streamSnapshot.data?.docs.length,
                                itemBuilder: (ctx, index) {
                                  token_vol =
                                  streamSnapshot.data?.docs[index]['token_vol'];
                                  currentNameVol =
                                  streamSnapshot.data?.docs[index]['user_name'];
                                  if (streamSnapshot.hasData) {
                                    switch (streamSnapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Column(
                                            children: const [
                                          SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: CircularProgressIndicator(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16),
                                            child: Text('Awaiting data...'),
                                          )
                                        ]);
                                      case ConnectionState.active:
                                        categoriesVolunteer.add(streamSnapshot
                                            .data?.docs[index]['category']);
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 20),
                                          child: Column(
                                            children: [
                                              Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.4,
                                                  child: const Image(
                                                    image: AssetImage(
                                                        "assets/user.png"),
                                                  )),
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        streamSnapshot
                                                            .data?.docs[index]
                                                        ['user_name'],
                                                        style: GoogleFonts.raleway(
                                                          fontSize: 24,
                                                          color: Colors.white,
                                                        )),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsVol()));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.02),
                                                child: Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Text(
                                                      "${streamSnapshot.data?.docs[index]['age'] == 0 ? "Please add your age" : streamSnapshot.data?.docs[index]['age']}",
                                                      style: GoogleFonts.raleway(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.02),
                                                child: Align(
                                                  alignment: Alignment.topCenter,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      streamSnapshot.data
                                                          ?.docs[index]
                                                      ['ranking'] >=
                                                          1
                                                          ? Icon(
                                                        Icons.star,
                                                        color: Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      )
                                                          : streamSnapshot.data
                                                          ?.docs[
                                                      index]
                                                      ['ranking'] ==
                                                          0.5
                                                          ? Icon(
                                                        Icons.star_half,
                                                        color:
                                                        Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      )
                                                          : Icon(
                                                        Icons.star_border,
                                                        color:
                                                        Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      ),
                                                      streamSnapshot.data
                                                          ?.docs[index]
                                                      ['ranking'] >=
                                                          2
                                                          ? Icon(
                                                        Icons.star_rate,
                                                        color: Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      )
                                                          : streamSnapshot.data
                                                          ?.docs[
                                                      index]
                                                      ['ranking'] ==
                                                          1.5
                                                          ? Icon(
                                                        Icons.star_half,
                                                        color:
                                                        Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      )
                                                          : Icon(
                                                        Icons.star_border,
                                                        color:
                                                        Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      ),
                                                      streamSnapshot.data
                                                          ?.docs[index]
                                                      ['ranking'] >=
                                                          3
                                                          ? Icon(
                                                        Icons.star_rate,
                                                        color: Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      )
                                                          : streamSnapshot.data
                                                          ?.docs[
                                                      index]
                                                      ['ranking'] ==
                                                          2.5
                                                          ? Icon(
                                                        Icons.star_half,
                                                        color:
                                                        Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      )
                                                          : Icon(
                                                        Icons.star_border,
                                                        color:
                                                        Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      ),
                                                      streamSnapshot.data
                                                          ?.docs[index]
                                                      ['ranking'] >=
                                                          4
                                                          ? Icon(
                                                        Icons.star_rate,
                                                        color: Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      )
                                                          : streamSnapshot.data
                                                          ?.docs[
                                                      index]
                                                      ['ranking'] ==
                                                          3.5
                                                          ? Icon(
                                                        Icons.star_half,
                                                        color:
                                                        Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      )
                                                          : Icon(
                                                        Icons.star_border,
                                                        color:
                                                        Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      ),
                                                      streamSnapshot.data
                                                          ?.docs[index]
                                                      ['ranking'] >=
                                                          5
                                                          ? Icon(
                                                        Icons.star_rate,
                                                        color: Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      )
                                                          : streamSnapshot.data
                                                          ?.docs[
                                                      index]
                                                      ['ranking'] ==
                                                          4.5
                                                          ? Icon(
                                                        Icons.star_half,
                                                        color:
                                                        Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      )
                                                          : Icon(
                                                        Icons.star_border,
                                                        color:
                                                        Colors.white,
                                                        size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.06,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Padding(
                                              //   padding: const EdgeInsets.only(top: 15),
                                              //   child: Row(
                                              //     children: [
                                              //       IconButton(onPressed: () {
                                              //         print("Phone");
                                              //       }, icon: Icon(Icons.phone)),
                                              //       Align(
                                              //         alignment: Alignment.topLeft,
                                              //         child: Text(
                                              //           streamSnapshot.data?.docs[index]['phone_number'],
                                              //           style: TextStyle(color: Colors.grey[700],fontSize: 16),textAlign: TextAlign.left,),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),

                                              // Text(
                                              //   streamSnapshot.data?.docs[index]['date'],
                                              //   style: TextStyle(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,),

                                              const SizedBox(
                                                height: 250,
                                              ),
                                            ],
                                          ),
                                        );
                                    }
                                  } else {}
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 100),
                                      child: Column(
                                        children: const [
                                          SpinKitChasingDots(
                                            color: Colors.brown,
                                            size: 50.0,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text("Waiting...",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}