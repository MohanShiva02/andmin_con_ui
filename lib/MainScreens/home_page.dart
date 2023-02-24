import 'dart:async';
import 'package:andmin_con_ui/MainScreens/CEO/announcement_screen.dart';
import 'package:andmin_con_ui/MainScreens/PR/invoice/Screens/Customer_Details_Screen.dart';
import 'package:andmin_con_ui/MainScreens/PR/search_leads.dart';
import 'package:andmin_con_ui/MainScreens/PR/view_leads.dart';
import 'package:andmin_con_ui/MainScreens/refreshment.dart';
import 'package:andmin_con_ui/MainScreens/work_entry.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CEO/wrk_done_view.dart';
import 'CEO/wrk_not_entry.dart';
import 'Drawer.dart';
import 'PR/invoice/Screens/Company_Details_Screen.dart';
import 'PR/invoice/Screens/intro_Screen.dart';
import 'PR/invoice/Screens/splash_screen.dart';

class TeamMainPage extends StatefulWidget {
  const TeamMainPage({Key? key}) : super(key: key);

  @override
  State<TeamMainPage> createState() => _TeamMainPageState();
}

class _TeamMainPageState extends State<TeamMainPage> {
  final staff = FirebaseDatabase.instance.ref().child("staff");
  final fingerPrint = FirebaseDatabase.instance.ref().child("fingerPrint");
  final user = FirebaseAuth.instance.currentUser;

  TextEditingController reasonField = TextEditingController();

  String? formattedTime;
  var formattedDate;
  var formattedMonth;
  var formattedYear;

  todayDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyy-MM-dd');
    // var formatterYear = DateFormat('yyy');
    // var formatterMonth = DateFormat('MM');
    // formattedTime = DateFormat('HH:mm').format(now);
    formattedDate = formatterDate.format(now);
    // formattedYear = formatterYear.format(now);
    // formattedMonth = formatterMonth.format(now);
    // // print(formattedTime);
    // print(formattedDate);
  }

  String? nowUser;
  var fbData;
  var userName;
  var dep;
  bool fingerPrintStatus = false;

  var timeDifference;
  var saveTime;
  var punchTime;
  var defaultTime;
  var punchTime1;
  bool latePunch = false;
  bool id = false;

  getFingerPrint() {
    var a = TimeOfDay(
      hour: 09,
      minute: 00,
    );
    fingerPrint.child(user!.uid).once().then((value) => {
          // print(value.snapshot.value),
          for (var f1 in value.snapshot.children)
            {
              // print(f1.key),
              if (f1.key == formattedDate){
                for (var f2 in f1.children){
                      // print(f2.key),
                      saveTime = f2.value,
                      setState(() {
                        id = true;
                        var dummy = saveTime['Time'];

                        // print(dummy);
                        punchTime1 = dummy.toString();
                        punchTime = dummy.toString().substring(0, 5);
                        var defaultTime = a.toString().substring(10, 15);
                        // print(a);
                        // print('default Time  ${defaultTime} ---------punch Time   ${punchTime}');
                        fingerPrintStatus = true;
                        latePunch = true;

                        String st = defaultTime
                            .toString()
                            .trim()
                            .replaceAll(RegExp(r'[^0-9]'), ':');
                        String so =
                            punchTime.trim().replaceAll(RegExp(r'[^0-9]'), ':');

                        String start_time = st.toString(); // or if '24:00'
                        String end_time = so.toString(); // or if '12:00

                        var format = DateFormat("HH:mm");
                        var start = format.parse(start_time);
                        var end = format.parse(end_time);

                        if (end.isAfter(start)) {
                          timeDifference = end.difference(start);
                          timeDifference =
                              timeDifference.toString().substring(0, 4);
                        }
                        // print(timeDifference);

                        var finalTime = timeDifference
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', '')
                            .replaceAll(':', '');

                        // print(finalTime.runtimeType);

                        int timeOfDefault = int.parse('015');
                        int timeOffPunch = int.parse('020');

                        // print("timeOfDefault    ${timeOfDefault}");
                        // print('timeOffPunch     ${timeOffPunch}');

                        if (timeOfDefault <= timeOffPunch) {
                          // print('hii');
                          for (var f3 in f2.children) {
                            print(f3.key);
                            if (f3.key == 'reason') {
                              setState(() {
                                print('reason entered');
                                latePunch = false;
                                loadData();
                              });
                            } else {
                              setState(() {
                                print('no reason entered');
                                latePunch = true;
                                // loadData();
                              });
                            }
                          }
                        }
                      }),
                    },
                },
              // print(id),
            }
        });
  }

  loadData() {
    staff
        .child(user!.uid)
        .once()
        .then((value) => {
              // print(value.snapshot.value),
              fbData = value.snapshot.value,
              if (fbData["email"] == nowUser)
                {
                  // print(fbData),
                  setState(() {
                    userName = fbData['name'];
                    dep = fbData['department'];
                    // print(userName);
                    // print(dep);
                  }),
                }
            })
        .then((value) => init());
  }

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  String? name = '';
  String email = '';
  SharedPreferences? preferences;

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    preferences?.setString('name', '${userName}');
    preferences?.setString('email', '${nowUser}');
    preferences?.setString('department', '${dep}');
    String? names = preferences?.getString('name');
    setState(() {
      name = names!;
      // print(name);
    });
  }

  var res;
  createReason(){
    init();
    fingerPrint.once().then((value) {
     for(var e1 in value.snapshot.children){
       // print(e1.key);
       if(e1.key == user!.uid){
         res = e1.key;
  // print(res);
  // print(formattedDate);
  // print(punchTime1);
         fingerPrint.child("$res/$formattedDate/$punchTime1").update({
           'reason' : reasonField.text.toString(),
         });
       }
     }
    }).then((value) => getFingerPrint());
  }

  @override
  void initState() {
    init();
    todayDate();
    getFingerPrint();
    getConnectivity();
    nowUser = user?.email;
    // loadData();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
          /// top left
          Positioned(
            top: height * -0.45,
            right: width * 0.30,
            left: width * -0.90,
            child: Neumorphic(
              // margin: EdgeInsets.all(15),
              style: NeumorphicStyle(
                depth: -6,
                boxShape: NeumorphicBoxShape.circle(),
                shadowDarkColorEmboss: Colors.orange.withOpacity(0.7),
                // shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
                shadowLightColorEmboss: Color(0xff000000),
                // color: const Color(0xffF7F9FC),
                // color: Color(0xff21222D),
              ),
              child: Container(
                width: double.infinity,
                height: height * 0.7,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  // color: Colors.orange.shade400,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(250)),
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
                // child: Stack(
                //   children: [
                //     Positioned(
                //         top : height * 0.6,
                //         right: width * -0.80,
                //         left: width* 0.0,
                //         child: Center(
                //           // child: Text(" Welcome Back",
                //           //     style: TextStyle(
                //           //       color: Color(0xffF7F9FC),
                //           //         fontFamily: 'Nexa',
                //           //         fontSize: height * 0.03,
                //           //         fontWeight: FontWeight.w900)),
                //
                //         )),
                //   ],
                // ),
              ),
            ),
          ),

          /// bottom left
          Positioned(
            top: height * 0.25,
            right: width * 0.80,
            left: width * -0.20,
            child: Neumorphic(
              // margin: EdgeInsets.all(15),
              style: NeumorphicStyle(
                depth: -10,
                boxShape: NeumorphicBoxShape.circle(),
                shadowDarkColorEmboss: Colors.orange.withOpacity(0.7),
                // shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
                shadowLightColorEmboss: Color(0xff000000),
                // color: const Color(0xffF7F9FC),
                color: Color(0xff21222D),
              ),
              child: Container(
                width: double.infinity,
                height: height * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.orange.shade400,
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
                  gradient: LinearGradient(
                      colors: [Colors.orange.shade500, Colors.orangeAccent],
                      stops: [0.0, 11.0],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated),
                ),
              ),
            ),
          ),

          /// top right
          Positioned(
            top: height * 0.2,
            right: width * -0.30,
            left: width * 0.30,
            child: Neumorphic(
              // margin: EdgeInsets.all(15),
              style: NeumorphicStyle(
                depth: -5,
                boxShape: NeumorphicBoxShape.circle(),
                shadowDarkColorEmboss: Colors.orange.withOpacity(0.7),
                // shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
                shadowLightColorEmboss: Color(0xff000000),
                // color: const Color(0xffF7F9FC),
                color: Color(0xff21222D),
              ),
              child: Container(
                width: double.infinity,
                height: height * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.orange.shade400,
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
                  gradient: LinearGradient(
                      colors: [Colors.orange.shade500, Colors.orangeAccent],
                      stops: [0.0, 11.0],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated),
                ),
              ),
            ),
          ),

          ///bottom right
          Positioned(
            top: height * 0.85,
            right: width * -0.70,
            left: width * 0.50,
            child: Neumorphic(
              // margin: EdgeInsets.all(15),
              style: NeumorphicStyle(
                depth: -5,
                boxShape: NeumorphicBoxShape.circle(),
                shadowDarkColorEmboss: Color(0xff000000),
                // shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
                shadowLightColorEmboss: Color(0xff000000),
                // color: const Color(0xffF7F9FC),
                color: Color(0xff21222D),
              ),
              child: Container(
                width: double.infinity,
                height: height * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.orange.shade400,
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
                  gradient: LinearGradient(
                      colors: [Colors.orange.shade500, Colors.orangeAccent],
                      stops: [0.0, 11.0],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated),
                ),
              ),
            ),
          ),

          ///small
          Positioned(
            top: height * 0.85,
            right: width * 0.0,
            left: width * -0.30,
            child: Neumorphic(
              // margin: EdgeInsets.all(15),
              style: NeumorphicStyle(
                depth: -2,
                boxShape: NeumorphicBoxShape.circle(),
                shadowDarkColorEmboss: Colors.orange.withOpacity(0.7),
                // shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
                shadowLightColorEmboss: Color(0xff000000),
                // color: const Color(0xffF7F9FC),
                color: Color(0xff21222D),
              ),
              child: Container(
                width: double.infinity,
                height: height * 0.05,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.orange.shade400,
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade500,
                        Colors.orange,
                      ],
                      stops: [
                        0.0,
                        11.0
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      tileMode: TileMode.repeated),
                ),
              ),
            ),
          ),

          /// Containers
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: height * 0.0,
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
                  Positioned(
                    top: height * 0.10,
                    // right: 0,
                    left: width * 0.04,
                    child: Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Hiii.....\n',
                            style: TextStyle(
                              fontSize: height * 0.02,
                              color: Colors.black.withOpacity(1.0),
                              fontFamily: "Nexa",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: userName,
                            style: TextStyle(
                              fontSize: height * 0.03,
                              color: Colors.black.withOpacity(1.0),
                              fontFamily: "Nexa",
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          id == true
              ? latePunch == true
                  ? Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.18),
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: height * 0.05),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Oops...!\n',
                                          style: TextStyle(
                                              color: Color(0xffF7F9FC),
                                              fontFamily: "Avenir",
                                              fontSize: height * 0.035,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        TextSpan(
                                          text: "Reason for late punch",
                                          style: TextStyle(
                                              color: Color(0xffF7F9FC),
                                              fontFamily: "Avenir",
                                              fontSize: height * 0.03,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01,
                                      horizontal: width * 0.05),
                                  child: Container(
                                    // margin: EdgeInsets.only(top: 50),
                                    // width: width * 0.75,
                                    height: height * 0.09,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffF7F9FC),
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: reasonField,
                                        maxLines: 1,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                        textAlign: TextAlign.center,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ("Please enter reason");
                                          }
                                          // if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                          //   return ('Please Enter Valid Email');
                                          // }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          // email.text = value!;
                                        },
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: ""),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter Reason",
                                          hintStyle: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              fontFamily: 'Nexa',
                                              fontSize: height * 0.023),
                                        ),
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 0,
                                    top: height * 0.1,
                                    right: width * 0.05,
                                    left: width * 0.05),
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      createReason();
                                    });
                                  },
                                  child: Container(
                                    height: height * 0.07,
                                    // width: width * 0.75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Colors.orange,
                                          Colors.orangeAccent
                                        ],
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(-8, 8),
                                          blurRadius: 9,
                                          spreadRadius: 1,
                                        )
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Nexa",
                                          fontSize: height * 0.03,
                                          color: const Color(0xffFBF8FF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Positioned(
                      top: height * 0.26,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // color: Color(0xff252525),
                          // color:Colors.black
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
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dep == 'PR'
                                  ? GridView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        childAspectRatio: 2.5 / 1,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20,
                                      ),
                                      children: [
                                        //...........REFRESHMENT.....................
                                        Container(
                                          child: Buttons(
                                            "Refreshment",
                                            const Refreshment(),
                                            Icon(
                                              FontAwesomeIcons.mugHot,
                                              // Icons.refresh,
                                              size: height * 0.05,
                                              color: Color(0xffF7F9FC),
                                            ),
                                          ),
                                        ),
                                        //...........VIEW LEADS......................
                                        Container(
                                          child: Buttons(
                                            "View Leads",
                                            const ViewLeads(),
                                            Icon(
                                              FontAwesomeIcons.usersViewfinder,
                                              size: height * 0.05,
                                              color: Color(0xffF7F9FC),
                                            ),
                                          ),
                                        ),

                                        ///
                                        // ...........INVOICE.........................
                                        // Container(
                                        //   child: Buttons(
                                        //     "Invoice",
                                        //     CustomerDetails(),
                                        //     // CompanyDetails(),
                                        //     Icon(
                                        //       FontAwesomeIcons.fileInvoiceDollar,
                                        //       size: height * 0.05,
                                        //       color:Color(0xffF7F9FC),
                                        //     ),
                                        //   ),
                                        // ),
                                        ///
                                        // ...........WORK MANAGER....................
                                        Container(
                                          child: Buttons(
                                            "Work Manager",
                                            WorkEntry(),
                                            Icon(
                                              FontAwesomeIcons.briefcase,
                                              size: height * 0.05,
                                              color: Color(0xffF7F9FC),
                                            ),
                                          ),
                                        ),
                                        //...........SEARCH LEADS....................
                                        Container(
                                          child: Buttons(
                                            "Search Leads",
                                            SearchLeads(),
                                            Icon(
                                              FontAwesomeIcons.searchengin,
                                              size: height * 0.05,
                                              color: Color(0xffF7F9FC),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : dep == 'ADMIN'
                                      ? Container(
                                          height: height * 0.8,
                                          child: GridView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1,
                                              childAspectRatio: 2.5 / 1,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20,
                                            ),
                                            children: [
                                              //...........ANNOUNCEMENT....................
                                              Container(
                                                child: Buttons(
                                                  "Announcement",
                                                  const Announcement(),
                                                  Icon(
                                                    Icons.announcement_outlined,
                                                    size: height * 0.05,
                                                    color: Color(0xffF7F9FC),
                                                  ),
                                                ),
                                              ),
                                              //...........REFRESHMENT....................
                                              Container(
                                                child: Buttons(
                                                  "Refreshment",
                                                  const Refreshment(),
                                                  Icon(
                                                    FontAwesomeIcons.mugHot,
                                                    size: height * 0.05,
                                                    color: Color(0xffF7F9FC),
                                                  ),
                                                ),
                                              ),
                                              //...........WORK HISTORY....................
                                              Container(
                                                child: Buttons(
                                                  "Work Done",
                                                  const ViewWrkDone(),
                                                  Icon(
                                                    FontAwesomeIcons.briefcase,
                                                    size: height * 0.05,
                                                    color: Color(0xffF7F9FC),
                                                  ),
                                                ),
                                              ),
                                              //...........ABSENT DETAILS....................
                                              Container(
                                                child: Buttons(
                                                  "Absent Details",
                                                  const AbsentAndPresent(),
                                                  Icon(
                                                    Icons.work_off_outlined,
                                                    size: height * 0.05,
                                                    color: Color(0xffF7F9FC),
                                                  ),
                                                ),
                                              ),
                                              // Container(
                                              //   child: buttons(
                                              //       "New User",
                                              //       NewUser(),
                                              //       Icon(
                                              //         Icons.manage_accounts_outlined,
                                              //         size: height * 0.05,
                                              //         color:Color(0xffF7F9FC),
                                              //       )),
                                              // ),
                                              // Container(
                                              //   child: buttons(
                                              //       "View Leads",
                                              //       const ViewLeeds(),
                                              //       Icon(
                                              //         Icons.view_day,
                                              //         size: height * 0.05,
                                              //         color:Color(0xffF7F9FC),
                                              //       )),
                                              // ),
                                            ],
                                          ),
                                        )
                                      : dep == 'APP'
                                          ? GridView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                                childAspectRatio: 2.5 / 1,
                                                crossAxisSpacing: 20,
                                                mainAxisSpacing: 20,
                                              ),
                                              children: [
                                                //...........REFRESHMENT....................
                                                Container(
                                                  child: Buttons(
                                                    "Refreshment",
                                                    const Refreshment(),
                                                    Icon(
                                                      FontAwesomeIcons.mugHot,
                                                      size: height * 0.05,
                                                      color: Color(0xffF7F9FC),
                                                    ),
                                                  ),
                                                ),
                                                //...........WORK MANAGER....................
                                                Container(
                                                  child: Buttons(
                                                    "Work Manager",
                                                    WorkEntry(),
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .briefcase,
                                                      size: height * 0.05,
                                                      color: Color(0xffF7F9FC),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : dep == 'WEB'
                                              ? GridView(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 1,
                                                    childAspectRatio: 2.5 / 1,
                                                    crossAxisSpacing: 20,
                                                    mainAxisSpacing: 20,
                                                  ),
                                                  children: [
                                                    Container(
                                                      child: Buttons(
                                                        "Refreshment",
                                                        const Refreshment(),
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .mugHot,
                                                          size: height * 0.05,
                                                          color:
                                                              Color(0xffF7F9FC),
                                                        ),
                                                      ),
                                                    ),
                                                    //...........WORK MANAGER....................
                                                    Container(
                                                      child: Buttons(
                                                        "Work Manager",
                                                        WorkEntry(),
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .briefcase,
                                                          size: height * 0.05,
                                                          color:
                                                              Color(0xffF7F9FC),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : dep == 'RND'
                                                  ? GridView(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      shrinkWrap: true,
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 1,
                                                        childAspectRatio:
                                                            2.5 / 1,
                                                        crossAxisSpacing: 20,
                                                        mainAxisSpacing: 20,
                                                      ),
                                                      children: [
                                                        Container(
                                                          child: Buttons(
                                                            "Refreshment",
                                                            const Refreshment(),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .mugHot,
                                                              size:
                                                                  height * 0.05,
                                                              color: Color(
                                                                  0xffF7F9FC),
                                                            ),
                                                          ),
                                                        ),
                                                        //...........WORK MANAGER....................
                                                        Container(
                                                          child: Buttons(
                                                            "Work Manager",
                                                            WorkEntry(),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .briefcase,
                                                              size:
                                                                  height * 0.05,
                                                              color: Color(
                                                                  0xffF7F9FC),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : dep == 'MEDIA'
                                                      ? GridView(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 1,
                                                            childAspectRatio:
                                                                2.5 / 1,
                                                            crossAxisSpacing:
                                                                20,
                                                            mainAxisSpacing: 20,
                                                          ),
                                                          children: [
                                                            Container(
                                                              child: Buttons(
                                                                "Refreshment",
                                                                const Refreshment(),
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .mugHot,
                                                                  size: height *
                                                                      0.05,
                                                                  color: Color(
                                                                      0xffF7F9FC),
                                                                ),
                                                              ),
                                                            ),
                                                            //...........WORK MANAGER....................
                                                            Container(
                                                              child: Buttons(
                                                                "Work Manager",
                                                                WorkEntry(),
                                                                Icon(
                                                                  Icons
                                                                      .work_outline_rounded,
                                                                  size: height *
                                                                      0.05,
                                                                  color: Color(0xffF7F9FC),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Lottie.asset(
                                                          'assets/81778-loading.json'),
                            ],
                          ),
                        ),
                      ),
                    )
              : Center(child: Text(" ID Not Recognized",
                  style: TextStyle(
                    color: Color(0xffF7F9FC),
                      fontFamily: 'Nexa',
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.w900,
                  ),
          ),

            ),
        ],
      ),
    );
  }

  showDialogBox() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("No Connection"),
        content: Text("Please check your internet connection"),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context, 'Cancel');
              setState(() {
                isAlertSet = false;
              });
              isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
              if (!isDeviceConnected) {
                showDialogBox();
                setState(() {
                  isAlertSet = true;
                });
              }
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  GestureDetector Buttons(String name, Widget pageName, Icon icon) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pageName),
          );
        });
      },
      child: Neumorphic(
        margin: EdgeInsets.all(15),
        style: NeumorphicStyle(
          depth: -2,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          shadowDarkColorEmboss: Colors.orange.withOpacity(0.7),
          // shadowDarkColorEmboss: Colors.white.withOpacity(0.5),
          shadowLightColorEmboss: Color(0xff000000),
          // color: const Color(0xffF7F9FC),
          color: Color(0xff21222D),
        ),
        child: Container(
          // margin: EdgeInsets.all(15),
          // height: height * 0.20,
          // width: width * 0.4,
          // decoration: BoxDecoration(
          //   // color: Colors.blue.shade300,
          //   boxShadow: [
          //     BoxShadow(
          //       color: Color(0xffF7F9FC),26,
          //       offset: Offset(10, 10),
          //       blurRadius: 10,
          //       // spreadRadius: 1,
          //     ),
          //     BoxShadow(
          //       color: Colors.black12,
          //       offset: Offset(-10, 10),
          //       blurRadius: 10,
          //     ),
          //   ],
          //   borderRadius: BorderRadius.all(Radius.circular(20)),
          //   gradient: LinearGradient(
          //     colors: [
          //       // Color(0xff26D0CE),
          //       // Color(0xff1A2980),
          //       // Color(0xffEFA41C),
          //       // Color(0xffD52A29),
          //       // Color(0xffF7F9FC),
          //       // Colors.black.withOpacity(0.1),
          //       Color(0xff252525),
          //       Color(0xff252525),
          //
          //     ],
          //     begin: FractionalOffset.topLeft,
          //     end: FractionalOffset.bottomRight,
          //     tileMode: TileMode.repeated,
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nexa',
                  fontSize: height * 0.02,
                  color: Color(0xffF7F9FC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
