// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class NewUser extends StatefulWidget {
//   @override
//   State<NewUser> createState() => _NewUserState();
// }
//
// class _NewUserState extends State<NewUser> {
//   final _auth = FirebaseDatabase.instance.reference().child("staff");
//
//   final firebaseAuth = FirebaseAuth.instance;
//
//   TextEditingController namecntl = TextEditingController();
//   TextEditingController Emailcntl = TextEditingController();
//   TextEditingController depcntl = TextEditingController();
//   TextEditingController passwordcntl = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Color(0xffFBF8FF),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top: height * 0.05),
//                 child: Text(
//                   'Create New User',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontFamily: 'Nexa',
//                       fontWeight: FontWeight.w900,
//                       fontSize: height * 0.03),
//                 ),
//               ),
//               const Divider(
//                 thickness: 3,
//                 indent: 30,
//                 endIndent: 30,
//                 height: 4,
//                 color: Colors.black,
//               ),
//               Center(
//                 child: Container(
//                   margin: EdgeInsets.symmetric(
//                     vertical: height * 0.02,
//                   ),
//                   padding: EdgeInsets.symmetric(
//                     vertical: height * 0.09,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Column(
//                     children: [
//                       //////Name...................................
//                       Container(
//                         width: width * 0.81,
//                         height: height * 0.06,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color(0xff7AF3FC),
//                                 Color(0xff3865FA),
//                               ],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   // Color(0xff233045),
//                                   offset: Offset(21, 20),
//                                   blurRadius: 13,
//                                   spreadRadius: 1)
//                             ]),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: width * 0.03,
//                             ),
//                             const Icon(Icons.account_circle),
//                             SizedBox(
//                               width: width * 0.02,
//                             ),
//                             Container(
//                               height: height * 0.06,
//                               width: width * 0.70,
//                               padding: EdgeInsets.only(left: width * 0.02),
//                               decoration: const BoxDecoration(
//                                   color: Color(0xff202B3E),
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(20),
//                                       bottomLeft: Radius.circular(20),
//                                       topRight: Radius.circular(10),
//                                       bottomRight: Radius.circular(10))),
//                               child: Center(
//                                 child: TextField(
//                                   controller: namecntl,
//                                   keyboardType: TextInputType.name,
//                                   textInputAction: TextInputAction.next,
//                                   style: const TextStyle(
//                                       color: Color(0xffFBF8FF), fontFamily: ""),
//                                   decoration: const InputDecoration.collapsed(
//                                     hintText: "   Name",
//                                     hintStyle: TextStyle(
//                                         color: Color(0xffFBF8FF),
//                                         fontFamily: 'Nexa',
//                                         fontSize: 13),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       //////Dep...........................
//                       Container(
//                         margin: EdgeInsets.only(
//                           top: height * 0.05,
//                         ),
//                         width: width * 0.82,
//                         height: height * 0.06,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color(0xff7AF3FC),
//                                 Color(0xff3865FA),
//                               ],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   offset: Offset(20, 21),
//                                   blurRadius: 9,
//                                   spreadRadius: 1)
//                             ]),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: width * 0.03,
//                             ),
//                             const Icon(Icons.local_fire_department_rounded),
//                             SizedBox(
//                               width: width * 0.03,
//                             ),
//                             Container(
//                               height: height * 0.06,
//                               width: width * 0.70,
//                               padding: EdgeInsets.only(left: width * 0.02),
//                               decoration: const BoxDecoration(
//                                 color: Color(0xff202B3E),
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   bottomLeft: Radius.circular(20),
//                                   topRight: Radius.circular(10),
//                                   bottomRight: Radius.circular(10),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: TextField(
//                                   controller: depcntl,
//                                   textInputAction: TextInputAction.next,
//                                   style: const TextStyle(
//                                       color: Color(0xffFBF8FF), fontFamily: ""),
//                                   decoration: const InputDecoration.collapsed(
//                                     hintText: "   Department",
//                                     hintStyle: TextStyle(
//                                         color: Color(0xffFBF8FF),
//                                         fontFamily: 'Nexa',
//                                         fontSize: 13),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       //////Email...........................
//                       Container(
//                         margin: EdgeInsets.only(
//                           top: height * 0.05,
//                         ),
//                         width: width * 0.82,
//                         height: height * 0.06,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color(0xff7AF3FC),
//                                 Color(0xff3865FA),
//                               ],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   offset: Offset(20, 21),
//                                   blurRadius: 9,
//                                   spreadRadius: 1)
//                             ]),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: width * 0.03,
//                             ),
//                             const Icon(Icons.email_sharp),
//                             SizedBox(
//                               width: width * 0.03,
//                             ),
//                             Container(
//                               height: height * 0.06,
//                               width: width * 0.70,
//                               padding: EdgeInsets.only(left: width * 0.02),
//                               decoration: const BoxDecoration(
//                                 color: Color(0xff202B3E),
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   bottomLeft: Radius.circular(20),
//                                   topRight: Radius.circular(10),
//                                   bottomRight: Radius.circular(10),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: TextField(
//                                   controller: Emailcntl,
//                                   keyboardType: TextInputType.emailAddress,
//                                   textInputAction: TextInputAction.next,
//                                   style: const TextStyle(
//                                       color: Color(0xffFBF8FF), fontFamily: ""),
//                                   decoration: const InputDecoration.collapsed(
//                                     hintText: "   Email",
//                                     hintStyle: TextStyle(
//                                         color: Color(0xffFBF8FF),
//                                         fontFamily: 'Nexa',
//                                         fontSize: 13),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       //////Password...........................
//                       Container(
//                         margin: EdgeInsets.only(
//                           top: height * 0.05,
//                         ),
//                         width: width * 0.82,
//                         height: height * 0.06,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color(0xff7AF3FC),
//                                 Color(0xff3865FA),
//                               ],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   offset: Offset(20, 21),
//                                   blurRadius: 9,
//                                   spreadRadius: 1)
//                             ]),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                               width: width * 0.03,
//                             ),
//                             const Icon(Icons.password),
//                             SizedBox(
//                               width: width * 0.03,
//                             ),
//                             Container(
//                               height: height * 0.06,
//                               width: width * 0.70,
//                               padding: EdgeInsets.only(left: width * 0.02),
//                               decoration: const BoxDecoration(
//                                 color: Color(0xff202B3E),
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   bottomLeft: Radius.circular(20),
//                                   topRight: Radius.circular(10),
//                                   bottomRight: Radius.circular(10),
//                                 ),
//                               ),
//                               child: Center(
//                                 child: TextField(
//                                   controller: passwordcntl,
//                                   textInputAction: TextInputAction.done,
//                                   style: const TextStyle(
//                                       color: Color(0xffFBF8FF), fontFamily: ""),
//                                   decoration: const InputDecoration.collapsed(
//                                     hintText: "   Password",
//                                     hintStyle: TextStyle(
//                                         color: Color(0xffFBF8FF),
//                                         fontFamily: 'Nexa',
//                                         fontSize: 13),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       SizedBox(
//                         height: height * 0.1,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             CreateDB();
//                             firebaseAuth.createUserWithEmailAndPassword(
//                                 email: Emailcntl.text,
//                                 password: passwordcntl.text);
//                           });
//                         },
//                         child: Container(
//                           height: height * 0.05,
//                           width: width * 0.3,
//                           margin: EdgeInsets.only(
//                               top: height * 0.05,
//                               left: width * 0.20,
//                               right: width * 0.20),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               gradient: const LinearGradient(
//                                 begin: Alignment.bottomLeft,
//                                 end: Alignment.topRight,
//                                 colors: [
//                                   Color(0xff7AF3FC),
//                                   Color(0xff3865FA),
//                                 ],
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color(0xff233045).withOpacity(0.40),
//                                   offset: Offset(10, 13),
//                                   blurRadius: 9,
//                                   spreadRadius: 1,
//                                 ),
//                               ]),
//                           child: Center(
//                             child: Text(
//                               "Create",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w900,
//                                   fontFamily: "Nexa",
//                                   fontSize: height * 0.02,
//                                   color: const Color(0xffFBF8FF)),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   CreateDB() {
//     _auth.push().set({
//       "department": depcntl.text.toUpperCase(),
//       "email": Emailcntl.text,
//       "name": namecntl.text,
//       "password": passwordcntl.text,
//     }).then((value) {
//       Emailcntl.clear();
//       passwordcntl.clear();
//       namecntl.clear();
//       depcntl.clear();
//     });
//   }
// }
