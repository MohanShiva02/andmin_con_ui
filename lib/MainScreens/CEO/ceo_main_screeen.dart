// import 'dart:ui';
//
// import 'package:andmin_con_ui/MainScreens/CEO/wrk_done_view.dart';
// import 'package:andmin_con_ui/MainScreens/CEO/wrk_not_entry.dart';
// import 'package:andmin_con_ui/main.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart'hide BoxDecoration, BoxShadow;
// import 'package:lottie/lottie.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
//
//
//
// class CEOScreen extends StatefulWidget {
//   const CEOScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CEOScreen> createState() => _CEOScreenState();
// }
//
// class _CEOScreenState extends State<CEOScreen> {
//   final _auth = FirebaseDatabase.instance.reference().child("staff");
//   final user = FirebaseAuth.instance.currentUser;
//
//   final database = FirebaseDatabase.instance.ref().child("onyx");
//   final textController = TextEditingController();
//
//   bool isPressed = false;
//
//   String? CurrerntUser;
//   var fbData;
//   var userName;
//
//   loadData() {
//     _auth.once().then((value) => {
//           for (var element in value.snapshot.children)
//             {
//               fbData = element.value,
//               if (fbData["email"] == CurrerntUser)
//                 {
//                   setState(() {
//                     userName = fbData['name'];
//                   }),
//                 }
//             }
//         });
//   }
//
//   var fbdata2;
//   UpdateOnyx() {
//     database.update({
//       "announcement": textController.text,
//     }).then((value) {
//       textController.clear();
//     });
//   }
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     CurrerntUser = user?.email;
//     super.initState();
//     loadData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     Offset distance = isPressed ? Offset(5, 5) : Offset(10, 10);
//     double blur = isPressed ? 5.0 : 25;
//     return Scaffold(
//       backgroundColor: Color(0xffF7F9FC),
//       body: Stack(
//         children: [
//           Positioned(
//             top: height * 0.00,
//             left: width * 0.0,
//             right: width * 0.0,
//             child: Lottie.asset("assets/84668-background-animation.json"),
//           ),
//           Positioned(
//             top: height * 0.75,
//             left: width * 0.0,
//             right: width * 0.0,
//             child: Lottie.asset("assets/84669-background-animation.json"),
//           ),
//           Positioned(
//             top: height * 0.13,
//             left: 1,
//             right: 1,
//             child: Column(
//               children: [
//                 Container(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           width: width*0.3,
//                           child: TextFormField(
//                             controller: textController,
//                             decoration: InputDecoration(
//                                 hintText: "Announcement",
//                               hintStyle: const TextStyle(
//                                   color: Colors.black26,
//                                   fontFamily: 'Nexa',
//                                   fontSize: 13),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(width: 2, color: Colors.orange),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: height*0.02,),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               UpdateOnyx();
//                               isPressed = !isPressed;
//                             });
//                           },
//                           child: Listener(
//                             onPointerUp: (_) => setState(() {
//                               isPressed = true;
//                             }),
//                             onPointerDown: (_) => setState(() {
//                               isPressed = true;
//                             }),
//                             child: AnimatedContainer(
//                               margin: const EdgeInsets.only(top: 1),
//                               width: width * 0.2,
//                               height: height * 0.05,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: const Color(0xffF7F9FC),
//                                 // Colors.white.withOpacity(0.3),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black26,
//                                     offset: distance,
//                                     blurRadius: blur,
//                                     inset: isPressed,
//                                   ),
//                                   BoxShadow(
//                                     color: Colors.white12,
//                                     offset: -distance,
//                                     blurRadius: blur,
//                                     inset: isPressed,
//                                   ),
//                                 ],
//                               ),
//                               duration: Duration(milliseconds: 250),
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     // Icon(Icons.search_rounded,size: height*0.02,color: Colors.blueGrey,),
//                                     Text(
//                                       'Announce',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w800,
//                                           fontFamily: "Nexa",
//                                           fontSize: height * 0.013,
//                                           color: Colors.black),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                 ),
//                 // Center(
//                 //   child: Text(
//                 //     "Choose your Destination",
//                 //     style: TextStyle(
//                 //         fontWeight: FontWeight.w900,
//                 //         fontFamily: "Nexa",
//                 //         fontSize: height * 0.025,
//                 //         color:  Colors.black),
//                 //   ),
//                 // ),
//                 // const Divider(
//                 //   thickness: 3,
//                 //   indent: 30,
//                 //   endIndent: 30,
//                 //   height: 4,
//                 //   color: Colors.black,
//                 // ),
//                 // SizedBox(
//                 //   height: height * 0.03,
//                 // ),
//                 // Center(
//                 //   child: Text(
//                 //     "Welcome ${userName.toString().trim()} ",
//                 //     style: TextStyle(
//                 //         color: Colors.black,
//                 //         fontFamily: 'Nexa',
//                 //         fontWeight: FontWeight.bold,
//                 //         fontSize: height * 0.017),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//           Positioned(
//               top: height * 0.03,
//               left: width * 0.9,
//               right: width * 0.0,
//               child: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     FirebaseAuth.instance.signOut();
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const MainPage(),
//                       ),
//                     );
//                   });
//                 },
//                 icon: Icon(
//                   Icons.logout,
//                   color: Colors.white,
//                 ),
//                 iconSize: 25,
//               )),
//           Positioned(
//             top: height * 0.25,
//             bottom: height * 0.30,
//             left: width * 0.0,
//             right: width * 0.0,
//             child: GridView(
//               physics: const NeverScrollableScrollPhysics(),
//               scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//
//               ),
//               children: [
//                 // Container(
//                 //   child: buttons(
//                 //       "New User",
//                 //       NewUser(),
//                 //       Icon(
//                 //         Icons.manage_accounts_outlined,
//                 //         size: height * 0.05,
//                 //         color: Colors.amber,
//                 //       )),
//                 // ),
//                 // Container(
//                 //   child: buttons(
//                 //       "View Leads",
//                 //       const ViewLeeds(),
//                 //       Icon(
//                 //         Icons.view_day,
//                 //         size: height * 0.05,
//                 //         color: Colors.amber,
//                 //       )),
//                 // ),
//
//                 Container(
//                   child: buttons(
//                       "Work Done",
//                       const ViewWrkDone(),
//                       Icon(
//                         Icons.work_outline_rounded,
//                         size: height * 0.05,
//                         color: Colors.amber,
//                       )),
//                 ),
//                 Container(
//                   child: buttons(
//                       "Absent Details",
//                       const AbsentAndPresent(),
//                       Icon(
//                         Icons.work_outline_rounded,
//                         size: height * 0.05,
//                         color: Colors.amber,
//                       )),
//                 ),
//
//               ],
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
//
//   GestureDetector buttons(String name, Widget pageName, Icon icon) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => pageName));
//         });
//       },
//       child: AnimatedContainer(
//
//         margin: EdgeInsets.all(20),
//         height: height * 0.15,
//         width: width * 0.4,
//
//         duration: const Duration(milliseconds: 100),
//         decoration: BoxDecoration(
//           color: Color(0xffF7F9FC),
//           // Colors.white.withOpacity(0.3),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               offset: Offset(9.0, 9.0),
//               blurRadius: 9,
//             ),
//             BoxShadow(
//               color: Colors.white,
//               offset: Offset(-10.0, -10.0),
//               blurRadius: 10,
//             ),
//           ],
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               icon,
//               SizedBox(
//                 height: height * 0.02,
//               ),
//               Text(
//                 name,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontFamily: 'Nexa',
//                   fontSize: 15,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
