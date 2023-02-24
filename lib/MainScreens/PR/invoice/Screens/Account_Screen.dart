// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../login_screen.dart';
// import '../image_saving/user.dart';
// import '../image_saving/user_preference.dart';
// import '../provider_page.dart';
// import 'dart:io';
// import 'Customer_Details_Screen.dart';
//
//
//
//
// class AccountScreen extends StatefulWidget {
//   const AccountScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AccountScreen> createState() => _AccountScreenState();
// }
//
// class _AccountScreenState extends State<AccountScreen> {
//   final formKey = GlobalKey<FormState>();
//   TextEditingController name = TextEditingController();
//   TextEditingController number = TextEditingController();
//   TextEditingController email = TextEditingController();
//   late SharedPreferences logData;
//
//   readData() async {
//     logData = await SharedPreferences.getInstance();
//     setState((){
//       name.text = logData.getString('ownerName')!;
//       email.text = logData.getString('ownerEmail')!;
//       var phone = logData.getInt('ownerPhone')!;
//       number.text = phone.toString();
//     });
//   }
//   late User user;
//
//
//
//   @override
//   void initState() {
//     readData();
//     user = UserPreferences.getUser();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     final image = user.imagePath.contains('assets/blank.png') ? AssetImage(user.imagePath) : FileImage(File(user.imagePath));
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xffF7F9FC),
//         elevation: 0,
//         leading:   GestureDetector(
//           child: Image.asset(
//             'assets/back arrow.png',
//             scale: 2.3,
//           ),
//           onTap: () {
//             setState(() {
//               Navigator.pop(context);
//             });
//           },
//         ),
//         title:   Text(
//           "My Account",
//           style: TextStyle(
//               fontFamily: 'Nexa',
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//               fontSize: height * 0.015),
//         ),
//
//
//       ),
//       backgroundColor: Color(0xffF7F9FC),
//       body: Form(
//         key: formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top: height * 0.09),
//                 height: height * 0.8,
//                 decoration: const BoxDecoration(
//                   color: Color(0xffF7F9FC),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     ClipOval(
//                       child: Material(
//                         color: Color(0xffF7F9FC),
//                         child: Ink.image(
//                           image: image as ImageProvider,
//                           width: 200,
//                           height: 200,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: height*0.010,
//                     ),
//                     const Text("edited by"),
//                     SizedBox(
//                       height: height*0.010,
//                     ),
//                     Text("${auth.currentUser?.email}"),
//                     Container(
//                       margin: EdgeInsets.symmetric(
//                           horizontal: width * 0.08,),
//                       height: height * 0.4,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           TextFormField(
//                             readOnly: true,
//                             controller: name,
//                             textInputAction: TextInputAction.next,
//                             keyboardType: TextInputType.name,
//                             validator: (value) {
//                               if (value.toString().isEmpty) {
//                                 return 'Enter value';
//                               } else {
//                                 return null;
//                               }
//                             },
//                             decoration: InputDecoration(
//                                 focusedBorder: const UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 enabledBorder : const UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 prefixIcon: Icon(
//                                   Icons.account_circle_outlined,
//                                   color: Colors.deepOrangeAccent,
//                                   size: height * 0.023,
//                                 ),
//                                 hintText: 'Name',
//                                 hintStyle: const TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontFamily: 'Nexa')),
//                           ),
//                           TextFormField(
//                             readOnly: true,
//                             controller: number,
//                             textInputAction: TextInputAction.next,
//                             keyboardType: TextInputType.number,
//                             validator: (value) {
//                               if (value.toString().isEmpty) {
//                                 return 'Enter value';
//                               } else {
//                                 return null;
//                               }
//                             },
//                             decoration: InputDecoration(
//                                 focusedBorder: const UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 enabledBorder : const UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 prefixIcon: Image.asset(
//                                   'assets/number.png',
//                                   scale: 2.5,
//                                 ),
//
//                                 hintText: 'Phone Number',
//                                 hintStyle: const TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontFamily: 'Nexa')),
//                           ),
//                           TextFormField(
//                             readOnly: true,
//                             controller: email,
//                             textInputAction: TextInputAction.done,
//                             keyboardType: TextInputType.name,
//                             validator: (value) {
//                               if (value.toString().isEmpty) {
//                                 return 'Enter value';
//                               } else {
//                                 return null;
//                               }
//                             },
//                             decoration: InputDecoration(
//                                 focusedBorder: const UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 enabledBorder : const UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                 ),
//                                 prefixIcon: Image.asset(
//                                   'assets/mail.png',
//                                   scale: 2.5,
//                                 ),
//                                 hintText: 'E mail',
//                                 hintStyle: const TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontFamily: 'Nexa')),
//                           ),
//                         ],
//                       ),
//                     ),
//                     ElevatedButton(onPressed: (){
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const CustomerDetails()));
//                       Provider.of<TaskData>(context,listen: false).invoiceListData.clear();
//                       Provider.of<TaskData>(context,listen: false).value.clear();
//                       Provider.of<TaskData>(context,listen: false).deleteCustomerDetails(1);
//                     }, child: const Text("Generate new Pdf "))
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
