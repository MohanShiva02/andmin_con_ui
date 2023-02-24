import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Drawer.dart';

class ViewWrkDone extends StatefulWidget {
  const ViewWrkDone({Key? key}) : super(key: key);

  @override
  State<ViewWrkDone> createState() => _ViewWrkDoneState();
}

class _ViewWrkDoneState extends State<ViewWrkDone> {
  final database = FirebaseDatabase.instance.ref().child("staff");

  DateTime now = DateTime.now();
  var formatterDate = DateFormat('yyyy-MM-dd');
  var formatterMonth = DateFormat('MM');
  var formatterYear = DateFormat('yyyy');

  double percent = 0;
  String? selectedDate;
  String? selectedMonth;
  String? selectedYear;

  var fbData;

  List allData = [];
  List nameData = [];
  List name = [];
  List from = [];
  List to = [];
  List workDone = [];
  List workPercentage = [];
  List totalTime = [];

  // List dayTotalWork = [];

  DatePicker() async {
    selectedDate = formatterDate.format(now);
    selectedMonth = formatterDate.format(now);
    selectedYear = formatterDate.format(now);

    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (newDate == null) return;
    setState(() {
      selectedDate = formatterDate.format(newDate);
      selectedMonth = newDate.toString().substring(5, 7);
      selectedYear = newDate.toString().substring(0, 4);
      // print(selectedYear);
      if (selectedDate != null) {
        loadData();
      }
    });
  }

  // String? formattedTime;
  // var formattedDate;
  // var formattedMonth;
  // var formattedYear;
  //
  // todayDate() {
  //   var now = DateTime.now();
  //   var formatterDate = DateFormat('yyy-MM-dd');
  //   var formatterYear = DateFormat('yyy');
  //   var formatterMonth = DateFormat('MM');
  //   formattedTime = DateFormat('kk:mm:a').format(now);
  //   formattedDate = formatterDate.format(now);
  //   formattedYear = formatterYear.format(now);
  //   formattedMonth = formatterMonth.format(now);
  // }

  loadData() {
    name.clear();
    from.clear();
    to.clear();
    workDone.clear();
    workPercentage.clear();

    database.once().then((value) {
      for (var element in value.snapshot.children) {
        // fbData = element.value;
        for (var element1 in element.children) {
          // // print(element1.key);
          if (element1.key == "workManager") {
            for (var element2 in element1.children) {
              // // print(element2.key);
              for (var element3 in element2.children) {
                if (element3.key == selectedYear) {
                  for (var element4 in element3.children) {
                    if (element4.key == selectedMonth) {
                      for (var element5 in element4.children) {
                        if (element5.key == selectedDate) {
                          for (var element6 in element5.children) {
                            // // print(element6.key);
                            // if(element6.key == 'totalWorkingTime'){
                            //   // for(var element7 in element6.children){
                            //   //   setState(() {
                            //   //     dayTotalWork.add(element7.value);
                            // //   //     print(dayTotalWork);
                            //   //   });
                            //   // }
                            // }
                            fbData = element6.value;
                            if (fbData['name'] != null) {
                              name.remove(fbData['name']);
                              setState(() {
                                allData.add(fbData);
                                nameData.add(fbData['name']);
                                nameData = nameData.toSet().toList();
                                // // print(nameData);
                                name.add(fbData['name']);
                                // dayTotalWork.add(fbData['day']);
                                to.add(fbData['to']);
                                from.add(fbData['from']);
                                // print(name);
                              });
                            }
                            // // print(fbData);
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }

          // for (var element2 in element1.children) {
          //
          //   for (var element3 in element2.children) {
          //
          //     // if (element3.key == selectedDate) {
          //     //   for (var element4 in element3.children) {
          // //     //     // print(element4.value);
          //     //     fbData = element4.value;
          //     //     setState(() {
          //     //       allData.add(fbData);
          // //     //       // print("allData......${allData}");
          //     //       nameData.add(fbData['name']);
          //     //       nameData = nameData.toSet().toList();
          // //     //       // print('data2 ..................${nameData}');
          //     //       name.add(fbData['name']);
          //     //       to.add(fbData['to']);
          //     //       from.add(fbData['from']);
          //     //       workDone.add(fbData['workDone']);
          //     //       workPercentage.add(fbData['workPercentage']);
          //     //       totalTime.add(fbData["time_in_hours"]);
          //     //     });
          //     //   }
          //     // }
          //   }
          // }
        }
      }
    });
  }

  @override
  void initState() {
    selectedDate = formatterDate.format(now);
    selectedMonth = formatterMonth.format(now);
    selectedYear = formatterYear.format(now);
    // print(selectedDate);
    // todayDate();
    loadData();
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
                  "Works History",
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
                        allData.clear();
                        nameData.clear();
                      });
                    },
                    child: Icon(Icons.calendar_month,
                        color: Colors.orange.shade800, size: height * 0.05),
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
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          nameData.length == 0
                              ? Text(
                                  "${nameData.length == 0 ? 'Loading' : 'No Data'}",
                                  style: TextStyle(
                                      fontFamily: 'Nexa',
                                      fontSize: 20,
                                      color: Colors.black),
                                )
                              // const Text("",
                              //         style: TextStyle(
                              //             fontFamily: 'Nexa',
                              //             fontSize: 20,
                              //             color: Colors.black))
                              : buildGridView(height, width)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: height * 0.18,
          //   left: width * 0.0,
          //   right: width * 0.0,
          //   bottom: 0,
          //   child: SingleChildScrollView(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         SingleChildScrollView(
          //           child: Column(
          //             children: [
          //               // ElevatedButton(
          //               //     onPressed: () {
          //               //       setState(() {
          //               //         loadData();
          //               //       });
          //               //     },
          // //               //     child: Text("print")),
          //               nameData.length == 0
          //                   ? Text("${nameData == 0 ? 'Load Data' : 'No Data'}")
          //               // const Text("",
          //               //         style: TextStyle(
          //               //             fontFamily: 'Nexa',
          //               //             fontSize: 20,
          //               //             color: Colors.black))
          //                   : buildGridView(height, width)
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildGridView(double height, double width) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 1,
        //   // childAspectRatio: 3 / 1.9,
        //   // crossAxisSpacing: 0,
        //   // mainAxisSpacing: 20,
        // ),
        itemCount: nameData.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            margin: EdgeInsets.all(25),
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
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [
                    Color(0xff1A2980),
                    Color(0xff26D0CE),
                    // Color(0xffEFA41C),
                    // Color(0xffD52A29),
                  ],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  tileMode: TileMode.repeated),
            ),
            padding: EdgeInsets.symmetric(
                vertical: height * 0.005, horizontal: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${nameData[index]}",
                  style: const TextStyle(
                    fontFamily: 'Nexa',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Container(
                  // color: Colors.blue,
                  height: height * 0.20,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: nameData.length == 0
                        ? const Text("Select Date",
                            style: TextStyle(
                                fontFamily: 'Nexa',
                                fontSize: 20,
                                color: Colors.black))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allData.length,
                            itemBuilder: (BuildContext context, int ind) {
                              return allData[ind]['name']
                                      .contains(nameData[index])
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          right: width * 0.03,
                                          left: width * 0.03),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              subTitle(
                                                  '[ ${allData[ind]['from']}'),
                                              subTitle("To"),
                                              subTitle(
                                                  ' ${allData[ind]['to']} ]'),
                                              subTitle(
                                                  '${allData[ind]['time_in_hours']} '),
                                              subTitle(
                                                  '${allData[ind]['workPercentage']}'),
                                            ],
                                          ),
                                          LinearPercentIndicator(
                                            animation: true,
                                            animationDuration: 1000,
                                            lineHeight: height * 0.005,
                                            percent: percent = double.parse(
                                                    allData[ind]
                                                            ['workPercentage']
                                                        .replaceAll(
                                                            RegExp(r'.$'),
                                                            "")) /
                                                100,
                                            backgroundColor: Colors.black12,
                                            progressColor:
                                                Colors.orange.shade500,
                                          ),
                                          Text(
                                            '${allData[ind]['workDone']}',
                                            style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: height * 0.05,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
              ],
            ),
          );
        });
  }

  Text subTitle(String name) => Text(
        name,
        style: const TextStyle(
            fontFamily: 'Avenir',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.white),
      );
}
