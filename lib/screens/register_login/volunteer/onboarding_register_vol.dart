

import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wol_pro_1/constants.dart';

import '../../intro_screen/option.dart';
import '../../menu/volunteer/home_page/settings/upload_photo.dart';
import '../../menu/volunteer/main_screen.dart';
import 'login/sign_in_volunteer.dart';



class OnBoardingVolunteerReg extends StatefulWidget {
  const OnBoardingVolunteerReg({Key? key}) : super(key: key);

  @override
  State<OnBoardingVolunteerReg> createState() => _OnBoardingVolunteerRegState();
}

class _OnBoardingVolunteerRegState extends State<OnBoardingVolunteerReg> {

  final controllerPageView = PageController();

  // loadImage() async{
  //
  //   DocumentSnapshot variable = await FirebaseFirestore.instance.
  //   collection('users').
  //   doc(FirebaseAuth.instance.currentUser!.uid).
  //   get();
  //
  //   //a list of images names (i need only one)
  //   var img_url = variable['image'];
  //   //select the image url
  //   Reference  ref = FirebaseStorage.instance.ref().child("user_pictures/").child(img_url);
  //
  //   //get image url from firebase storage
  //   var url = await ref.getDownloadURL();
  //
  //   print("GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG");
  //   print(url);
  //   // put the URL in the state, so that the UI gets rerendered
  //   setState(() {
  //     url_image = url;
  //   });
  // }
  // bool _isLoading = true;
  // late StreamSubscription<User?> user;
  // void initState(){
  //   super.initState();
  //
  //   // if(justSignedIn){
  //   //
  //   // }
  //   user = FirebaseAuth.instance.authStateChanges().listen((user) async {
  //     loadImage();
  //     DocumentSnapshot variable = await FirebaseFirestore.instance.
  //     collection('users').
  //     doc(FirebaseAuth.instance.currentUser!.uid).
  //     get();
  //     var imageBoard = variable["image"];
  //     print("IIIIIIIIIIIImageeeeeeeeeeeeeee Board");
  //     print(imageBoard);
  //     if(imageBoard!=''){
  //       print("IIIIIIIIIIIImageeeeeeeeeeeeeee2222222222222 Board");
  //       print(imageBoard);
  //       loadImage();
  //     }
  //     var currentRole = variable['role'];
  //     print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCWraper");
  //     print(variable["category"]);
  //     print(FirebaseAuth.instance.currentUser!.uid);
  //     categoriesVolunteer = [];
  //     var cList = variable["category"];
  //     cList.forEach((element) {
  //       categoriesVolunteer.add(element);
  //     });
  //     // categoriesVolunteer
  //     //     .add(variable["category"][0]);
  //     print(categoriesVolunteer);
  //     setState(() {
  //       if(currentRole=='1'){
  //         optionRefugee = false;
  //         print(11111111111111);
  //         print(currentRole);
  //         print(optionRefugee);
  //       } else{
  //         optionRefugee = true;
  //         print(22222222222222);
  //         print(currentRole);
  //         print(optionRefugee);
  //       }
  //     });
  //
  //   });
  //   Future.delayed(Duration(seconds: 5), () {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //
  // }

  @override
  void dispose(){
    controllerPageView.dispose();

    super.dispose();
  }

  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
        child: PageView(
          controller: controllerPageView,
          onPageChanged: (index){
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            buildPage(
              color: Colors.white,
            buildSizedBox: false,
            image: "assets/onboarding/1.jpg",
              title: "Choose refugee's application",
              subtitle: "This app can help you to assist any refugees by choosing application, where people are asking for different kind of an assistance. ",
              gap: MediaQuery.of(context).size.height * 0.1,
            ),
            buildPage(
              buildSizedBox: true,
              color:  Colors.white,
              image: "assets/onboarding/2.jpg",
              title: "Contact to refugee",
              subtitle: "You can contact with refugees right in this app to find out more about their application and kind of an assistance that they ask you for.",
              gap: MediaQuery.of(context).size.height * 0.15,
            ),
            buildPage(
              buildSizedBox: false,
              color: Colors.white,
              image: "assets/onboarding/3.jpg",
              title: "Get feedback of your assistance",
              subtitle: "After every assistance you will be rated to let other users know more about you as a wonderful volunteer.",
              gap: MediaQuery.of(context).size.height * 0.06,
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
      ? Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        color: blueColor,
        child: TextButton(

            child: Text("Get started",
              style: GoogleFonts.raleway(
                fontSize: 20,
                color: Colors.white,

              ),
            textAlign: TextAlign.center,
            ),
            onPressed: (){
              setState(() {
                controllerTabBottomVol = PersistentTabController(initialIndex: 2);
              });
              Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(builder: (context) => new MainScreen()));
        },
    ),
      )
      :Container(
        padding: padding,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              controllerPageView.jumpToPage(2);
            }, child: Text("Skip", style: textInactiveButtonStyle,)),
            Center(
              child: SmoothPageIndicator(
                controller: controllerPageView,
                count: 3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: background,
                  activeDotColor: blueColor
                ),
                onDotClicked: (index){
                  controllerPageView.animateToPage(
                      index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
              ),
            ),
            TextButton(onPressed: (){
              controllerPageView.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            }, child: Text("Next", style: textInactiveButtonStyle,)),
          ],
        ),
      ),
    );
  }

}

class buildPage extends StatelessWidget {
  Color color;
  String image;
  String title;
  String subtitle;
  double gap;
  bool buildSizedBox;
  buildPage({
    Key? key, required this.color, required this.image, required this.title, required this.subtitle, required this.gap, required this.buildSizedBox
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSizedBox?
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ):SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Image.asset(image,
            fit: BoxFit.cover,
              width: double.infinity,),
            SizedBox(
              height: gap,
            ),
            Text(title, style: GoogleFonts.raleway(
              fontSize: 20,
              color: Colors.black,
            ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(subtitle, style: GoogleFonts.raleway(
                fontSize: 16,
                color: blueColor,
              ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
