import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'Drawer.dart';

class WorkEntry extends StatefulWidget {
  const WorkEntry({Key? key}) : super(key: key);

  @override
  State<WorkEntry> createState() => _WorkEntryState();
}

class _WorkEntryState extends State<WorkEntry>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final staff = FirebaseDatabase.instance.ref().child("staff");
  final user = FirebaseAuth.instance.currentUser;
  final fingerPrint = FirebaseDatabase.instance.ref().child("fingerPrint");

  final formKey = GlobalKey<FormState>();

  TextEditingController workDoneField = TextEditingController();
  TextEditingController workDoneField2 = TextEditingController();
  TextEditingController percentField = TextEditingController();

  double percent = 0;
  bool isStarted = true;
  bool isSubmit = false;
  var timeDifference;

  var getFbTime;
  var startTime;
  var endTime;

  String? formattedTime;
  var formattedDate;
  var formattedMonth;
  var formattedYear;

  todayDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyy-MM-dd');
    var formatterYear = DateFormat('yyy');
    var formatterMonth = DateFormat('MM');
    formattedTime = DateFormat('HH:mm').format(now);
    formattedDate = formatterDate.format(now);
    formattedYear = formatterYear.format(now);
    formattedMonth = formatterMonth.format(now);
    // print(formattedTime);
    // print(formattedDate);
  }

  var yesterdayDate;

  getYesterdayDate() {
    var now = DateTime.now().subtract(Duration(days: 1));
    var yesterday = DateFormat('yyy-MM-dd');
    yesterdayDate = yesterday.format(now);
    // print(yesterdayDate);
    setState(() {
      viewYesterdayPendingWrk();
    });
  }

  var fbData;
  String? from;
  String? to;
  var wrkDone;

  createWrkDone() {
    // print('hiii');
    staff.once().then((value) => {
          for (var element in value.snapshot.children)
            {
              fbData = element.value,
              if (fbData["email"] == user?.email)
                {
                  wrkDone = element.key,
                  staff
                      .child(wrkDone)
                      .child(
                          "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/${getFbTime.toString().trim()} to ${endTime.toString().trim()}")
                      .set({
                    "from": getFbTime.toString().trim(),
                    "to": endTime.toString().trim(),
                    "workDone":
                        '${tempWrk[0]}, ${workDoneField2.text.toString()}',
                    "workPercentage": '${percentField.text.trim()}%',
                    'name': fbData['name'],
                    // 'time_in_hours': timeDifference.toString().trim()
                  }).then((value) {
                    deletePendingWorks();
                    temFromTime.clear();
                    endTime = '';
                    tempWrk.clear();
                    workDoneField.clear();
                    percentField.clear();
                    viewData();
                    workDoneField2.clear();
                  })
                }
            }
        });
    // .then((value) {
    // getDayWrkTime();
    // getMonthWrkTime();
    // getYearWorkingTime();
    // });
  }

  String? CurrerntUser;
  var fbdata1;
  var totalTime;
  List nameView = [];
  List fromView = [];
  List toView = [];
  List workDoneView = [];
  List workPercentageView = [];
  List ttlWrk = [];
  List dayTotalWrk = [];

  viewData() {
    nameView.clear();
    toView.clear();
    fromView.clear();
    workPercentageView.clear();
    workDoneView.clear();
    staff.once().then((value) {
      for (var step1 in value.snapshot.children) {
        fbData = step1.value;
        if (fbData['email'] == CurrerntUser) {
          for (var step2 in step1.children) {
            if (step2.key == "workManager") {
              for (var step3 in step2.children) {
                for (var step4 in step3.children) {
                  if (step4.key == formattedYear) {
                    for (var step5 in step4.children) {
                      if (step5.key == formattedMonth) {
                        for (var step6 in step5.children) {
                          if (step6.key == formattedDate) {
                            for (var step7 in step6.children) {
                              fbdata1 = step7.value;
                              if (fbdata1['to'] != null) {
                                nameView.remove(fbdata1['to']);
                                setState(() {
                                  fromView.add(fbdata1['from']);
                                  toView.add(fbdata1['to']);
                                  workPercentageView
                                      .add(fbdata1['workPercentage']);
                                  workDoneView.add(fbdata1['workDone']);
                                  ttlWrk.add(fbdata1['time_in_hours']);
                                  nameView.add(fbdata1['name']);
                                  // print(nameView);
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
        }
      }
    });
  }

  pendingWorks() {
    staff.once().then((value) => {
          for (var element in value.snapshot.children)
            {
              fbData = element.value,
              if (fbData["email"] == user?.email)
                {
                  wrkDone = element.key,
                  staff
                      .child(wrkDone)
                      .child(
                          "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/pendingWorks/${startTime.toString().trim()}")
                      .set({
                    "from": startTime.toString().trim(),
                    "workDone": workDoneField.text.trim(),
                    'name': fbData['name'],
                  }).then((value) => viewPendingWrk())
                }
            }
        });
  }

  deletePendingWorks() {
    staff
        .once()
        .then((value) => {
              for (var element in value.snapshot.children)
                {
                  fbData = element.value,
                  if (fbData["email"] == user?.email)
                    {
                      wrkDone = element.key,
                      staff
                          .child(wrkDone)
                          .child(
                              "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/pendingWorks/")
                          .remove(),
                    }
                }
            })
        .then((value) => {viewPendingWrk()});
  }

  bool pendingWrkStatus = false;

  List temFromTime = [];
  List tempWrk = [];
  var pendingWorkDate;

  viewPendingWrk() {
    tempWrk.clear();
    staff.once().then((value) {
      for (var step1 in value.snapshot.children) {
        fbData = step1.value;
        if (fbData['email'] == CurrerntUser) {
          for (var step2 in step1.children) {
            if (step2.key == "workManager") {
              for (var step3 in step2.children) {
                for (var step4 in step3.children) {
                  if (step4.key == formattedYear) {
                    for (var step5 in step4.children) {
                      if (step5.key == formattedMonth) {
                        for (var step6 in step5.children) {
                          // print(DateTime.now().subtract(Duration(days: 1)));
                          if (step6.key == formattedDate) {
                            // setState(() {
                            //   pendingWorkDate = step6.value;
                            //   // print(pendingWorkDate);
                            // });
                            for (var step7 in step6.children) {
                              if (step7.key == 'pendingWorks') {
                                // print(step7.value);
                                for (var step8 in step7.children) {
                                  var pwrk;
                                  pwrk = step8.value;
                                  setState(() {
                                    pendingWrkStatus = true;
                                    temFromTime.add(pwrk['from']);
                                    tempWrk.add(pwrk['workDone']);
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
          }
        }
      }
    });
  }

  bool yesterdayPendingWork = false;

  viewYesterdayPendingWrk() {
    // tempWrk.clear();
    staff.once().then((value) {
      for (var step1 in value.snapshot.children) {
        fbData = step1.value;
        if (fbData['email'] == CurrerntUser) {
          for (var step2 in step1.children) {
            if (step2.key == "workManager") {
              for (var step3 in step2.children) {
                for (var step4 in step3.children) {
                  if (step4.key == formattedYear) {
                    for (var step5 in step4.children) {
                      if (step5.key == formattedMonth) {
                        for (var step6 in step5.children) {
                          // print(DateTime.now().subtract(Duration(days:1)));

                          if (step6.key == yesterdayDate) {
                            for (var step7 in step6.children) {
                              if (step7.key == 'pendingWorks') {
                                // print(step7.value);
                                setState(() {
                                  yesterdayPendingWork = true;
                                });
                                // print(step7.key);
                                // for (var step8 in step7.children) {
                                //   var pwrk;
                                //   pwrk = step8.value;
                                //   setState(() {
                                //     pendingWrkStatus = true;
                                //     temFromTime.add(pwrk['from']);
                                //     tempWrk.add(pwrk['workDone']);
                                //   });
                                // }
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
        }
      }
    });
  }

  // var fbDataDayList;
  // List dayWrkTimingList = [];

  // getDayWrkTime() {
  //   staff.once().then((value) {
  //     for (var step1 in value.snapshot.children) {
  //       fbData = step1.value;
  //       if (fbData['email'] == CurrerntUser) {
  //         for (var step2 in step1.children) {
  //           if (step2.key == "workManager") {
  //             for (var step3 in step2.children) {
  //               for (var step4 in step3.children) {
  //                 if (step4.key == formattedYear) {
  //                   for (var step5 in step4.children) {
  //                     if (step5.key == formattedMonth) {
  //                       for (var step6 in step5.children) {
  //                         if (step6.key == formattedDate) {
  //                           for (var mwt in step6.children) {
  //                             if (mwt.key != 'totalWorkingTime') {
  //                               fbDataDayList = mwt.value;
  //                               setState(() {
  //                                 dayWrkTimingList
  //                                     .add(fbDataDayList['time_in_hours']);
  //                               });
  //                             }
  //                           }
  //                         }
  //                       }
  //                     }
  //                   }
  //                 }
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }).then((value) => {uploadDayTotalWorkTiming(), dayWrkTimingList.clear()});
  // }
  //
  // int testingHours = 0;
  // int finalTestingHours = 0;
  //
  // int testingMinutes = 0;
  // int finalTestingMinutes = 0;
  // var finalDayWrkTime;
  //
  // uploadDayTotalWorkTiming() {
  //   List daytimeList = dayWrkTimingList;
  //
  //   for (var time in daytimeList) {
  //     var format = time;
  //
  //     if (format != null) {
  //       var timeFormat = DateFormat("HH:mm");
  //       var starTime = timeFormat.parse(format).toString().substring(10, 19);
  //
  //       var hours = starTime.substring(0, 3);
  //
  //       var minutes = starTime.substring(4, 6);
  //
  //       testingHours = int.parse(hours);
  //
  //       var addTime = finalTestingHours + testingHours;
  //       finalTestingHours = addTime;
  //
  //       testingMinutes = int.parse(minutes);
  //       var addMinutes = finalTestingMinutes + testingMinutes;
  //       finalTestingMinutes = addMinutes;
  //
  //       var today = DateTime.utc(0);
  //       finalDayWrkTime = today
  //           .add(Duration(
  //               hours: finalTestingHours, minutes: finalTestingMinutes))
  //           .toString()
  //           .substring(10, 19);
  //
  //       staff.once().then((value) => {
  //             for (var element in value.snapshot.children)
  //               {
  //                 fbData = element.value,
  //                 if (fbData["email"] == user?.email)
  //                   {
  //                     wrkDone = element.key,
  //                     staff
  //                         .child(wrkDone)
  //                         .child(
  //                             "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/totalWorkingTime")
  //                         .set({'day': finalDayWrkTime}).then((value) => {
  //                               finalTestingHours = 0,
  //                               finalTestingMinutes = 0,
  //                               dayWrkTimingList.clear(),
  //                               daytimeList.clear(),
  //                             })
  //                   }
  //               }
  //           });
  //     }
  //   }
  // }

//...............................month,..............................
//   var fbDataMonthList;
//   List monthWrkTimingList = [];
//
//   getMonthWrkTime() {
//     _auth.once().then((value) {
//       for (var step1 in value.snapshot.children) {
//         fbData = step1.value;
//         if (fbData['email'] == CurrerntUser) {
//           for (var step2 in step1.children) {
//             if (step2.key == "workManager") {
//               for (var step3 in step2.children) {
//                 for (var step4 in step3.children) {
//                   if (step4.key == formattedYear) {
//                     for (var step5 in step4.children) {
//                       if (step5.key == formattedMonth) {
//                         for (var mwt in step5.children) {
//                           if (mwt.key != 'totalWorkingTime') {
//                             for (var mwt2 in mwt.children) {
//                               if (mwt2.key != 'totalWorkingTime') {
//                                 fbDataMonthList = mwt2.value;
//                                 setState(() {
//                                   monthWrkTimingList.add(fbDataMonthList['time_in_hours']);
//                                   print("${monthWrkTimingList}...............getmonthwork time");
//                                 });
//                               }
//                             }
//                           }
//                         }
//                       }
//                     }
//                   }
//                 }
//               }
//             }
//           }
//         }
//       }
//     }).then((value) => {uploadMonthWorkingTime(),});
//   }
//
//   int monthHours = 0;
//   int finalMonthHours = 0;
//
//   int monthMinutes = 0;
//   int finalMonthMinutes = 0;
//   var finalmothTotalWorkingTime;
//
//   uploadMonthWorkingTime() {
//     print("${monthWrkTimingList}month work time list");
//     List monthTimeList = monthWrkTimingList;
//
//     for (var time in monthTimeList) {
//
//       var format = time;
//       print("${format}..............format in time");
//
//       if(format != null){
//         var timeFormat = DateFormat("HH:mm");
//         var starTime = timeFormat.parse(format).toString().substring(10, 19);
//
//         var hours = starTime.substring(0, 3);
//
//         var minutes = starTime.substring(4, 6);
//
//         monthHours = int.parse(hours);
//
//         var addTime = finalMonthHours + monthHours;
//         finalMonthHours = addTime;
//
//         monthMinutes = int.parse(minutes);
//         var addMinutes = finalMonthMinutes + monthMinutes;
//         finalMonthMinutes = addMinutes;
//         // print(finalTestingMinutes);
//
//         var today = DateTime.utc(0);
//         // print(today);
//         finalmothTotalWorkingTime = today
//             .add(Duration(hours: finalMonthHours, minutes: finalMonthMinutes))
//             .toString()
//             .substring(8, 19);
//
//         _auth.once().then((value) => {
//           for (var element in value.snapshot.children)
//             {
//               fbData = element.value,
//               if (fbData["email"] == user?.email)
//                 {
//                   wrkDone = element.key,
//                   _auth
//                       .child(wrkDone)
//                       .child(
//                       "workManager/timeSheet/$formattedYear/$formattedMonth/totalWorkingTime")
//                       .set({'month': finalmothTotalWorkingTime})
//                 }
//             }
//         }).then((value) {
//           finalMonthHours = 0;
//           finalMonthMinutes = 0;
//
//           monthWrkTimingList.clear();
//           monthTimeList.clear();
//         });
//       }
//
//     }
//
//
//   }
//
//   List yearWrkTimeList = [];
//   var fbywt;
//   getYearWorkingTime(){
//     _auth.once().then((value) {
//       for (var step1 in value.snapshot.children) {
//         fbData = step1.value;
//         if (fbData['email'] == CurrerntUser) {
//           for (var step2 in step1.children) {
//             if (step2.key == "workManager") {
//               for (var step3 in step2.children) {
//                 for (var step4 in step3.children) {
//                   if (step4.key == formattedYear) {
//                     for(var ywt in step4.children){
//                       for(var ywt2 in ywt.children){
//                         if(ywt2.key != 'totalWorkingTime'){
//                           for (var ywt3 in ywt2.children){
//                             if(ywt3.key != 'totalWorkingTime'){
//                               // print(ywt3.value);
//                               fbywt = ywt3.value;
//                               setState(() {
//                                 yearWrkTimeList.add(fbywt['time_in_hours']);
//                                 print("${yearWrkTimeList}.........Get year");
//                               });
//
//                             }
//                           }
//                         }
//
//                       }
//                     }
//                   }
//                 }
//               }
//             }
//           }
//         }
//       }
//     }).then((value) {uploadYearWorkTime();});
//   }
//
//   int yearHours = 0;
//   int finalYearHours = 0;
//
//   int yearMinutes = 0;
//   int finalYearMinutes = 0;
//   var finalYearTotalWorkingTime;
//
//   uploadYearWorkTime(){
//     print("${yearWrkTimeList}year work time list in upload side");
//     List yearTimeList = yearWrkTimeList;
//
//     for (var time in yearTimeList) {
//
//       var format = time;
//       print("${format}..............format in time");
//
//       if(format != null){
//         var timeFormat = DateFormat("HH:mm");
//         var starTime = timeFormat.parse(format).toString().substring(10, 19);
//
//         var hours = starTime.substring(0, 3);
//
//         var minutes = starTime.substring(4, 6);
//
//         yearHours = int.parse(hours);
//         var addTime = finalYearHours + yearHours;
//         finalYearHours = addTime;
//
//         yearMinutes = int.parse(minutes);
//         var addMinutes = finalYearMinutes + yearMinutes;
//         finalYearMinutes = addMinutes;
//         // print(finalTestingMinutes);
//
//         var today = DateTime.utc(0);
//         // print(today);
//         finalYearTotalWorkingTime = today
//             .add(Duration(hours: finalYearHours, minutes: finalYearMinutes))
//             .toString()
//             .substring(8, 19);
//
//         _auth.once().then((value) => {
//           for (var element in value.snapshot.children)
//             {
//               fbData = element.value,
//               if (fbData["email"] == user?.email)
//                 {
//                   wrkDone = element.key,
//                   _auth
//                       .child(wrkDone)
//                       .child(
//                       "workManager/timeSheet/$formattedYear/totalWorkingTime")
//                       .set({'year': finalYearTotalWorkingTime})
//                 }
//             }
//         }).then((value) {
//           finalYearHours = 0;
//           finalYearMinutes = 0;
//           yearWrkTimeList.clear();
//           yearTimeList.clear();
//           print('Year Working time uploaded successfully');
//         });
//       }
//
//     }
//
//   }

  // var a;

  // getStringValuesSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return String
  //   String? stringValue = prefs.getString('stringValue');
  //   print(stringValue);
  //   a = stringValue.toString();
  //   return a;
  //
  // }

  String? nowUser;
  var userName;
  var dep;
  bool fingerPrintStatus = false;

  getFingerPrint() {
    fingerPrint
        .child(user!.uid)
        .once()
        .then((value) => {
              // print(value.snapshot.value),
              for (var f1 in value.snapshot.children)
                {
                  // print(f1.key),
                  if (f1.key == formattedDate)
                    {
                      setState(() {
                        fingerPrintStatus = true;
                        // print(fingerPrintStatus);
                      }),
                    }
                }
            })
        .then((value) => loadData());
  }



  loadData() {
    staff.child(user!.uid).once().then((value) => {
          // print(value.snapshot.value),
          fbData = value.snapshot.value,
          if (fbData["email"] == nowUser)
            {
              // // print(fbData),
              setState(() {
                userName = fbData['name'];
                dep = fbData['department'];
                // print(userName);
                // print(dep);
              }),
            }
        });
  }

  @override
  void initState() {
    todayDate();
    getYesterdayDate();
    setState(() {
      getFingerPrint();
      _tabController = TabController(length: 2, vsync: this);
      viewPendingWrk();
      CurrerntUser = user?.email;
      nowUser = user?.email;
      viewData();
    });
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final GlobalKey<SlideActionState> _key = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      drawer: const ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(60), bottomRight: Radius.circular(60)),
        child: Drawer(
          child: NavigationDrawer(),
        ),
      ),
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
                  color: Color(0xff21222D),
                  // gradient: LinearGradient(
                  //     colors: [
                  //       Colors.orangeAccent.withOpacity(0.9),
                  //       Colors.orangeAccent.withOpacity(0.9),
                  //     ],
                  //     stops: [
                  //       0.0,
                  //       11.0
                  //     ],
                  //     begin: FractionalOffset.topLeft,
                  //     end: FractionalOffset.bottomRight,
                  //     tileMode: TileMode.repeated,
                  // ),
                ),
                child: Stack(
                  children: [
                    // Positioned(
                    //     top: height * 0.033,
                    //     right: width * 0.01,
                    //     // left: width*0.3,
                    //     child: Image.asset(
                    //       'assets/website-maintenance.png',
                    //       scale: 15.0,
                    //     )),
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
                      top: height * 0.045,
                      right: width * 0.05,
                      left: width * 0.05,
                      child: Center(
                        child: Text(
                          'Update your works',
                          style: TextStyle(
                              fontSize: height * 0.025,
                              color: Colors.white,
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
              top: height * 0.08,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                // height: height*0.1,
                // decoration: BoxDecoration(
                //   // color: Color(0xffF7F9FC),
                //   borderRadius: BorderRadius.only(
                //     topRight: Radius.circular(30),
                //     topLeft: Radius.circular(30),
                //   ),
                // ),
                child: Column(
                  children: [
                    // ElevatedButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         getFingerPrint();
                    //       });
                    //     },
                    //     child: Text('print')),
                    Neumorphic(
                      margin: EdgeInsets.only(top: 35),
                      style: NeumorphicStyle(
                        depth: -2,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.all(Radius.circular(10))),
                        shadowDarkColorEmboss: Colors.white38,
                        shadowLightColorEmboss: Colors.black,
                        color: Color(0xff21222D),
                      ),
                      child: Container(
                        height: 65,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            // color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: TabBar(
                          controller: _tabController,
                          physics: BouncingScrollPhysics(),
                          indicator: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(10.0)),
                          labelColor: Color(0xffFFFFFF),
                          unselectedLabelColor: Colors.black,
                          automaticIndicatorColorAdjustment: true,
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: "Avenir"),
                          tabs: [
                            Tab(
                              icon: Icon(Icons.incomplete_circle_outlined,
                                  color: Colors.black),
                              text: 'Working On',
                            ),
                            Tab(
                              icon: Icon(Icons.laptop_mac, color: Colors.black),
                              text: 'Completed Works',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: fingerPrintStatus == true //true
                          ? yesterdayPendingWork == false
                              ? TabBarView(
                                  physics: BouncingScrollPhysics(),
                                  controller: _tabController,
                                  children: [
                                    /// First Screen.......
                                    firstScreen(height, width, _key),

                                    /// Second Screen.......
                                    secondScreen(height, width),
                                  ],
                                )
                              : Center(
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Oops...!\n',
                                            style: TextStyle(
                                                color: Color(0xffF7F9FC),
                                                fontFamily: "Avenir",
                                                fontSize: height * 0.04,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextSpan(
                                            text: "can't close they last work",
                                            style: TextStyle(
                                                color: Color(0xffF7F9FC),
                                                fontFamily: "Avenir",
                                                fontSize: height * 0.03,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )),
                                )
                          : Center(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Oops...!\n',
                                        style: TextStyle(
                                            color: Color(0xffF7F9FC),
                                            fontFamily: "Avenir",
                                            fontSize: height * 0.04,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: 'ID not recognized !',
                                        style: TextStyle(
                                            color: Color(0xffF7F9FC),
                                            fontFamily: "Avenir",
                                            fontSize: height * 0.03,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )),
                            ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget secondScreen(double height, double width) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.03),
      child: Center(
        child: Column(
          children: [
            Center(
              child: Text(
                "Work History",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: "Nexa",
                  fontSize: height * 0.02,
                  color: Color(0xffF7F9FC),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              indent: 100,
              endIndent: 100,
              height: 4,
              color: Color(0xffF7F9FC),
            ),
            workHistoryContainer(height, width),
          ],
        ),
      ),
    );
  }

  Widget firstScreen(
      double height, double width, GlobalKey<SlideActionState> _key) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          pendingWrkStatus == false
              ? pendingWorkFalseContainer(height, width, _key)
              : pendingWorkTrueContainer(height, width, _key),
        ],
      ),
    );
  }

  Widget workHistoryContainer(double height, double width) {
    return Neumorphic(
      margin: EdgeInsets.only(
          top: height * 0.055, left: width * 0.0, right: width * 0.0),
      style: NeumorphicStyle(
        depth: -1,
        boxShape:
            NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(10))),
        shadowDarkColorEmboss: Colors.white38,
        shadowLightColorEmboss: Colors.black,
        color: Color(0xff21222D),
      ),
      child: Container(
        width: width * 0.9,
        height: height * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // color: Color(0xffF7F9FC),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.3,
              // color: Colors.grey,
              child: SingleChildScrollView(
                child: nameView.length == 0
                    ? Center(
                        child: Text(
                          "Complete your works",
                          style: TextStyle(
                              color: Color(0xffF7F9FC),
                              fontFamily: "Nexa",
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : buildGridView(height, width),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pendingWorkTrueContainer(
      double height, double width, GlobalKey<SlideActionState> _key) {
    return Container(
      height: height * 0.7,
      // color: Colors.red,
      margin: EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          Positioned(
            child: Neumorphic(
              margin: EdgeInsets.only(top: 5),
              style: NeumorphicStyle(
                depth: -1,
                boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.all(Radius.circular(10))),
                shadowDarkColorEmboss: Color(0xffF7F9FC),
                shadowLightColorEmboss: Colors.black,
                color: const Color(0xff21222D),
              ),
              child: Container(
                height: height * 0.50,
                width: width * 0.95,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tempWrk.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 30,
                            childAspectRatio: 3.0 / 1.0,
                          ),
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              // color:Colors.blue,
                              child: Center(
                                  child: Text(
                                "Start Time :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.w900),
                              )),
                            ),
                            Center(
                              child: Text(
                                '${temFromTime[index]}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Nexa",
                                    fontSize: height * 0.02),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Now Working  :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              height: height * 0.15,
                              width: width * 0.5,
                              // decoration: BoxDecoration(
                              //   borderRadius:
                              //   BorderRadius.circular(10),
                              //   color: const Color(0xffF7F9FC),
                              //   boxShadow: const [
                              //     BoxShadow(
                              //       color: Colors.black26,
                              //       offset: Offset(9.0, 9.0),
                              //       blurRadius: 9,
                              //     ),
                              //     BoxShadow(
                              //       color: Colors.white,
                              //       offset: Offset(-1.0, -8.0),
                              //       blurRadius: 10,
                              //     ),
                              //   ],
                              // ),

                              child: SingleChildScrollView(
                                child: Center(
                                  child: Text('${tempWrk[index]}',
                                      style: TextStyle(
                                          fontFamily: 'Avenir',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.white),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                physics: BouncingScrollPhysics(),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Add Works:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            Center(
                              child: AnimatedButton(
                                // width: width*0.9,
                                text: 'Press to Add',
                                // color: Colors.transparent,
                                color: Colors.white.withOpacity(0.4),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                buttonTextStyle: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),

                                pressEvent: () {
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.bottomSlide,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.info,
                                    // customHeader: Image.asset(
                                    //   'assets/casual-life-3d-girl-with-tablet-and-working-process-on-desktop.png',
                                    //   scale: 5.0,
                                    // ),
                                    showCloseIcon: true,
                                    body: TextFormField(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Avenir"),
                                      controller: workDoneField2,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        // fillColor: const Color(0xffFBF8FF),
                                        hintStyle: const TextStyle(
                                            fontFamily: 'Nexa',
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16,
                                            color: Colors.black54
                                            // (0xffFBF8FF)
                                            ),
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                        hintText: '       Percent of Completed',
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Enter value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    btnOkColor: Colors.black87,
                                    btnOkText: 'Done',
                                    buttonsTextStyle: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: "Nexa"),
                                    btnOkOnPress: () {
                                      setState(() {
                                        debugPrint(
                                            percentField.text.toString());
                                        if (percentField.text.isNotEmpty) {
                                          setState(() {
                                            // slider = true;
                                          });
                                        } else {
                                          setState(() {
                                            // slider = false;
                                          });
                                        }

                                        // percentField.clear();
                                      });
                                    },
                                    onDismissCallback: (type) {
                                      debugPrint(
                                          'Dialog Dissmiss from callback $type');
                                    },
                                  ).show();
                                },
                              ),
                            ),
                            Center(
                              child: Text(
                                "Work Percent  :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: height * 0.001),
                              width: width * 0.2,
                              height: height * 0.04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.4),
                                // color: Colors.orangeAccent,
                                // Colors.white.withOpacity(0.3),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors
                                //         .black26,
                                //     offset: Offset(
                                //         9.0, 9.0),
                                //     blurRadius: 9,
                                //   ),
                                // ],
                              ),
                              child: Center(
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  style: const TextStyle(
                                      color: Colors.white, fontFamily: "Nexa"),
                                  controller: percentField,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xff21222D),
                                        fontFamily: 'Nexa',
                                        fontSize: 15),
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText: 'Work Percent',
                                    filled: true,
                                    // fillColor:
                                    // const Color(
                                    //     0xffFBF8FF),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      var end = DateTime.now();
                                      endTime = DateFormat('HH:mm').format(end);
                                      isStarted = !isStarted;
                                      isSubmit = true;
                                      // print(
                                      //     "End Time Pressed..............${endTime}");
                                    });
                                  },
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return 'Enter value';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          // Positioned(
          //     top: 3,
          //     right: 100,
          //     left: 100,
          //     child: Container(
          //       height: height * 0.05,
          //       width: width * 0.5,
          //       decoration: BoxDecoration(
          //           borderRadius:
          //               BorderRadius
          //                   .circular(30),
          //           color: Colors.white),
          //       child: Center(
          //         child: Text(
          //           "Currently work On",
          //           style: TextStyle(
          //               fontFamily:
          //                   'Avenir',
          //               fontWeight:
          //                   FontWeight
          //                       .bold,
          //               fontSize: 18,
          //               color:
          //                   Colors.black),
          //         ),
          //       ),
          //     )),
          Positioned(
            top: height * 0.55,
            left: width * 0.15,
            right: width * 0.15,
            child: SizedBox(
              child: isSubmit == true
                  ? SizedBox(
                      height: height * 0.07,
                      width: width * 0.6,
                      child: SlideAction(
                        sliderButtonIconSize: height * 0.015,
                        key: _key,
                        child: Text(
                          "Slide to Submit",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nexa",
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                        ),
                        innerColor: Colors.orangeAccent,
                        outerColor: Color(0xffF7F9FC),
                        animationDuration: Duration(milliseconds: 500),
                        onSubmit: () {
                          setState(() {
                            // print(temFromTime); 
                            getFbTime = temFromTime[0];
                            // print(getFbTime);

                            String st = getFbTime.trim().replaceAll(RegExp(r'[^0-9]'), ':');
                            String so = endTime.trim().replaceAll(RegExp(r'[^0-9]'), ':');
                            //
                            String start_time = st.toString(); // or if '24:00'
                            String end_time = so.toString(); // or if '12:00

                            var format = DateFormat("HH:mm");
                            var start = format.parse(start_time);
                            var end = format.parse(end_time);

                            if (end.isAfter(start)) {
                              timeDifference = end.difference(start);
                              timeDifference = timeDifference.toString().substring(0, 7);
                            }
                            // print(timeDiffrence);

                            // pendingWrks();
                            final isValid = formKey.currentState?.validate();
                            if (isValid!) {
                              // print('hi iam working');
                              createWrkDone();
                              pendingWrkStatus = false;
                              isSubmit = false;
                            }

                            // print('hey I am Working');
                          });
                        },
                      ),
                    )
                  : Text(''),
            ),
          ),
        ],
      ),
    );
  }

  Widget pendingWorkFalseContainer(
      double height, double width, GlobalKey<SlideActionState> _key) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(50),
          height: height * 0.15,
          width: width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffF7F9FC),
            // Colors.white.withOpacity(0.3),
            boxShadow: [
              BoxShadow(
                color: Colors.white12,
                offset: Offset(9.0, 9.0),
                blurRadius: 9,
              ),
              BoxShadow(
                color: Colors.black12,
                offset: Offset(-10.0, -10.0),
                blurRadius: 15,
              ),
            ],
          ),
          child: Center(
            child: TextFormField(
              style: const TextStyle(color: Colors.black, fontFamily: "Avenir"),
              controller: workDoneField,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                fillColor: const Color(0xffFBF8FF),
                hintStyle: const TextStyle(
                    // fontFamily: 'Avenir',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: Colors.black54
                    // (0xffFBF8FF)
                    ),
                contentPadding: const EdgeInsets.all(20),
                hintText: 'Enter your Work',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Enter value';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        SizedBox(
          height: height * 0.07,
          width: width * 0.6,
          child: SlideAction(
            sliderButtonIconSize: height * 0.015,
            key: _key,
            child: const Text("Slide to Start",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Nexa",
                    fontSize: 15,
                    fontWeight: FontWeight.w800)),
            innerColor: Colors.orangeAccent,
            outerColor: Color(0xffF7F9FC),
            animationDuration: Duration(milliseconds: 800),
            submittedIcon: Icon(
              Icons.done_all,
              color: Colors.blue,
            ),
            onSubmit: () {
              setState(() {
                var start = DateTime.now();
                startTime = DateFormat('HH:mm').format(start);
                // isStarted = !isStarted;
                final isValid = formKey.currentState?.validate();
                if (isValid!) {
                  pendingWorks();
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildGridView(double height, double width) {
      return GridView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3 / 1.3,
          ),
          itemCount: nameView.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            padding: EdgeInsets.only(right: width * 0.05, left: width * 0.05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    subTitle("[ ${fromView[index]}"),
                    subTitle("To"),
                    subTitle("${toView[index]}]"),
                    subTitle("${workPercentageView[index]}"),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: LinearPercentIndicator(
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: height * 0.01,
                    percent: percent = double.parse(workPercentageView[index]
                            .replaceAll(RegExp(r'.$'), "")) /
                        100,
                    backgroundColor: Colors.black12,
                    progressColor: Colors.orangeAccent,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: Text(
                    '${workDoneView[index]}',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Color(0xffF7F9FC),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: height * 0.05,
                // )
              ],
            ),
          );
        });
  }

  Widget subTitle(String name) => Text(
        name,
        style: const TextStyle(
          fontFamily: 'Avenir',
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color(0xffF7F9FC),
        ),
      );
}
