import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Drawer.dart';

class AbsentAndPresent extends StatefulWidget {
  const AbsentAndPresent({Key? key}) : super(key: key);

  @override
  State<AbsentAndPresent> createState() => _AbsentAndPresentState();
}

class _AbsentAndPresentState extends State<AbsentAndPresent> {
  final database = FirebaseDatabase.instance.ref().child("staff");

  DateTime now = DateTime.now();
  var formatterDate = DateFormat('yyyy-MM-dd');
  String? selectedDate;

  var fbData;
  List notEntry = [];

  List allData = [];
  List nameData = [];

  DatePicker() async {
    selectedDate = formatterDate.format(now);
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (newDate == null) return;
    setState(() {
      selectedDate = formatterDate.format(newDate);
      if (selectedDate != null) {
        loadData();
      }
    });
  }

  String? formattedTime;
  var formattedDate;
  var formattedMonth;
  var formattedYear;

  todayDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyy-MM-dd');
    var formatterYear = DateFormat('yyy');
    var formatterMonth = DateFormat('MM');
    formattedTime = DateFormat('kk:mm:a').format(now);
    formattedDate = formatterDate.format(now);
    formattedYear = formatterYear.format(now);
    formattedMonth = formatterMonth.format(now);
  }

  loadData() {
    database.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.value);
        fbData = element.value;

        setState(() {
          notEntry.add(fbData['name']);
          notEntry = notEntry.toSet().toList();
          if (fbData['department'] == "ADMIN") {
            setState(() {
              notEntry.remove(fbData['name']);
            });
          }
          // print(notEntry);
        });
        for (var element1 in element.children) {
          if (element1.key == "workManager") {
            for (var element2 in element1.children) {
              // print(element2.key);
              for (var element3 in element2.children) {
                if (element3.key == formattedYear) {
                  for (var element4 in element3.children) {
                    if (element4.key == formattedMonth) {
                      for (var element5 in element4.children) {
                        // print(element5.value);
                        if (element5.key == selectedDate) {
                          // print(element5.value);
                          if (fbData['name'] != notEntry) {
                            setState(() {
                              notEntry.remove(fbData['name']);
                              // print(
                              //     "..................${notEntry}..............................");
                            });
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    });
  }

  // loadData() {
  //   database.once().then((value) {
  //     for (var element in value.snapshot.children) {
  //       // print(element.value);
  //       fbData = element.value;
  //
  //       setState(() {
  //         notEntry.add(fbData['name']);
  //         // notEntry = notEntry.toSet().toList();
  //         if (fbData['department'] == "admin") {
  //           setState(() {
  //             notEntry.remove(fbData['name']);
  //           });
  //         }
  //         // print(notEntry);
  //       });
  //       for (var element1 in element.children) {
  //         for (var element2 in element1.children) {
  //           for (var element3 in element2.children) {
  //             if (element3.key == selectedDate) {
  //               for (var element4 in element3.children) {
  //                 // print(element4.value);
  //                 fbData = element4.value;
  //                 if (fbData['name'] != notEntry) {
  //                   setState(() {
  //                     notEntry.remove(fbData['name']);
  //                     // print(
  //                     //     "..................${notEntry}..............................");
  //                   });
  //                 }
  //                 setState(() {
  //                   allData.add(fbData);
  //                   // print("allData......${allData}");
  //                   nameData.add(fbData['name']);
  //                   nameData = nameData.toSet().toList();
  //                   // print('data2 ..................${nameData}');
  //                 });
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    selectedDate = formatterDate.format(now);
    print(selectedDate);
    loadData();
    todayDate();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.04,
            left: 1,
            right: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Absent",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: "Nexa",
                      fontSize: height * 0.03,
                      color: Colors.white),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
              ],
            ),
          ),
          Positioned(
              top: height * 0.13,
              left: width * 0.60,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$selectedDate',
                      style: TextStyle(
                          fontFamily: 'Nexa',
                          fontSize: 15,
                          color: Colors.white)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        DatePicker();
                        notEntry.clear();
                      });
                    },
                    child: Icon(Icons.calendar_month,
                        color: Colors.orange, size: height * 0.04),
                  ),
                ],
              )),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            notEntry.length == 0
                                ? Text(
                                    "${notEntry.length == 0 ? 'Loading' : 'No Data'}",
                                    style: TextStyle(
                                        fontFamily: 'Nexa',
                                        fontSize: 20,
                                        color: Colors.black))
                                // const Text("Select Date to View Details",
                                //         style: TextStyle(
                                //             fontFamily: 'Nexa',
                                //             fontSize: 20,
                                //             color: Colors.black))
                                : ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: notEntry.length,
                                    itemBuilder:
                                        (BuildContext context, int ind) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffF7F9FC),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(9),
                                        // height: height*0.0,
                                        width: width * 0.9,
                                        child: Column(
                                          children: [
                                            notEntry != 0
                                                ? Text("${notEntry[ind]}",
                                                    style: TextStyle(
                                                        fontFamily: 'Nexa',
                                                        fontSize: 18,
                                                        color: Colors.black))
                                                : Text(
                                                    "No Absents in This Date")
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        //  Column(
        //   children: [
        //     Container(
        //       margin: EdgeInsets.only(
        //           top: height * 0.05, left: width * 0.04, right: width * 0.04),
        //       height: height * 0.07,
        //       decoration: BoxDecoration(
        //           color: Color(0xffF7F9FC),
        //           borderRadius: BorderRadius.circular(30),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.white.withOpacity(0.2),
        //               offset: Offset(9.0, 9.0),
        //               blurRadius: 9,
        //             ),
        //             BoxShadow(
        //               color: Colors.black26,
        //               offset: Offset(-10.0, -10.0),
        //               blurRadius: 10,
        //             ),
        //           ],
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             "Staff Absents Details ",
        //             style: TextStyle(
        //               fontWeight: FontWeight.w900,
        //               fontFamily: "Avenir",
        //               fontSize: height * 0.018,
        //             ),
        //           ),
        //           // SizedBox(
        //           //   width: width * 0.06,
        //           // ),
        //           VerticalDivider(
        //             color: Colors.black,
        //             thickness: 2,
        //             indent: 15,
        //             endIndent: 15,
        //           ),
        //           GestureDetector(
        //             onTap: () {
        //               setState(() {
        //                 DatePicker();
        //                 notEntry.clear();
        //               });
        //             },
        //             child: Icon(Icons.calendar_month,
        //                 color: Colors.orange, size: height * 0.04),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(20),
        //       margin: EdgeInsets.only(
        //           top: height * 0.05, left: width * 0.04, right: width * 0.04),
        //       height: height * 0.5,
        //       width: width * 09,
        //       decoration: BoxDecoration(
        //           color:Color(0xffF7F9FC),
        //           borderRadius: BorderRadius.circular(30),
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
        //           ]),
        //       child: SingleChildScrollView(
        //         child: Column(
        //           children: [
        //             notEntry.length == 0
        //                 ? Text("${notEntry.length == 0 ? 'No Data': 'Load Data'}")
        //             // const Text("Select Date to View Details",
        //             //         style: TextStyle(
        //             //             fontFamily: 'Nexa',
        //             //             fontSize: 20,
        //             //             color: Colors.black))
        //                 : ListView.builder(
        //                     scrollDirection: Axis.vertical,
        //                     physics: NeverScrollableScrollPhysics(),
        //                     shrinkWrap: true,
        //                     itemCount: notEntry.length,
        //                     itemBuilder: (BuildContext context, int ind) {
        //                       return Container(
        //                         decoration: BoxDecoration(
        //                           color: Color(0xffF7F9FC),
        //                           borderRadius: BorderRadius.circular(20),
        //                         ),
        //                         margin: EdgeInsets.all(5),
        //                         padding: EdgeInsets.all(9),
        //                         // height: height*0.0,
        //                         width: width * 0.9,
        //                         child: Column(
        //                           children: [
        //                           notEntry != 0 ?Text("${notEntry[ind]}",
        //                                 style: TextStyle(
        //                                     fontFamily: 'Nexa',
        //                                     fontSize: 18,
        //                                     color: Colors.black)):Text("No Absents in This Date")
        //                           ],
        //                           crossAxisAlignment: CrossAxisAlignment.center,
        //                         ),
        //                       );
        //                     },
        //                   ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
