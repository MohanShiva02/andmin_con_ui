import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Drawer.dart';

class ViewLeads extends StatefulWidget {
  const ViewLeads({Key? key}) : super(key: key);

  @override
  State<ViewLeads> createState() => _ViewLeadsState();
}

class _ViewLeadsState extends State<ViewLeads> {
  final customer = FirebaseDatabase.instance.ref().child("customer");
  final user = FirebaseAuth.instance.currentUser;
  List name = [];
  List number = [];
  List location = [];
  List email = [];
  List rating = [];
  List createdDate = [];
  List enquiry = [];
  List state = [];
  List fetched = [];
  List inCharge = [];
  var fbData;

  details() {
    customer.once().then((value) {
      for (var lead in value.snapshot.children) {
        fbData = lead.value;
        // print(fbData);
        setState(() {
          number.add(fbData['phone_number']);
          // print('step 1');
          name.add(fbData['name']);
          // print('step 2');
          location.add(fbData['city']);
          // print('step 3');
          state.add(fbData['customer_state']);
          // print('step 4');
          createdDate.add(fbData['created_date']);
          // print('step 5');
          rating.add(fbData['rating']);
          // print('step 6');
          enquiry.add(fbData['inquired_for']);
          // print('step 7');
          email.add(fbData['email_id']);
          // print('step 8');
          fetched.add(fbData['data_fetched_by']);
          // print('step 9');
          inCharge.add(fbData['LeadIncharge']);
        });
      }
    });
  }


  @override
  void initState() {
    details();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F9FC),
      key: _scaffoldKey,
      drawer: const ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(60), bottomRight: Radius.circular(60)),
        child: Drawer(
          child: NavigationDrawer(),
        ),
      ),
      body: Stack(
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
                      Color(0xff1A2980),
                      Color(0xff26D0CE),
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
                      top: height * 0.01,
                      right: width * 0.01,
                      // left: width*0.3,
                      child: Image.asset(
                        'assets/searching-error.png',
                        scale: 20.0,
                      )),
                  Positioned(
                    top: height * 0.03,
                    left: width * 0.0,
                    // right: 30,
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          _scaffoldKey.currentState?.openDrawer();
                        });
                      },
                      iconSize: height * 0.04,
                      icon: Icon(Icons.menu),
                    ),
                  ),
                  Positioned(
                    top: height * 0.10,
                    // right: 0,
                    left: width * 0.03,
                    child: Center(
                      child: Text(
                        'Lead Info . . .',
                        style: TextStyle(
                          fontSize: height * 0.04,
                          color: Color(0xffffffff),
                          fontFamily: "Nexa",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.18,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffF7F9FC),
                // image: DecorationImage(
                //   // alignment: Alignment.bottomCenter,
                //   image: AssetImage(
                //     'assets/outdoor.png',
                //   ),
                //   fit: BoxFit.scaleDown,
                // ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: number.isEmpty
                  ? Lottie.asset(
                      "assets/81778-loading.json",
                      repeat: true,
                    )
                  : Theme(
                      data: Theme.of(context).copyWith(
                        scrollbarTheme: ScrollbarThemeData(
                          radius: Radius.circular(20),
                          thumbColor: MaterialStateProperty.all(Colors.black),
                        ),
                      ),
                      child: Scrollbar(
                        isAlwaysShown: true,
                        showTrackOnHover: true,
                        hoverThickness: 10,
                        thickness: 10,
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: name.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 2 / 3.3,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  leadDetails(
                                      "Name", "${name[index]}", Colors.black),
                                  leadDetails("Phone", "${number[index]}",
                                      Colors.black),
                                  leadDetails("Location", "${location[index]}",
                                      Colors.black),
                                  leadDetails("Enquiry", "${enquiry[index]}",
                                      Colors.black),
                                  leadDetails(
                                      "Email", "${email[index]}", Colors.black),
                                  leadDetails("createdDate",
                                      "${createdDate[index]}", Colors.black),
                                  leadDetails("Data Fetched From", "${fetched[index]}", Colors.black),
                                  leadDetails("Lead InCharge", "${inCharge[index]}", Colors.black),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(10)
                                    ),

                                    child: leadDetails(
                                      'Status',
                                      '${state[index]}',
                                      state[index] == "Following Up"
                                          ? Colors.green
                                          : state[index] == "Delayed"
                                              ? Colors.orange
                                              : state[index] ==
                                                      "Rejected from management side"
                                                  ? Colors.red
                                                  : state[index] ==
                                                          "Rejected from Customer end"
                                                      ? Colors.red
                                                      : Color(0xffF7F9FC),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height*0.03,
                                  ),
                                  Divider(
                                    endIndent: width * 0.09,
                                    indent: width * 0.09,
                                    thickness: 3,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leadDetails(String title, String address, color) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Container(
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: height * 0.02,
                color: Colors.black,
                fontWeight: FontWeight.w800)),
        trailing: SingleChildScrollView(
          child: Text(address,
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: height * 0.02,
                  color: color,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//   body: GridView.builder (
//     itemCount:name.length,
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 1,
//       childAspectRatio: 3 / 1,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//     ),
//     itemBuilder: (BuildContext context, int index) {
//       return Container(
//         child: Column (
//           children: [
//             name.isEmpty? Text('Is loading'):
//             Column(
//               children: [
//                 Text(name[index]),
//                 Text(number[index]),
//                 Text(email[index]),
//                 Text(enquiry[index]),
//                 Text(location[index]),
//                 Text(createdDate[index]),
//                 Text(fetched[index]),
//                 Text(state[index]),
//                 Text(rating[index].toString()),
//
//               ],
//             )
//           ],
//         ),
//       );
//     },
//   ),
//   );
// }
}
