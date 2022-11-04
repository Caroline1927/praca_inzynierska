import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wol_pro_1/constants.dart';
import 'package:wol_pro_1/screens/intro_screen/option.dart';
import 'package:wol_pro_1/screens/menu/volunteer/home_page/settings/upload_photo.dart';
import 'package:wol_pro_1/widgets/datepicker.dart';
import '../../../../../../service/local_push_notifications.dart';

import '../../all_applications/new_screen_with_applications.dart';
import '../home_vol.dart';
import '../../../../register_login/volunteer/register/register_volunteer_1.dart';
import '../../../../../services/auth.dart';

var currentStreamSnapshot;
String dateOfBirth =
    DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();
String? tokenVol;
final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseMessaging fcm = FirebaseMessaging.instance;

class SettingsVol extends StatefulWidget {
  const SettingsVol({Key? key}) : super(key: key);

  @override
  State<SettingsVol> createState() => _SettingsVolState();
}

class _SettingsVolState extends State<SettingsVol> {
  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(
        "------???---------RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    print(token);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
    print(
        "RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    print(token);
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

  final AuthService _auth = AuthService();

  String changedName = '';
  int changedAge = 0;
  String changedPhone = '';
  List changedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 30,
          color: background,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeVol()));
        },
      ),
      // appBar: AppBar(
      //   backgroundColor: Color.fromRGBO(49, 72, 103, 0.8),
      //   elevation: 0.0,
      //   title: Text('Users Info',style: TextStyle(fontSize: 16),),
      //
      // ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.37,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('id_vol',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    itemBuilder: (ctx, index) {
                      // categories_user = streamSnapshot.data?.docs[index]['category'];
                      // token_vol = streamSnapshot.data?.docs[index]['token'];
                      // current_name_Vol = streamSnapshot.data?.docs[index]['user_name'];
                      return ClipPath(
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
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 50, top: 20),
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: GestureDetector(
                                    onTap: () {
                                      currentStreamSnapshot =
                                          streamSnapshot.data?.docs[index].id;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ImageUploads()));
                                    },
                                    child: url_image == null
                                        ? Image(
                                            image:
                                                AssetImage("assets/user.png"))
                                        : CircleAvatar(
                                            radius: 80.0,
                                            backgroundImage: NetworkImage(
                                                url_image.toString())),
                                  )),
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.45,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('id_vol',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    itemBuilder: (ctx, index) {
                      // categories_user = streamSnapshot.data?.docs[index]['category'];
                      // token_vol = streamSnapshot.data?.docs[index]['token'];
                      // current_name_Vol = streamSnapshot.data?.docs[index]['user_name'];
                      return SingleChildScrollView(
                        child: Padding(
                          padding: padding,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  child: Text(
                                    "Your name",
                                    style: GoogleFonts.raleway(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.075,
                                child: TextFormField(
                                  onChanged: (val) {
                                    changedName = val;
                                  },
                                  // controller: TextEditingController(text: streamSnapshot.data?.docs[index]['user_name']),
                                  decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorStyle:
                                    const TextStyle(color: Colors.red),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: BorderSide(
                                        color: blueColor,
                                        // color: Color.fromRGBO(2, 62, 99, 20),
                                        width: 1.5,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: streamSnapshot.data?.docs[index]
                                    ['user_name'],
                                    hintStyle: GoogleFonts.raleway(
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height:
                              //       MediaQuery.of(context).size.height * 0.012,
                              // ),
                              // Row(
                              //   children: [
                              //     SizedBox(
                              //       height: MediaQuery.of(context).size.height *
                              //           0.075,
                              //       width: MediaQuery.of(context).size.height *
                              //           0.13,
                              //       child: TextFormField(
                              //         onTap: (){
                              //           Navigator.push(
                              //             context,
                              //             MaterialPageRoute(builder: (context) => DatePicker()),
                              //           );
                              //         },
                              //         // controller: TextEditingController(text: "${streamSnapshot.data?.docs[index]['age']}"),
                              //         decoration: InputDecoration(
                              //           focusedErrorBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(24.0),
                              //             borderSide: const BorderSide(
                              //               color: Colors.red,
                              //               width: 1.5,
                              //             ),
                              //           ),
                              //           errorBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(24.0),
                              //             borderSide: const BorderSide(
                              //               color: Colors.red,
                              //               width: 1.5,
                              //             ),
                              //           ),
                              //           errorStyle: const TextStyle(
                              //               color: Colors.red
                              //           ),
                              //           focusedBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(24.0),
                              //             borderSide: BorderSide(
                              //               color: blueColor,
                              //               // color: Color.fromRGBO(2, 62, 99, 20),
                              //               width: 1.5,
                              //             ),
                              //           ),
                              //
                              //           enabledBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(24.0),
                              //             borderSide: const BorderSide(
                              //               color: Colors.white,
                              //               width: 0,
                              //             ),
                              //           ),
                              //           filled: true,
                              //           fillColor: Colors.white,
                              //           hintText: "${DateTime.now().day}",
                              //           labelStyle: GoogleFonts.raleway(
                              //             fontSize: 16,
                              //             color: Colors.black.withOpacity(0.7),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 5),
                              //       child: SizedBox(
                              //         width:MediaQuery.of(context).size.height *
                              //       0.13,
                              //         height: MediaQuery.of(context).size.height *
                              //             0.075,
                              //
                              //         child: TextFormField(
                              //           // controller: TextEditingController(text: "${streamSnapshot.data?.docs[index]['age']}"),
                              //           decoration: InputDecoration(
                              //             focusedErrorBorder: OutlineInputBorder(
                              //               borderRadius: BorderRadius.circular(24.0),
                              //               borderSide: const BorderSide(
                              //                 color: Colors.red,
                              //                 width: 1.5,
                              //               ),
                              //             ),
                              //             errorBorder: OutlineInputBorder(
                              //               borderRadius: BorderRadius.circular(24.0),
                              //               borderSide: const BorderSide(
                              //                 color: Colors.red,
                              //                 width: 1.5,
                              //               ),
                              //             ),
                              //             errorStyle: const TextStyle(
                              //                 color: Colors.red
                              //             ),
                              //             focusedBorder: OutlineInputBorder(
                              //               borderRadius: BorderRadius.circular(24.0),
                              //               borderSide: BorderSide(
                              //                 color: blueColor,
                              //                 // color: Color.fromRGBO(2, 62, 99, 20),
                              //                 width: 1.5,
                              //               ),
                              //             ),
                              //
                              //             enabledBorder: OutlineInputBorder(
                              //               borderRadius: BorderRadius.circular(24.0),
                              //               borderSide: const BorderSide(
                              //                 color: Colors.white,
                              //                 width: 0,
                              //               ),
                              //             ),
                              //             filled: true,
                              //             fillColor: Colors.white,
                              //             hintText: "${DateTime.now().month}",
                              //             labelStyle: GoogleFonts.raleway(
                              //               fontSize: 16,
                              //               color: Colors.black.withOpacity(0.7),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width:MediaQuery.of(context).size.height *
                              //           0.15,
                              //       height: MediaQuery.of(context).size.height *
                              //           0.075,
                              //
                              //       child: TextFormField(
                              //         // controller: TextEditingController(text: "${streamSnapshot.data?.docs[index]['age']}"),
                              //         decoration: InputDecoration(
                              //           focusedErrorBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(24.0),
                              //             borderSide: const BorderSide(
                              //               color: Colors.red,
                              //               width: 1.5,
                              //             ),
                              //           ),
                              //           errorBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(24.0),
                              //             borderSide: const BorderSide(
                              //               color: Colors.red,
                              //               width: 1.5,
                              //             ),
                              //           ),
                              //           errorStyle: const TextStyle(
                              //               color: Colors.red
                              //           ),
                              //           focusedBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(24.0),
                              //             borderSide: BorderSide(
                              //               color: blueColor,
                              //               // color: Color.fromRGBO(2, 62, 99, 20),
                              //               width: 1.5,
                              //             ),
                              //           ),
                              //
                              //           enabledBorder: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(24.0),
                              //             borderSide: const BorderSide(
                              //               color: Colors.white,
                              //               width: 0,
                              //             ),
                              //           ),
                              //           filled: true,
                              //           fillColor: Colors.white,
                              //           hintText: "${DateTime.now().year}",
                              //           labelStyle: GoogleFonts.raleway(
                              //             fontSize: 16,
                              //             color: Colors.black.withOpacity(0.7),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.015,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  child: Text(
                                    "Your date of birth",
                                    style: GoogleFonts.raleway(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.075,
                                child: TextFormField(
                                  onChanged: (val) {
                                    changedAge = currentAgeVolunteer;
                                  },
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DatePicker()),
                                    );
                                  },
                                  // controller: TextEditingController(text: streamSnapshot.data?.docs[index]['phone_number']),
                                  decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorStyle:
                                    const TextStyle(color: Colors.red),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: BorderSide(
                                        color: blueColor,
                                        // color: Color.fromRGBO(2, 62, 99, 20),
                                        width: 1.5,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: dateOfBirth,
                                    labelStyle: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.015,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.005,
                                  ),
                                  child: Text(
                                    "Your phone number",
                                    style: GoogleFonts.raleway(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.075,
                                child: TextFormField(
                                  onChanged: (val) {
                                    changedPhone = val;
                                  },
                                  // controller: TextEditingController(text: streamSnapshot.data?.docs[index]['phone_number']),
                                  decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorStyle:
                                    const TextStyle(color: Colors.red),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: BorderSide(
                                        color: blueColor,
                                        // color: Color.fromRGBO(2, 62, 99, 20),
                                        width: 1.5,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 0,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: streamSnapshot.data?.docs[index]
                                    ['phone_number'],
                                    labelStyle: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top:
                                  MediaQuery.of(context).size.height * 0.02,
                                  bottom:
                                  MediaQuery.of(context).size.height * 0.02,
                                ),
                                child: Text(
                                    "Choose categories which are the best suitable for you",
                                    style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Colors.black,
                                    )),
                              ),
                              buildCategorySettings(context, categories_list_all[3],
                                  Icons.pets_rounded),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                              buildCategorySettings(context, categories_list_all[4],
                                  Icons.local_grocery_store),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                              buildCategorySettings(context, categories_list_all[2],
                                  Icons.emoji_transportation_rounded),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                              buildCategorySettings(
                                  context, categories_list_all[1], Icons.house),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                              buildCategorySettings(context, categories_list_all[6],
                                  Icons.sign_language_rounded),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                              buildCategorySettings(context, categories_list_all[5],
                                  Icons.child_care_outlined),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                              buildCategorySettings(context, categories_list_all[7],
                                  Icons.menu_book),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                              buildCategorySettings(context, categories_list_all[8],
                                  Icons.medical_information_outlined),
                              Divider(color: Colors.black),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Center(
                                  child: Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.075,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(24)),
                                    child: TextButton(
                                        child: Text(
                                          "Sign Out",
                                          style: GoogleFonts.raleway(
                                            fontSize: 22,
                                            color: blueColor,
                                          ),
                                        ),
                                        onPressed: () async {
                                          await _auth.signOut();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const OptionChoose()));
                                        }),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.015,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Center(
                                  child: Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.075,
                                    decoration: buttonDecoration,
                                    child: TextButton(
                                        child: Text(
                                          "Done",
                                          style: textButtonStyle,
                                        ),
                                        onPressed: () async {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(streamSnapshot
                                              .data?.docs[index].id)
                                              .update({
                                            "category": changedCategories!=[]?changedCategories:streamSnapshot
                                                .data?.docs[index]['category'],
                                            "user_name": changedName!=""?changedName:streamSnapshot
                                                .data?.docs[index]['user_name'],
                                            "age": changedAge!=0?changedAge:streamSnapshot
                                                .data?.docs[index]['age'],
                                            "phone_number": changedPhone!=""?changedPhone:streamSnapshot
                                                .data?.docs[index]['phone_number']
                                          });
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const HomeVol()));
                                        }),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton:
      // Padding(
      //   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.77,),
      //   child: Padding(
      //     padding: padding,
      //     child: Align(
      //       alignment: Alignment.bottomCenter,
      //       child: StreamBuilder(
      //           stream: FirebaseFirestore.instance
      //               .collection('users')
      //               .where('id_vol', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      //               .snapshots(),
      //           builder:
      //               (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
      //             return ListView.builder(
      //                 itemCount: !streamSnapshot.hasData
      //                     ? 1
      //                     : streamSnapshot.data?.docs.length,
      //                 itemBuilder: (ctx, index) {
      //                   return Center(
      //                     child: Container(
      //                       width: double.infinity,
      //                       height: MediaQuery.of(context).size.height *
      //                           0.075,
      //                       decoration: buttonDecoration,
      //                       child: TextButton(
      //                           child: Text(
      //                             "Done",
      //                             style: textButtonStyle,
      //                           ),
      //                           onPressed: () async {
      //                             FirebaseFirestore.instance
      //                                 .collection('users')
      //                                 .doc(streamSnapshot
      //                                 .data?.docs[index].id)
      //                                 .update({
      //                               "category": chosenCategoryList
      //                             });
      //                             Navigator.push(
      //                                 context,
      //                                 MaterialPageRoute(
      //                                     builder: (context) =>
      //                                     const HomeVol()));
      //                           }),
      //                     ),
      //                   );
      //                 });
      //           }),
      //     ),
      //   ),
      // ),
      // FloatingActionButton(
      //   child: const Text('Done'),
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection("users")
      //         .doc(FirebaseAuth.instance.currentUser?.uid)
      //         .update({"category": chosen_category_settings});
      //     // print(categories_user);
      //     // categories_user = streamSnapshot.data?.docs[index]['category'];
      //     // print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO__________OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
      //     // print(categories_user);
      //     // Navigator.push(context, MaterialPageRoute(builder: (context) => Categories()));
      //
      //     showDialog<String>(
      //       context: context,
      //       builder: (BuildContext context) => AlertDialog(
      //         title: const Text('Confirm changes'),
      //         content: const Text(
      //             'Are you sure that you want to change your settings?'),
      //         actions: <Widget>[
      //           TextButton(
      //             onPressed: () {
      //               Navigator.push(context,
      //                   MaterialPageRoute(builder: (context) => HomeVol()));
      //             },
      //             child: const Text('Cancel'),
      //           ),
      //           TextButton(
      //             onPressed: () {
      //               // categories_user= [];
      //               categories_user_Register = chosen_category_settings;
      //               print(
      //                   "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO__________OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
      //               // print(categories_user);
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => YourCategories()));
      //             },
      //             child: const Text('Yes'),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }

  GestureDetector buildCategorySettings(
      BuildContext context, String text, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (changedCategories.contains(text)) {
            changedCategories.remove(text);
          } else {
            changedCategories.add(text);
          }
        });
      },
      child: AnimatedContainer(
        height: MediaQuery.of(context).size.height * 0.075,
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: chosenCategoryList.contains(text) ? blueColor : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Icon(
                icon,
                size: 30,
                color: chosenCategoryList.contains(text)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            Text(
              text,
              style: GoogleFonts.raleway(
                fontSize: 16,
                color: chosenCategoryList.contains(text)
                    ? Colors.white
                    : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
