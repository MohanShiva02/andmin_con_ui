import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'Drawer.dart';

class Refreshment extends StatefulWidget {
  const Refreshment({Key? key}) : super(key: key);

  @override
  State<Refreshment> createState() => _RefreshmentState();
}

class _RefreshmentState extends State<Refreshment>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final staff = FirebaseDatabase.instance.ref().child("staff");
  final user = FirebaseAuth.instance.currentUser;
  final refreshments = FirebaseDatabase.instance.ref().child('refreshments');

  String? NowUser;
  var formattedTime;
  var formattedDate;
  var formattedMonth;
  var formattedYear;
  var timeZone;

  var staffName;
  var fbData;
  List userEmail = [];

  readName() {
    staff.once().then((value) {
      for (var element in value.snapshot.children) {
        // // print(element.value);
        fbData = element.value;
        // setState(() {
        //   userEmail.add(fbData['email']);
        // //   // print(user?.email);
        // });
        if (user?.email == fbData['email']) {
          setState(() {
            fbData.toString();
            staffName = fbData['name'];
            // // print(staffName);
          });
        }
      }
    });
  }

  todayDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyy-MM-dd');
    var formatterYear = DateFormat('yyy');
    var formatterMonth = DateFormat('MM');
    formattedTime = DateFormat('HH:MM:a').format(now);
    formattedDate = formatterDate.format(now);
    formattedYear = formatterYear.format(now);
    formattedMonth = formatterMonth.format(now);

    var s = formattedTime.toString().substring(6, 8);
    // print(s);
    if (s == 'AM') {
      setState(() {
        timeZone = 'FN';
      });

      // // print(timeZone);
    } else {
      setState(() {
        timeZone = 'AN';
      });

      // // print(timeZone);
    }
    // print(timeZone);
    // print(formattedTime);
  }

  var teaCount;

  // var dummyTeaCount;
  var teaList;
  List listOfTea = [];

  loadTea() {
    listOfTea.clear();
    // print(listOfTea);
    refreshments.once().then((value) {
      for (var e1 in value.snapshot.children) {
        // // print(e1.key);
        if (e1.key == formattedDate) {
          for (var e2 in e1.children) {
            // print(timeZone);
            if (timeZone == "FN") {
              // print(timeZone);
              if (e2.key == 'FN') {
                // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'tea') {
                    // print(e3.value);
                    for (var e4 in e3.children) {
                      // // print(e4.value);
                      var t = e4.value;
                      // print(t);
                      setState(() {
                        listOfTea.add(t);
                        // print(listOfTea.length);
                        teaList = listOfTea.length;
                        // // print("teaList");
                        // // print("load  ${teaList}");
                      });
                    }
                  }
                }
              }
            } else {
              if (e2.key == 'AN') {
                // // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'tea') {
                    // // print(e3.value);
                    for (var e4 in e3.children) {
                      // // print(e4.value);
                      var t = e4.value;
                      // // print(t);
                      setState(() {
                        listOfTea.add(t);
                        // // print(listOfTea.length);
                        teaList = listOfTea.length;
                        // print("teaList");
                        // // print("load  ${teaList}");
                      });
                    }
                  }
                }
              }
            }
          }
        }
      }
    }).then((value) {
      setState(() {
        teaList == null ? teaList = 1 : teaList++;

        drinkCountTeaDetails();
      });
    });
  }

  drinkCountTeaDetails() {
    // print(' drink count${teaList}');
    refreshments
        .child('${formattedDate.toString().trim()}/${timeZone}/tea')
        .update({
      'name${teaList}': staffName.toString().trim(),
    }).then((value) => {
              updateTeaCount(),
              // loadTea(),
              listOfTea.clear()
            });
  }

  updateTeaCount() {
    refreshments
        .child('${formattedDate.toString().trim()}/${timeZone}')
        .update({
      'tea_count': teaList,
    }).then((value) {
      final snackBar = SnackBar(content: Text("Successfully Submitted Tea"));
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
      Navigator.pop(context);
    });
  }

  var coffeeCount;
  var dummyCoffeeCount;
  var coffeeList;
  List listOfCoffee = [];

  loadCoffee() {
    listOfCoffee.clear();
    // // print(listOfCoffee);
    refreshments.once().then((value) {
      for (var e1 in value.snapshot.children) {
        // // print(e1.key);
        if (e1.key == formattedDate) {
          for (var e2 in e1.children) {
            if (timeZone == "FN") {
              if (e2.key == 'FN') {
                // // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'coffee') {
                    // // print(e3.value);
                    for (var e4 in e3.children) {
                      // // print(e4.value);
                      var c = e4.value;
                      // // print(t);
                      setState(() {
                        listOfCoffee.add(c);
                        // // print(listOfTea.length);
                        coffeeList = listOfCoffee.length;
                        // // print("load  ${teaList}");
                      });
                    }
                  }
                }
              }
            } else {
              if (e2.key == 'AN') {
                // // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'coffee') {
                    // // print(e3.value);
                    for (var e4 in e3.children) {
                      // // print(e4.value);
                      var c = e4.value;
                      // // print(t);
                      setState(() {
                        listOfCoffee.add(c);
                        // // print(listOfTea.length);
                        coffeeList = listOfCoffee.length;

                        // // print("load  ${teaList}");
                      });
                    }
                  }
                }
              }
            }
          }
        }
      }
    }).then((value) {
      setState(() {
        coffeeList == null ? coffeeList = 1 : coffeeList++;
        drinkCountCoffee();
      });
    });
  }

  drinkCountCoffee() {
    refreshments
        .child('${formattedDate.toString().trim()}/${timeZone}/coffee')
        .update({
      'name$coffeeList': staffName.toString().trim(),
    }).then((value) => {updateCoffeeCount(), listOfCoffee.clear()});
  }

  updateCoffeeCount() {
    refreshments
        .child('${formattedDate.toString().trim()}/${timeZone}')
        .update({
      'coffee_count': coffeeList,
    }).then((value) {
      final snackBar = SnackBar(content: Text("Successfully Submitted Coffee"));
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
      Navigator.pop(context);
    });
  }

  var nothingCount;
  var dummyNothingCount;
  var nothingList;
  List listOfNothing = [];

  loadNothing() {
    listOfNothing.clear();
    // print(listOfNothing);
    refreshments.once().then((value) {
      for (var e1 in value.snapshot.children) {
        // // print(e1.key);
        if (e1.key == formattedDate) {
          for (var e2 in e1.children) {
            if (timeZone == "FN") {
              if (e2.key == 'FN') {
                // // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'nothing') {
                    // // print(e3.value);
                    for (var e4 in e3.children) {
                      // // print(e4.value);
                      var n = e4.value;
                      // // print(t);
                      setState(() {
                        listOfNothing.add(n);
                        // // print(listOfTea.length);
                        nothingList = listOfNothing.length;
                      });
                    }
                  }
                }
              }
            } else {
              if (e2.key == 'AN') {
                // // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'nothing') {
                    // // print(e3.value);
                    for (var e4 in e3.children) {
                      // // print(e4.value);
                      var n = e4.value;
                      // // print(t);
                      setState(() {
                        listOfNothing.add(n);
                        nothingList = listOfNothing.length;
                      });
                    }
                  }
                }
              }
            }
          }
        }
      }
    }).then((value) {
      setState(() {
        nothingList == null ? nothingList = 1 : nothingList++;
        // // print("${nothingList}////////////////////////");
        drinkCountNothing();
      });
    });
  }

  drinkCountNothing() {
    refreshments
        .child('${formattedDate.toString().trim()}/${timeZone}/nothing')
        .update({
      'name$nothingList': staffName.toString().trim(),
    }).then((value) => {updateNothingCount(), listOfNothing.clear()});
  }

  updateNothingCount() {
    refreshments
        .child('${formattedDate.toString().trim()}/${timeZone}')
        .update({
      'nothing_count': nothingList,
    }).then((value) {
      final snackBar = SnackBar(content: Text("Successfully Submitted "));
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
      Navigator.pop(context);
    });
  }

  //
  // var foodCount;
  // var dummyFoodCount;
  // var foodList;
  // List listOfFood = [];
  //
  // loadFood() {
  //   listOfFood.clear();
  //   // // print(listOfFood);
  //   refreshments.once().then((value) {
  //     for (var e1 in value.snapshot.children) {
  //       // // print(e1.key);
  //       if (e1.key == formattedDate) {
  //         for (var e2 in e1.children) {
  //           if (e2.key == 'food') {
  //             // // print(e3.value);
  //             for (var e4 in e2.children) {
  //               // // print(e4.value);
  //               var c = e4.value;
  //               // // print(t);
  //               setState(() {
  //                 listOfFood.add(c);
  //                 // // print(listOfFood.length);
  //                 foodList = listOfFood.length;
  //                 // // print("load  ${foodList}");
  //               });
  //             }
  //           }
  //         }
  //       }
  //     }
  //     // else {
  //     //   if (e2.key == 'AN') {
  //     //     // // print(e2.value);
  //     //     for (var e3 in e2.children) {
  //     //       if (e3.key == 'coffee') {
  //     //         // // print(e3.value);
  //     //         for(var e4 in e3.children){
  //     //           // // print(e4.value);
  //     //           var t = e4.value;
  //     //           // // print(t);
  //     //           setState(() {
  //     //             listOfCoffee.add(t);
  //     //             // // print(listOfTea.length);
  //     //             coffeeList = listOfCoffee.length;
  //     //
  //     //             // // print("load  ${teaList}");
  //     //           });
  //     //         }
  //     //
  //     //       }
  //     //     }
  //     //   }
  //     // }
  //   }).then((value) {
  //     setState(() {
  //       foodList == null ? foodList = 1 : foodList++;
  //       CountFood();
  //     });
  //   });
  // }
  //
  // CountFood() {
  //   refreshments.child('${formattedDate.toString().trim()}/food').update({
  //     'name$foodList': staffName.toString().trim(),
  //   }).then((value) => {
  //         updateFoodCount(),
  //         listOfFood.clear(),
  //       });
  // }
  //
  // updateFoodCount() {
  //   refreshments.child('${formattedDate.toString().trim()}').update({
  //     'food_count': foodList,
  //   }).then((value) {
  //     final snackBar =
  //         SnackBar(content: Text("Successfully Submitted your Food"));
  //     ScaffoldMessenger.of(context)
  //       ..hideCurrentMaterialBanner()
  //       ..showSnackBar(snackBar);
  //     Navigator.pop(context);
  //   });
  // }

  var countOfFood;
  var countOfCoffee;
  var countOfTea;

  getCounts() {
    refreshments.once().then((value) {
      for (var v1 in value.snapshot.children) {
        // print(v1.key);
        if (v1.key == formattedDate) {
          for (var v2 in v1.children) {
            // print(v2.key);
            if (v2.key == 'food_count') {
              // print(v2.value);

              setState(() {
                countOfFood = v2.value;
              });
              // print('<<<<<<<<<<<${countOfFood.toString()}>>>>>>>>>>>>>');
            }
            ;
            if (timeZone == 'FN') {
              // print('hey good morning');
              if (v2.key == 'FN') {
                var a = v2.value;
                // print(a);
                for (var v3 in v2.children) {
                  // print(v3.key);
                  if (v3.key == 'tea_count') {
                    // print(v3.value);
                    var tea = v3.value;
                    setState(() {
                      countOfTea = tea;
                      print('<<<<<<<<<<<${countOfTea.toString()}>>>>>>>>>>>>>');
                    });
                  }
                  ;
                  if (v3.key == 'coffee_count') {
                    // print(v3.value);
                    var coffee = v3.value;
                    setState(() {
                      countOfCoffee = coffee;
                      // print('<<<<<<<<<<<${countOfCoffee.toString()}>>>>>>>>>>>>>');
                    });
                  }
                }
              }
            } else {
              // print('hey good afternoon');
              if (v2.key == 'AN') {
                var a = v2.value;
                // print(a);
                for (var v3 in v2.children) {
                  // print(v3.key);
                  if (v3.key == 'tea_count') {
                    // print(v3.value);
                    var tea = v3.value;
                    setState(() {
                      countOfTea = tea;
                      print('<<<<<<<<<<<${countOfTea.toString()}>>>>>>>>>>>>>');
                    });
                  }
                  ;
                  if (v3.key == 'coffee_count') {
                    // print(v3.value);
                    var coffee = v3.value;
                    setState(() {
                      countOfCoffee = coffee;
                      // print('<<<<<<<<<<<${countOfCoffee.toString()}>>>>>>>>>>>>>');
                    });
                  }
                }
              }
            }
          }
        }
      }
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    todayDate();
    readName();
    NowUser = user?.email;
    getCounts();
    // loadCoffee();
    // loadTea();
    // loadNothing();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff21222D),
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
            top: height * -0.50,
            right: width * -0.0,
            left: width * -0.80,
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
                      top: height * 0.6,
                      right: width * -0.80,
                      left: width * 0.0,
                      child: Center(
                          // child: Text(" Welcome Back",
                          //     style: TextStyle(
                          //       color: Color(0xffF7F9FC),
                          //         fontFamily: 'Nexa',
                          //         fontSize: height * 0.03,
                          //         fontWeight: FontWeight.w900)),
                          )),
                ],
              ),
            ),
          ),
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
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Colors.orangeAccent.withOpacity(0.9),
                  //     Colors.orangeAccent.withOpacity(0.9),
                  //   ],
                  //   // stops: [
                  //   //   0.0,
                  //   //   11.0,
                  //   // ],
                  //   begin: FractionalOffset.centerLeft,
                  //   end: FractionalOffset.centerRight,
                  //   // tileMode: TileMode.repeated,
                  // ),
                  ),
              child: Stack(
                children: [
                  // Positioned(
                  //   top: height * 0.05,
                  //   right: width * 0.0,
                  //   // left: width*0.3,
                  //   child: Image.asset(
                  //     'assets/business-team-doing-creative-brainstorming.png',
                  //     scale: 13.0,
                  //   ),
                  // ),
                  Positioned(
                    top: height * 0.03,
                    left: width * 0.0,
                    // right: 30,
                    child: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          _scaffoldKey.currentState?.openDrawer();
                        });
                      },
                      iconSize: height * 0.04,
                      icon: Icon(Icons.menu),
                    ),
                  ),
                  // Positioned(
                  //   top: height * 0.18,
                  //   // right: 0,
                  //   left: width * 0.04,
                  //   child: Center(
                  //     child: Center(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Center(
                  //           child: Text(
                  //             'Choose your drink...',
                  //             style: TextStyle(
                  //                 fontSize: height * 0.03,
                  //                 color: Color(0xffffffff).withOpacity(1.0),
                  //                 fontFamily: "Nexa",
                  //                 fontWeight: FontWeight.w900),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.25,
            left: 0,
            right: 0,
            bottom: 0,
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: -2,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
                shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
                shadowLightColorEmboss: Colors.black,
                color: Color(0xff21222D),
              ),
              child: Container(
                width: double.infinity,
                // height: height*0.1,
                decoration: BoxDecoration(
                  // color: Color(0xffF7F9FC),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 35),
                      height: 65,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          color: Color(0xff21222D),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: TabBar(
                        controller: _tabController,
                        physics: BouncingScrollPhysics(),
                        indicator: BoxDecoration(
                            color: Colors.orange.shade500,
                            borderRadius: BorderRadius.circular(10.0)),
                        labelColor: Color(0xffFFFFFF),
                        unselectedLabelColor: Colors.black,
                        automaticIndicatorColorAdjustment: true,
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w800, fontFamily: "Avenir"),
                        tabs: [
                          Tab(

                            text: 'Admin Room',
                          ),
                          Tab(

                            text: 'Hall',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),
                        controller: _tabController,
                        children: [
                          /// First Screen...................................
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                ///TEA........................
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      loadTea();
                                      // // print(".....................${teaList.runtimeType}");
                                      // teaList == null
                                      //     ? teaList = 1
                                      //     : teaList++;
                                      // // print("${teaList}////////////////////////");
                                      // drinkCountTeaDetails();
                                    });
                                  },
                                  child: Neumorphic(
                                    margin: EdgeInsets.all(10),
                                    style: NeumorphicStyle(
                                      depth: -2,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.all(
                                              Radius.circular(20))),
                                      shadowDarkColorEmboss:
                                          Colors.white.withOpacity(0.5),
                                      shadowLightColorEmboss: Colors.black,
                                      color: Color(0xff21222D),
                                    ),
                                    child: Container(
                                      height: height * 0.15,
                                      width: width * 0.4,
                                      decoration: BoxDecoration(
                                        color: Color(0xff21222D),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.mugHot,
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          Text(
                                            'Tea',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Nexa',
                                              fontSize: height * 0.02,
                                              color: Color(0xffF7F9FC),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                /// COFFEE....................
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      loadCoffee();
                                      // // print(".....................${coffeeList.runtimeType}");
                                      // coffeeList == null
                                      //     ? coffeeList = 1
                                      //     : coffeeList++;
                                      // // // print("${coffeeList}////////////////////////");
                                      // drinkCountCoffee();
                                    });
                                  },
                                  child: Neumorphic(
                                    margin: EdgeInsets.all(10),
                                    style: NeumorphicStyle(
                                      depth: -2,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.all(
                                              Radius.circular(20))),
                                      shadowDarkColorEmboss:
                                          Colors.white.withOpacity(0.5),
                                      shadowLightColorEmboss: Colors.black,
                                      color: Color(0xff21222D),
                                    ),
                                    child: Container(
                                      // margin: EdgeInsets.all(15),
                                      height: height * 0.15,
                                      width: width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.mugHot,
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          Text(
                                            'Coffee',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Avenir',
                                              fontSize: height * 0.02,
                                              color: Color(0xffF7F9FC),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                ///NOTHING....................
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      loadNothing();
                                      // // print(".....................${nothingList.runtimeType}");
                                      // nothingList == null
                                      //     ? nothingList = 1
                                      //     : nothingList++;
                                      // // // print("${nothingList}////////////////////////");
                                      // drinkCountNothing();
                                    });
                                  },
                                  child: Neumorphic(
                                    margin: EdgeInsets.all(10),
                                    style: NeumorphicStyle(
                                      depth: -2,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.all(
                                              Radius.circular(20))),
                                      shadowDarkColorEmboss:
                                          Colors.white.withOpacity(0.5),
                                      shadowLightColorEmboss: Colors.black,
                                      color: Color(0xff21222D),
                                    ),
                                    child: Container(
                                      height: height * 0.15,
                                      width: width * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.ban,
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          Text(
                                            'Nothing',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Avenir',
                                              fontSize: height * 0.02,
                                              color: Color(0xffF7F9FC),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///Second Screen...................................
                          Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ///FOOD.......................
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       loadFood();
                                  //       // // print(".....................${nothingList.runtimeType}");
                                  //       // nothingList == null
                                  //       //     ? nothingList = 1
                                  //       //     : nothingList++;
                                  //       // // // print("${nothingList}////////////////////////");
                                  //       // drinkCountNothing();
                                  //     });
                                  //   },
                                  //   child: Container(
                                  //     margin: EdgeInsets.all(10),
                                  //     height: height * 0.15,
                                  //     width: width * 0.4,
                                  //     decoration: BoxDecoration(
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //             color: Colors.black26,
                                  //             offset: Offset(-10, 10),
                                  //             blurRadius: 15,
                                  //             spreadRadius: 9),
                                  //         BoxShadow(
                                  //           color: Colors.white12,
                                  //           offset: Offset(4, 4),
                                  //           blurRadius: 10,
                                  //         ),
                                  //       ],
                                  //       borderRadius: BorderRadius.all(Radius.circular(20)),
                                  //       gradient: LinearGradient(
                                  //           colors: [
                                  //             Color(0xff26D0CE),
                                  //             Color(0xff1A2980),
                                  //           ],
                                  //           begin: FractionalOffset.topLeft,
                                  //           end: FractionalOffset.bottomRight,
                                  //           tileMode: TileMode.repeated),
                                  //     ),
                                  //     child: Column(
                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                  //       children: [
                                  //         Icon(
                                  //           FontAwesomeIcons.bowlFood,
                                  //         ),
                                  //         SizedBox(
                                  //           height: height * 0.02,
                                  //         ),
                                  //         Text(
                                  //           'Food',
                                  //           style: TextStyle(
                                  //             fontWeight: FontWeight.w900,
                                  //             fontFamily: 'Avenir',
                                  //             fontSize: height * 0.02,
                                  //             color: Color(0xffF7F9FC),
                                  //           ),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // ElevatedButton(onPressed: (){
                                  //   setState(() {
                                  //     getCounts();
                                  //   });
                                  // }, child: Text("print")),

                                  // buildContainer(height, width,
                                  //     '${countOfFood == null ? 'FOOD =  0' : 'FOOD =  ${countOfFood}'}'),
                                  buildContainer(height, width,
                                      '${countOfTea == null ? 'Tea =  0' : 'Tea =  ${countOfTea}'}'),
                                  buildContainer(height, width,
                                      '${countOfCoffee == null ? 'Coffee =  0' : 'Coffee =  ${countOfCoffee}'}'),

                                  // countOfFood == null ? Text('FOOD =  0'):Text('FOOD =  ${countOfFood}'),
                                  // countOfTea == null ? Text('TEA =  0'):Text('TEA =  ${countOfTea}'),
                                  // countOfCoffee == null ? Text('Coffee =  0'):Text('COFFEE =  ${countOfCoffee}'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildContainer(double height, double width, String name) {
    return Neumorphic(
      margin: EdgeInsets.all(15),
      style: NeumorphicStyle(
        depth: -3,
        boxShape:
            NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(20))),
        shadowDarkColorEmboss: Colors.white38,
        shadowLightColorEmboss: Colors.black,
        color: Color(0xffF7F9FC),
      ),
      child: Neumorphic(
        margin: EdgeInsets.all(10),
        style: NeumorphicStyle(
          depth: -2,
          boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.all(Radius.circular(30))),
          shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
          shadowLightColorEmboss: Colors.black,
          color: Color(0xff21222D),
        ),
        child: Container(
          height: height * 0.15,
          width: width * 0.55,
          decoration: BoxDecoration(
            // color: Colors.blue,
            // borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: TextStyle(fontSize: 20, color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}
