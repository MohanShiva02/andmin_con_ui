import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class AddNotes extends StatefulWidget {
  var txt;

  AddNotes({Key? key, required this.txt}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _auth = FirebaseDatabase.instance.ref().child("customer");
  final user = FirebaseAuth.instance.currentUser;

  bool button1 = false;
  bool button2 = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController notesField = TextEditingController();
  TextEditingController ratingField = TextEditingController();

  String? formattedTime;
  var formattedDate;

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyy-MM-dd');
    formattedTime = DateFormat('kk:mm:ss').format(now);
    // formattedTime = DateFormat('kk:mm:a').format(now);
    formattedDate = formatter.format(now);
  }

  var fbData;

  createNotes() {
    _auth.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.key);
        if (element.key == widget.txt) {
          // print(element.value);
          fbData = element.key;
          // print(fbData);
          // print(formattedTime);
          // print(formattedDate);
          setState(() {
            _auth
                .child(fbData)
                .child(
                    "notes/${formattedDate.toString().trim()}_${formattedTime.toString().trim()}")
                .set({
              'date': formattedDate,
              'time': formattedTime,
              'note': notesField.text.trim(),
            }).then((value) {
              notesField.clear();
            });
          });
        }
      }
    });
  }

  // Get Current Location........................................
  String location = 'Get';
  String lat = '';
  String long = '';

  var latVal;
  var logVal;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placeMark[0];
    lat = "${position.latitude.toDouble()}";
    long = " ${position.longitude.toDouble()}";
    // setState(() {
    latVal = double.parse(lat);
    logVal = double.parse(long);
    // });
  }

  getLocation() async {
    Position position = await _determinePosition();
    // print(position.latitude);
    // print(position.longitude);
    getAddressFromLatLong(position);
    location = 'Lat: ${position.latitude}   long: ${position.longitude}';
  }

  createLocation() {
    _auth.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.key);
        if (element.key == widget.txt) {
          // print(element.value);
          fbData = element.key;
          // print(fbData);
          // print(formattedTime);
          // print(formattedDate);
          setState(() {
            _auth
                .child(fbData)
                .child(
                    "'Location'/'${formattedDate.toString().trim()}_${formattedTime.toString().trim()}'")
                .set({
              'Lat val': latVal,
              'Log Val': logVal,
            });
          });
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    todayDate();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Offset distance = button1 ? Offset(5, 5) : Offset(-30, 20);
    double blur = button1 ? 5.0 : 25;

    Offset distance1 = button2 ? Offset(5, 5) : Offset(-30, 20);
    double blur1 = button2 ? 5.0 : 25;

    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: height * 0.1,
                decoration: BoxDecoration(
                  // color: Colors.orange.shade400,
                  gradient: LinearGradient(
                      colors: [
                        Color(0xff21409D),
                        Color(0xff050851),
                      ],
                      stops: [
                        0.0,
                        11.0
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated,
                  ),
                ),
                child: Stack(
                  children: [
                    // Positioned(
                    //     top: 0,
                    //     left: 0,
                    //     right: 0,
                    //     child: Image.asset(
                    //       'assets/cloud-storage - Copy.png',
                    //       height: height * 0.6,
                    //     ),
                    // ),
                    Positioned(
                      top: height * 0.09,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Text(
                          'Add Notes',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xffffffff),
                              fontFamily: "Nexa",
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.2,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffF7F9FC),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: height * 0.08,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 1),
                                    width: width * 0.7,
                                    height: height * 0.13,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xffF7F9FC),
                                      // Colors.white.withOpacity(0.3),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(-30, 30),
                                          blurRadius: 20,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            // fontFamily: "Nexa"
                                        ),
                                        controller: notesField,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          fillColor: Color(0xffFBF8FF),
                                          hintStyle: const TextStyle(
                                              fontFamily: 'Nexa',
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16,
                                              color: Colors.black54
                                              // (0xffFBF8FF)
                                              ),
                                          contentPadding:
                                              const EdgeInsets.all(20),
                                          hintText:
                                              '                Enter Notes',
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value.toString().isEmpty) {
                                            return 'Notes is Empty';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.08,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            final isValid = formKey.currentState
                                                ?.validate();
                                            if (isValid!) {
                                              todayDate();
                                              createNotes();
                                            }
                                            button1 = !button1;
                                          });
                                        },
                                        child: Listener(
                                          onPointerUp: (_) => setState(() {
                                            button1 = true;
                                          }),
                                          onPointerDown: (_) => setState(() {
                                            button1 = true;
                                          }),
                                          child: AnimatedContainer(
                                            margin:
                                                const EdgeInsets.only(top: 1),
                                            width: width * 0.3,
                                            height: height * 0.06,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color(0xffF7F9FC),
                                              // Colors.white.withOpacity(0.3),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  offset: distance,
                                                  blurRadius: blur,
                                                  inset: button1,
                                                ),
                                                BoxShadow(
                                                  color: Colors.white,
                                                  offset: -distance,
                                                  blurRadius: blur,
                                                  inset: button1,
                                                ),
                                              ],
                                            ),
                                            duration:
                                                Duration(milliseconds: 150),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  // Icon(Icons.search_rounded,size: height*0.02,color: Colors.blueGrey,),
                                                  Text(
                                                    'Add Notes',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontFamily: "Nexa",
                                                        fontSize:
                                                            height * 0.013,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            todayDate();
                                            createLocation();
                                            button2 = !button2;
                                          });
                                        },
                                        child: Listener(
                                          onPointerUp: (_) => setState(() {
                                            button2 = true;
                                          }),
                                          onPointerDown: (_) => setState(() {
                                            button2 = true;
                                          }),
                                          child: AnimatedContainer(
                                            margin:
                                                const EdgeInsets.only(top: 1),
                                            width: width * 0.3,
                                            height: height * 0.06,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color(0xffF7F9FC),
                                              // Colors.white.withOpacity(0.3),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  offset: distance1,
                                                  blurRadius: blur1,
                                                  inset: button2,
                                                ),
                                                BoxShadow(
                                                  color: Colors.white,
                                                  offset: -distance1,
                                                  blurRadius: blur1,
                                                  inset: button2,
                                                ),
                                              ],
                                            ),
                                            duration:
                                                Duration(milliseconds: 150),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  // Icon(Icons.search_rounded,size: height*0.02,color: Colors.blueGrey,),
                                                  Text(
                                                    'Add Location',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontFamily: "Nexa",
                                                        fontSize:
                                                            height * 0.013,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Positioned(
            //     top: height * 0.1,
            //     left: width * 0.0,
            //     right: width * 0.0,
            //     child: Column(
            //       children: [
            //         Text(
            //           'Add Notes',
            //           style: TextStyle(
            //               fontWeight: FontWeight.w900,
            //               fontFamily: "Nexa",
            //               fontSize: height * 0.025,
            //               color: Colors.black),
            //         ),
            //         Divider(
            //           endIndent: width * 0.1,
            //           indent: width * 0.1,
            //           thickness: 2,
            //           color: Colors.black,
            //         ),
            //         SizedBox(
            //           height: height * 0.05,
            //         ),
            //         Container(
            //           margin: const EdgeInsets.only(top: 1),
            //           width: width * 0.7,
            //           height: height * 0.13,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(20),
            //             color: const Color(0xffF7F9FC),
            //             // Colors.white.withOpacity(0.3),
            //             boxShadow: const [
            //               BoxShadow(
            //                 color: Colors.black26,
            //                 offset: Offset(28, 28),
            //                 blurRadius: 30,
            //               ),
            //             ],
            //           ),
            //           child: Center(
            //             child: TextFormField(
            //               style: const TextStyle(
            //                   color: Colors.black, fontFamily: "Nexa"),
            //               controller: notesField,
            //               keyboardType: TextInputType.multiline,
            //               maxLines: 5,
            //               textInputAction: TextInputAction.done,
            //               decoration: InputDecoration(
            //                 fillColor: Color(0xffFBF8FF),
            //                 hintStyle: const TextStyle(
            //                     fontFamily: 'Nexa',
            //                     fontWeight: FontWeight.w900,
            //                     fontSize: 16,
            //                     color: Colors.black54
            //                   // (0xffFBF8FF)
            //                 ),
            //                 contentPadding: const EdgeInsets.all(20),
            //                 hintText:
            //                 '                Enter Notes',
            //                 filled: true,
            //                 border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(40),
            //                   borderSide: BorderSide.none,
            //                 ),
            //               ),
            //               validator: (value) {
            //                 if (value.toString().isEmpty) {
            //                   return 'Notes is Empty';
            //                 } else {
            //                   return null;
            //                 }
            //               },
            //             ),
            //           ),
            //         ),
            //         // SizedBox(
            //         //   height: height * 0.04,
            //         // ),
            //         // Container(
            //         //   height: height * 0.08,
            //         //   width: width * 0.5,
            //         //   decoration: BoxDecoration(
            //         //     borderRadius: BorderRadius.circular(20),
            //         //     color: const Color(0xffF7F9FC),
            //         //     // Colors.white.withOpacity(0.3),
            //         //     boxShadow: const [
            //         //       BoxShadow(
            //         //         color: Colors.black26,
            //         //         offset: Offset(28, 28),
            //         //         blurRadius: 30,
            //         //       ),
            //         //     ],
            //         //   ),
            //         //   child: Row(
            //         //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         //     children: [
            //         //       Text(
            //         //         "Rating",
            //         //         style: TextStyle(
            //         //             fontFamily: 'Nexa',
            //         //             fontWeight: FontWeight.w900,
            //         //             fontSize: 13,
            //         //             color: Colors.black
            //         //             // (0xffFBF8FF)
            //         //             ),
            //         //       ),
            //         //       VerticalDivider(
            //         //         thickness: 2,
            //         //         endIndent: 29,
            //         //         indent: 29,
            //         //         color: Colors.black,
            //         //       ),
            //         //       Container(
            //         //         // color: Colors.blueGrey,
            //         //         width: width * 0.2,
            //         //         height: height * 0.05,
            //         //         child: TextFormField(
            //         //           style: const TextStyle(
            //         //               color: Colors.black, fontFamily: "Nexa"),
            //         //           controller: ratingField,
            //         //           keyboardType: TextInputType.number,
            //         //           textInputAction: TextInputAction.done,
            //         //           decoration: InputDecoration(
            //         //             fillColor: const Color(0xffFBF8FF),
            //         //             hintStyle: const TextStyle(
            //         //                 fontFamily: 'Nexa',
            //         //                 fontWeight: FontWeight.w900,
            //         //                 fontSize: 13,
            //         //                 color: Colors.black54
            //         //                 // (0xffFBF8FF)
            //         //                 ),
            //         //             contentPadding: const EdgeInsets.all(20),
            //         //             hintText: 'Enter Rating',
            //         //             filled: true,
            //         //             border: OutlineInputBorder(
            //         //               borderRadius: BorderRadius.circular(10),
            //         //               borderSide: BorderSide.none,
            //         //             ),
            //         //           ),
            //         //           validator: (value) {
            //         //             if (value.toString().isEmpty) {
            //         //               return 'Notes is Empty';
            //         //             } else {
            //         //               return null;
            //         //             }
            //         //           },
            //         //         ),
            //         //       ),
            //         //     ],
            //         //   ),
            //         // ),
            //         SizedBox(
            //           height: height * 0.08,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   final isValid = formKey.currentState?.validate();
            //                   if (isValid!) {
            //                     todayDate();
            //                     createNotes();
            //                   }
            //                   button1 = !button1;
            //                 });
            //               },
            //               child: Listener(
            //                 onPointerUp: (_)=>setState(() {
            //                   button1 = true;
            //                 }),
            //                 onPointerDown: (_)=> setState(() {
            //                   button1 = true;
            //                 }),
            //                 child: AnimatedContainer(
            //                   margin: const EdgeInsets.only(top: 1),
            //                   width: width * 0.3,
            //                   height: height * 0.06,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20),
            //                     color: const Color(0xffF7F9FC),
            //                     // Colors.white.withOpacity(0.3),
            //                     boxShadow:  [
            //                       BoxShadow(
            //                         color: Colors.black26,
            //                         offset: distance,
            //                         blurRadius:blur ,
            //                         inset : button1,
            //                       ),
            //                       BoxShadow(
            //                         color: Colors.white,
            //                         offset: -distance,
            //                         blurRadius: blur,
            //                         inset: button1,
            //                       ),
            //                     ],
            //                   ),
            //                   duration: Duration(milliseconds: 150),
            //                   child: Center(
            //                     child: Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                       children: [
            //                         // Icon(Icons.search_rounded,size: height*0.02,color: Colors.blueGrey,),
            //                         Text(
            //                           'Add Notes',
            //                           style: TextStyle(
            //                               fontWeight: FontWeight.w800,
            //                               fontFamily: "Nexa",
            //                               fontSize: height * 0.013,
            //                               color: Colors.black),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   todayDate();
            //                   createLocation();
            //                   button2 = !button2;
            //                 });
            //               },
            //               child: Listener(
            //                 onPointerUp: (_)=>setState(() {
            //                   button2 = true;
            //                 }),
            //                 onPointerDown: (_)=> setState(() {
            //                   button2 = true;
            //                 }),
            //                 child: AnimatedContainer(
            //                   margin: const EdgeInsets.only(top: 1),
            //                   width: width * 0.3,
            //                   height: height * 0.06,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20),
            //                     color: const Color(0xffF7F9FC),
            //                     // Colors.white.withOpacity(0.3),
            //                     boxShadow:  [
            //                       BoxShadow(
            //                         color: Colors.black26,
            //                         offset: distance,
            //                         blurRadius:blur ,
            //                         inset : button2,
            //                       ),
            //                       BoxShadow(
            //                         color: Colors.white,
            //                         offset: -distance,
            //                         blurRadius: blur,
            //                         inset: button2,
            //                       ),
            //                     ],
            //                   ),
            //                   duration: Duration(milliseconds: 150),
            //                   child: Center(
            //                     child: Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                       children: [
            //                         // Icon(Icons.search_rounded,size: height*0.02,color: Colors.blueGrey,),
            //                         Text(
            //                           'Add Location',
            //                           style: TextStyle(
            //                               fontWeight: FontWeight.w800,
            //                               fontFamily: "Nexa",
            //                               fontSize: height * 0.013,
            //                               color: Colors.black),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ))
          ],
        ),
      ),
    );
  }
}
