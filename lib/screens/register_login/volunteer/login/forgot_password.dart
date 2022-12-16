import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wol_pro_1/constants.dart';
import 'package:wol_pro_1/screens/intro_screen/option.dart';
import 'package:wol_pro_1/screens/register_login/volunteer/register/register_volunteer_1.dart';
import 'package:wol_pro_1/services/auth.dart';
import 'package:wol_pro_1/widgets/loading.dart';


import '../../../../../widgets/text_form_field.dart';


TextEditingController controllerTextFieldForgotPasswordVol = TextEditingController();
bool isVisibleForgotPassword = false;

class ForgotPasswordVol extends StatefulWidget {

  const ForgotPasswordVol({Key? key}) : super(key: key);

  @override
  _ForgotPasswordVolState createState() => _ForgotPasswordVolState();
}

class _ForgotPasswordVolState extends State<ForgotPasswordVol> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : WillPopScope(
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
          backgroundColor: const Color.fromRGBO(233, 242, 253, 8),
          appBar: AppBar(
            title: Text(
              "Volunteer",
              style: GoogleFonts.sairaStencilOne(
                fontSize: 25,
                color: Colors.black.withOpacity(0.7),

              ),
              textAlign: TextAlign.center,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OptionChoose()),
                  );
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: blueColor,)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: padding,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.08),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Reset password",
                            style: GoogleFonts.raleway(
                              fontSize: 35,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text(
                        //     "Sign in to continue",
                        //     style: GoogleFonts.raleway(
                        //       fontSize: 18,
                        //       color: Colors.black,
                        //     ),
                        //     textAlign: TextAlign.left,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: isVisibleForgotPassword,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 12.0),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              )),
                          elevation: errorEmpty==true? 0:5,
                          child: CustomTextFormField(
                            customHintText: 'Email',
                            customErrorText: 'Enter an email',
                            hide: false,
                          ),
                        ),
                        // SizedBox(height: !errorEmpty
                        //     ?MediaQuery.of(context).size.height * 0.02
                        //     :MediaQuery.of(context).size.height * 0.015,),
                        // Material(
                        //   color: Colors.transparent,
                        //   shape: const RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(24),
                        //       )),
                        //   elevation: errorEmpty==true? 0:5,
                        //   child: CustomTextFormField(
                        //     customHintText: 'Password',
                        //     customErrorText: 'Enter a password',
                        //     hide: true,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // Center(
                  //   child: CustomButton(buttonName: 'Refugee'),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: !errorEmpty
                            ?MediaQuery.of(context).size.height * 0.17
                            : MediaQuery.of(context).size.height * 0.02),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.085,
                      decoration: buttonActiveDecoration,
                      child: TextButton(
                          child: Text(
                            "Sign In",
                            style: textActiveButtonStyle,
                          ),
                          onPressed: () async {
                            // registrationVol = false;
                            // if (controllerTextFieldEmailVol.text.isEmpty) {
                            //   setState(() {
                            //     errorEmpty = true;
                            //
                            //   });
                            // }
                            // if (controllerTextFieldPasswordVol.text.isEmpty) {
                            //   setState(() {
                            //     errorEmpty = true;
                            //
                            //   });
                            // }
                            // if (_formKey.currentState!.validate()) {
                            //   setState(() => loading = true);
                            //   dynamic result =
                            //   await _auth.signInWithEmailAndPasswordVol(
                            //       emailVolLog, passwordVolLog);
                            //
                            //
                            //   if (result == null) {
                            //     setState(() {
                            //       errorEmpty = true;
                            //       isVisible = true;
                            //       loading = false;
                            //       error =
                            //       'Could not sign in with those credentials';
                            //     });
                            //   } else{
                            //     justSignedIn = true;
                            //
                            //   }
                            // }
                          }),
                    ),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     TextButton(
                  //         onPressed: () {
                  //           widget.toggleView();
                  //         },
                  //         child: Text(
                  //           "Sign up",
                  //           style: GoogleFonts.raleway(
                  //             fontSize: 15,
                  //             color: Colors.black,
                  //           ),
                  //         )),
                  //     TextButton(
                  //         onPressed: () {},
                  //         child: Text(
                  //           "Forgot password",
                  //           style: GoogleFonts.raleway(
                  //             fontSize: 15,
                  //             color: Colors.black,
                  //           ),
                  //         )),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
