import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';

final auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late SharedPreferences logData;

  bool _showPassword = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    await auth
        .signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    )
        .catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Wrong Email or Password"),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff21222D),
      body: Stack(
        children: [

          /// bottom left
          Positioned(
            top: height* 0.25,
            right: width* 0.80,
            left: width* -0.20,
            child: Neumorphic(
              // margin: EdgeInsets.all(15),
              style: NeumorphicStyle(
                depth: -10,
                boxShape: NeumorphicBoxShape.circle(),
                shadowDarkColorEmboss: Colors.orange.withOpacity(0.7),
                // shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
                shadowLightColorEmboss: Color(0xff000000),
                // color: const Color(0xffF7F9FC),
                color: Color(0xff21222D),
              ),
              child: Container(
                width: double.infinity,
                height: height * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.orange.shade400,
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade500,
                        Colors.orangeAccent
                      ],
                      stops: [
                        0.0,
                        11.0
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated),
                ),

              ),
            ),
          ),

          /// top right
          Positioned(
            top: height* 0.2,
            right: width* -0.30,
            left: width* 0.30,
            child: Neumorphic(
              // margin: EdgeInsets.all(15),
              style: NeumorphicStyle(
                depth: -5,
                boxShape: NeumorphicBoxShape.circle(),
                shadowDarkColorEmboss: Colors.orange.withOpacity(0.7),
                // shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
                shadowLightColorEmboss: Color(0xff000000),
                // color: const Color(0xffF7F9FC),
                color: Color(0xff21222D),
              ),
              child: Container(
                width: double.infinity,
                height: height * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.orange.shade400,
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade500,
                        Colors.orangeAccent
                      ],
                      stops: [
                        0.0,
                        11.0
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated),
                ),

              ),
            ),
          ),

          ///bottom right
          Positioned(
            top: height* 0.85,
            right: width* -0.70,
            left: width* 0.50,
            child: Neumorphic(
              // margin: EdgeInsets.all(15),
              style: NeumorphicStyle(
                depth: -5,
                boxShape: NeumorphicBoxShape.circle(),
                shadowDarkColorEmboss: Color(0xff000000),
                // shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
                shadowLightColorEmboss: Color(0xff000000),
                // color: const Color(0xffF7F9FC),
                color: Color(0xff21222D),
              ),
              child: Container(
                width: double.infinity,
                height: height * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.orange.shade400,
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade500,
                        Colors.orangeAccent
                      ],
                      stops: [
                        0.0,
                        11.0
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated),
                ),

              ),
            ),
          ),

          ///small
          Positioned(
            top: height* 0.85,
            right: width* 0.0,
            left: width* -0.30,
            child: Neumorphic(
              // margin: EdgeInsets.all(15),
              style: NeumorphicStyle(
                depth: -2,
                boxShape: NeumorphicBoxShape.circle(),
                shadowDarkColorEmboss: Colors.orange.withOpacity(0.7),
                // shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
                shadowLightColorEmboss: Color(0xff000000),
                // color: const Color(0xffF7F9FC),
                color: Color(0xff21222D),
              ),
              child: Container(
                width: double.infinity,
                height: height * 0.05,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.orange.shade400,
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade500,
                        Colors.orange,
                      ],
                      stops: [
                        0.0,
                        11.0
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated),
                ),

              ),
            ),
          ),
          Positioned(
            top: height* -0.50,
            right: width* -0.50,
            left: width* -0.50,
            child: Container(
              width: double.infinity,
              height: height * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color: Colors.orange.shade400,
                // borderRadius:
                    // BorderRadius.only(bottomRight: Radius.circular(150)),
                gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade500,
                      Colors.orangeAccent
                      // Color(0xff21409D),
                      // Color(0xff050851),
                    ],
                    stops: [
                      0.0,
                      11.0
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    tileMode: TileMode.repeated),
              ),
              child: Stack(
                children: [
                  Positioned(
                      bottom: height * 0.05,
                      right: width * 0.0,
                      left: width * 0.0,
                      child: Center(
                        child: Text(" Welcome Back",
                            style: TextStyle(
                                fontFamily: 'Nexa',
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w900)),
                      )),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: height* -0.50,
          //   right: width* -0.50,
          //   left: width* -0.50,
          //   child: Container(
          //     width: double.infinity,
          //     height: height * 0.7,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       // color: Colors.orange.shade400,
          //       // borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
          //       gradient: LinearGradient(
          //           colors: [
          //             Colors.orange.shade500,
          //             Colors.orangeAccent
          //           ],
          //           stops: [
          //             0.0,
          //             11.0
          //           ],
          //           begin: FractionalOffset.topLeft,
          //           end: FractionalOffset.bottomRight,
          //           tileMode: TileMode.repeated),
          //     ),
          //     child: Stack(
          //       children: [
          //         Positioned(
          //             top: height * 0.08,
          //             right: width * 0.3,
          //             left: width * 0.3,
          //             child: Text("",
          //                 style: TextStyle(
          //                     fontFamily: 'Nexa',
          //                     fontSize: height * 0.03,
          //                     fontWeight: FontWeight.w900))),
          //       ],
          //     ),
          //   ),
          // ),
          Positioned(
            top: height * 0.23,
            left: width * 0.0,
            right: width * 0.0,
            bottom: height * 0.02,
            child: Container(
              height: height * 0.5,
              // width: width*0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  // color: Colors.white.withOpacity(0.5),
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.black26,
                  //       offset: Offset(-30, 20),
                  //       blurRadius: 20),
                  //   BoxShadow(
                  //       color: Colors.white12,
                  //       offset: Offset(0, 0),
                  //       blurRadius: 20),
                  // ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      width: width * 0.75,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white,
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(-15, 15),
                                blurRadius: 10,
                                spreadRadius: 1)
                          ]),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.01,
                          ),
                          const Icon(Icons.account_circle),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Container(
                            height: height * 0.06,
                            width: width * 0.60,
                            padding: EdgeInsets.only(left: width * 0.02),
                            decoration: BoxDecoration(
                                // color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Center(
                              child: TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please Enter Email");
                                  }
                                  // if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                  //   return ('Please Enter Valid Email');
                                  // }
                                  return null;
                                },
                                onSaved: (value) {
                                  email.text = value!;
                                },
                                style: const TextStyle(
                                    color: Colors.black, fontFamily: ""),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "   Email",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nexa',
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: height * 0.05,
                      ),
                      width: width * 0.75,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white
                              // Color(0xff7AF3FC),
                              // Color(0xff3865FA),
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(-15, 15),
                                blurRadius: 9,
                                spreadRadius: 1)
                          ]),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.01,
                          ),
                          const Icon(Icons.password),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Container(
                            height: height * 0.06,
                            width: width * 0.60,
                            padding: EdgeInsets.only(left: width * 0.02),
                            decoration: const BoxDecoration(
                              // color: Color(0xff202B3E),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: password,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscureText: !_showPassword,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ('Password required');
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  password.text = value!;
                                },
                                style: const TextStyle(
                                    color: Colors.black, fontFamily: ""),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                  ),
                                  hintText: "   Password",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nexa',
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        logData = await SharedPreferences.getInstance();
                        setState(() {
                          logData.setBool('login', true);
                          // logData.setString(
                          //     'ownerName', 'Onwords Smart Solutions');
                          // logData.setString('ownerStreet', 'Pollachi');
                          // logData.setString('ownerAddress', 'Coimbatore');
                          // logData.setString('ownerWebsite', 'www.onwords.in');
                          // logData.setString('ownerEmail', 'cs@onwords.in');
                          // logData.setString('ownerGst', '33BTUPN5784J1ZT');
                          // logData.setInt('ownerPhone', int.parse('7708630275'));
                          login();
                        });
                      },
                      child: Container(

                        height: height * 0.07,
                        width: width * 0.75,
                        margin: EdgeInsets.only(
                            top: height * 0.09,
                            left: width * 0.0,
                            right: width * 0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Colors.orange, Colors.orangeAccent],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(-8, 8),
                              blurRadius: 9,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "LogIn",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Nexa",
                              fontSize: height * 0.02,
                              color: const Color(0xffFBF8FF),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
