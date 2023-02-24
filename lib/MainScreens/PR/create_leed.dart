import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:intl/intl.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class CreateLeeds extends StatefulWidget {
  const CreateLeeds({Key? key}) : super(key: key);

  @override
  State<CreateLeeds> createState() => _CreateLeedsState();
}

class _CreateLeedsState extends State<CreateLeeds> {
  final _auth = FirebaseDatabase.instance.ref().child("customer");
  final user = FirebaseAuth.instance.currentUser;

  String? userEmail;

  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController loc = TextEditingController();
  TextEditingController enq = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fetch = TextEditingController();
  TextEditingController rating = TextEditingController();

  String? formattedTime;
  var formattedDate;

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyy-MM-dd');

    setState(() {
      formattedTime = DateFormat('kk:mm:a').format(now);
      formattedDate = formatter.format(now);
    });
    print(formattedDate);
    print(formattedTime);
  }

  var fbData;

  createLeads() {
    _auth.once().then((value) => {
          setState(() {
            _auth.child("${phone.text.trim()}").set({
              'city': loc.text.trim(),
              'email_id': email.text,
              'created_by': userEmail.toString().trim(),
              'created_date': formattedDate,
              'created_time': formattedTime,
              'customer_state': 'Following Up',
              'data_fetched_by': fetch.text.trim(),
              'inquired_for': enq.text.trim(),
              'name': name.text.trim(),
              'phone_number': phone.text.trim(),
              'rating': '0',
            }).then((value) {
              name.clear();
              phone.clear();
              loc.clear();
              enq.clear();
              email.clear();
              fetch.clear();
            });
          }),
        });
  }

  @override
  void initState() {
    setState(() {
      todayDate();
      userEmail = user?.email;
    });

    super.initState();
  }

  bool isPressed = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Offset distance = isPressed ? Offset(5, 5) : Offset(-25, 15);
    double blur = isPressed ? 35 : 20.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                height: 600,
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
                      tileMode: TileMode.repeated),
                ),
                child: Stack(

                  children: [
                    // Positioned(
                    //     top: height * 0.03,
                    //     right: width * 0.01,
                    //     // left: width*0.3,
                    //     child: Image.asset(
                    //       'assets/arranging-files.png',
                    //       scale: 16.0,
                    //     )),
                    Positioned(
                      top: 30,
                      left: 20,
                      // right: 30,

                      child: IconButton(
                        color: Colors.orange.shade800,
                        onPressed: () {
                          setState(() {
                            _scaffoldKey.currentState?.openDrawer();
                          });
                        },
                        iconSize: height * 0.04,
                        icon: Container(child: Image.asset('assets/menu.png')),
                      ),
                    ),
                    Positioned(
                      top: height * 0.13,
                      // right: 0,
                      left: width * 0.04,
                      child: Center(
                        child: Text(
                          'Create New Leads . . .',
                          style: TextStyle(
                              fontSize: height * 0.02,
                              color: Color(0xffffffff),
                              fontFamily: "Nexa",
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: height*0.25,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffF7F9FC),
                  // image: DecorationImage(
                  //   alignment: Alignment.bottomCenter,
                  //   image: AssetImage(
                  //     'assets/outdoor.png',
                  //   ),
                  //   fit: BoxFit.scaleDown,
                  // ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  // fit: StackFit.expand,
                  children: [
                    // Positioned(
                    //     top: height * 0.0,
                    //     left: 0,
                    //     right: 0,
                    //     bottom: 0,
                    //     child: Image.asset('assets/outdoor.png',fit: BoxFit.fill,)),
                    Positioned(
                      top: height * 0.04,
                      left: 0,
                      right: 0,
                      // bottom: 0,
                      child: SizedBox(
                        height: height*0.45,
                        // color: Colors.blue,
                        child: SingleChildScrollView(
                          child: Column (
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buildListView("Name", name, TextInputType.name,
                                  'Enter the name'),
                              buildListView("Phone", phone, TextInputType.number,
                                  'Enter the Phone Number'),
                              buildListView("Location", loc, TextInputType.name,
                                  'Enter the Location'),
                              buildListView("Enquiry For", enq,
                                  TextInputType.name, 'Enter the name'),
                              buildListView("Email", email,
                                  TextInputType.emailAddress, 'Enter the Email'),
                              buildListView("Data Fetched By", fetch,
                                  TextInputType.name, 'Enter Data Fetched By'),
                              SizedBox(
                                height: height * 0.03,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: height*0.5,
                      left: width*0.2,
                      right: width*0.2,
                      child:  GestureDetector(
                          onTap: () {
                            setState(() {
                              isPressed = !isPressed;
                              final isValid =
                              formKey.currentState?.validate();
                              if (isValid!) {
                                createLeads();
                              }
                              // print(formattedTime);
                              // print(formattedDate);
                            });
                          },
                          child: Listener(
                            onPointerUp: (_) => setState(() {
                              isPressed = true;
                            }),
                            onPointerDown: (_) => setState(() {
                              isPressed = true;
                            }),
                            child: AnimatedContainer(
                              margin: const EdgeInsets.only(top: 1),
                              width: width * 0.3,
                              height: height * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xffF7F9FC),
                                // Colors.white.withOpacity(0.3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: distance,
                                    blurRadius: blur,
                                    inset: isPressed,
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: -distance,
                                    blurRadius: blur,
                                    inset: isPressed,
                                  ),
                                ],
                              ),
                              duration: Duration(milliseconds: 250),
                              child: const Center(
                                child: Text("Submit",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nexa",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),

            // Positioned(
            //   top: height * 0.1,
            //   left: width * 0.03,
            //   right: width * 0.03,
            //   bottom: 0,
            //   child: Container(
            //     padding: EdgeInsets.symmetric(
            //         vertical: height * 0.03, horizontal: width * 0.01),
            //     width: width * 0.3,
            //     height: height * 0.85,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(30),
            //       color: Color(0xffF7F9FC),
            //       // Colors.white.withOpacity(0.3),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black26,
            //           offset: Offset(9.0, 9.0),
            //           blurRadius: 10,
            //         ),
            //         // BoxShadow(
            //         //   color: Colors.white,
            //         //   offset: Offset(-1.0, -0.0),
            //         //   blurRadius: 10,
            //         // ),
            //       ],
            //     ),
            //     child: SingleChildScrollView(
            //       child: Column(
            //         children: [
            //           const Text(
            //             "Create Lead",
            //             style: TextStyle(
            //                 fontWeight: FontWeight.w900,
            //                 fontFamily: 'Nexa',
            //                 fontSize: 35,
            //                 color: Colors.black),
            //           ),
            //           dividers(),
            //           SingleChildScrollView(
            //             child: Column(
            //               children: [
            //                 buildListView("Name", name, TextInputType.name,
            //                     'Enter the name'),
            //                 buildListView("Phone", phone, TextInputType.number,
            //                     'Enter the Phone Number'),
            //                 buildListView("Location", loc, TextInputType.name,
            //                     'Enter the Location'),
            //                 buildListView("Enquiry For", enq,
            //                     TextInputType.name, 'Enter the name'),
            //                 buildListView("Email", email,
            //                     TextInputType.emailAddress, 'Enter the Email'),
            //                 buildListView("Data Fetched By", fetch,
            //                     TextInputType.name, 'Enter Data Fetched By'),
            //                 SizedBox(
            //                   height: height * 0.09,
            //                 ),
            //                 GestureDetector(
            //                     onTap: () {
            //                       setState(() {
            //                         isPressed = !isPressed;
            //                         final isValid =
            //                         formKey.currentState?.validate();
            //                         if (isValid!) {
            //                           createLeads();
            //                         }
            //                         // print(formattedTime);
            //                         // print(formattedDate);
            //                       });
            //                     },
            //                     child: Listener(
            //                       onPointerUp: (_) => setState(() {
            //                         isPressed = true;
            //                       }),
            //                       onPointerDown: (_) => setState(() {
            //                         isPressed = true;
            //                       }),
            //                       child: AnimatedContainer(
            //                         margin: const EdgeInsets.only(top: 1),
            //                         width: width * 0.3,
            //                         height: height * 0.06,
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(30),
            //                           color: const Color(0xffF7F9FC),
            //                           // Colors.white.withOpacity(0.3),
            //                           boxShadow: [
            //                             BoxShadow(
            //                               color: Colors.black26,
            //                               offset: distance,
            //                               blurRadius: blur,
            //                               inset: isPressed,
            //                             ),
            //                             BoxShadow(
            //                               color: Colors.white,
            //                               offset: -distance,
            //                               blurRadius: blur,
            //                               inset: isPressed,
            //                             ),
            //                           ],
            //                         ),
            //                         duration: Duration(milliseconds: 250),
            //                         child: const Center(
            //                           child: Text("Submit",
            //                               style: TextStyle(
            //                                   color: Colors.black,
            //                                   fontFamily: "Nexa",
            //                                   fontSize: 18,
            //                                   fontWeight: FontWeight.w800)),
            //                         ),
            //                       ),
            //                     )),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildListView(String name, TextEditingController,
      TextInputType textInputType, String val) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      reverse: true,
      children: [
        SizedBox(
          height: height * 0.05,
          child: ListTile(
              trailing: Container(
                width: width * 0.5,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(-10, 10),
                        blurRadius: 15,
                        spreadRadius: 9),
                    BoxShadow(
                      color: Colors.white12,
                      offset: Offset(4, 4),
                      blurRadius: 10,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                      colors: [
                        Color(0xffEFA41C),
                        Color(0xffD52A29),
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: TextFormField(
                      controller: TextEditingController,
                      keyboardType: textInputType,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return val;
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(color: Colors.white, fontFamily: "Avenir"),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        hintText: "     ${name}",
                        helperStyle: TextStyle(color: Colors.black),
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(width: 1, color: Colors.black54),
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                        // hintText: hint,
                        hintStyle: const TextStyle(
                            color: Colors.black26,
                            fontFamily: 'Nexa',
                            fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ),
              leading: Container(
                width: width * 0.35,
                height: height * 0.04,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(-10, 10),
                        blurRadius: 15,
                        spreadRadius: 9),
                    BoxShadow(
                      color: Colors.white12,
                      offset: Offset(4, 4),
                      blurRadius: 10,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  gradient: LinearGradient(
                      colors: [
                        Color(0xffEFA41C),
                        Color(0xffD52A29),
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated),
                ),
                child: Center(
                  child: Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white, fontFamily: "Nexa", fontSize: 13),
                  ),
                ),
              )),
        ),
      ].reversed.toList(),
    );
  }

  Divider dividers() {
    return const Divider(
      height: 1,
      color: Colors.black,
      indent: 30,
      endIndent: 30,
      thickness: 1,
    );
  }
}
