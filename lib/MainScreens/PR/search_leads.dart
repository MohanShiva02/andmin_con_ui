import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';

import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'notes_add.dart';

class SearchLeads extends StatefulWidget {
  const SearchLeads({Key? key}) : super(key: key);

  @override
  State<SearchLeads> createState() => _SearchLeadsState();
}

class _SearchLeadsState extends State<SearchLeads>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final _auth = FirebaseDatabase.instance.ref().child("customer");
  final user = FirebaseAuth.instance.currentUser;

  final formKey = GlobalKey<FormState>();
  TextEditingController numberField = TextEditingController();

  bool isPressed = false;

  List name = [];
  List phoneNumber = [];
  List location = [];
  List email = [];
  List rating = [];
  List createdDate = [];
  List enquiry = [];
  List status = [];
  List fetched = [];
  List inCharge = [];
  var fbData;
  var a;
  String? selectPRName = 'Select';
  String? selectStatus = 'Select';

  // All() {
  //   _auth.once().then((value) {
  //     for (var lead in value.snapshot.children) {
  //       fbData = lead.value;
  //       print(fbData);
  //       setState(() {
  //         phoneNumber.add(fbData['phone_number']);
  //         // print('step 1');
  //         name.add(fbData['name']);
  //         // print('step 2');
  //         // location.add(fbData['city']);
  //         // print('step 3');
  //         location.add(fbData['customer_state']);
  //         // print('step 4');
  //         createdDate.add(fbData['created_date']);
  //         // print('step 5');
  //         rating.add(fbData['rating']);
  //         // print('step 6');
  //         enquiry.add(fbData['inquired_for']);
  //         // print('step 7');
  //         email.add(fbData['email_id']);
  //         // print('step 8');
  //         fetched.add(fbData['data_fetched_by']);
  //         // print('step 9');
  //       });
  //     }
  //   });
  // }

  viewLeads() {
    name.clear();
    phoneNumber.clear();
    location.clear();
    email.clear();
    rating.clear();
    createdDate.clear();
    enquiry.clear();
    status.clear();
    fetched.clear();

    _auth.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.key);
        if (element.key == numberField.text) {
          // print(element.value);
          fbData = element.value;
          // print(fbData);
          setState(() {
            phoneNumber.add(fbData['phone_number']);
            name.add(fbData['name']);
            location.add(fbData['city']);
            status.add(fbData['customer_state']);
            createdDate.add(fbData['created_date']);
            rating.add(fbData['rating']);
            enquiry.add(fbData['inquired_for']);
            email.add(fbData['email_id']);
            fetched.add(fbData['data_fetched_by']);
            inCharge.add(fbData['LeadIncharge']);
            // print(phoneNumber);
          });
        }
      }
    });
  }

  LeadInCharge() {
    name.clear();
    phoneNumber.clear();
    location.clear();
    email.clear();
    rating.clear();
    createdDate.clear();
    enquiry.clear();
    status.clear();
    fetched.clear();
    inCharge.clear();

    _auth.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.key);
        fbData = element.value;
        // print(fbData['LeadIncharge']);
        a = fbData['LeadIncharge'];
        if (a == selectPRName) {
          if (a != null) {
            // print(element.value);
            fbData = element.value;
            setState(() {
              phoneNumber.add(fbData['phone_number']);
              name.add(fbData['name']);
              location.add(fbData['city']);
              status.add(fbData['customer_state']);
              createdDate.add(fbData['created_date']);
              rating.add(fbData['rating']);
              enquiry.add(fbData['inquired_for']);
              email.add(fbData['email_id']);
              fetched.add(fbData['data_fetched_by']);
              inCharge.add(fbData['LeadIncharge']);
              // print(phoneNumber);
            });
          } else {
            setState(() {
              // All();
            });
          }
        }
      }
    });
  }

  List name1 = [];
  List phoneNumber1 = [];
  List location1 = [];
  List email1 = [];
  List rating1 = [];
  List createdDate1 = [];
  List enquiry1 = [];
  List status1 = [];
  List fetched1 = [];
  List inCharge1 = [];
  var fbData1;
  var a1;
  LeadStatus() {
    name1.clear();
    phoneNumber1.clear();
    location1.clear();
    email1.clear();
    rating1.clear();
    createdDate1.clear();
    enquiry1.clear();
    status1.clear();
    fetched1.clear();
    inCharge1.clear();

    _auth.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.key);
        fbData1 = element.value;
        a1 = fbData1['customer_state'];
        if (a1 == selectStatus) {
          if (a1 != null) {
            // print(element.value);
            fbData1 = element.value;
            setState(() {
              phoneNumber1.add(fbData1['phone_number']);
              name1.add(fbData1['name']);
              location1.add(fbData1['city']);
              status1.add(fbData1['customer_state']);
              createdDate1.add(fbData1['created_date']);
              rating1.add(fbData1['rating']);
              enquiry1.add(fbData1['inquired_for']);
              email1.add(fbData1['email_id']);
              fetched1.add(fbData1['data_fetched_by']);
              inCharge1.add(fbData1['LeadIncharge']);
              // print(phoneNumber);
            });
          } else {
            setState(() {
              // All();
            });
          }
        }
      }
    });
  }

  List<String> PR = [
    'Select',
    'ONWORDS',
    'Anitha',
    'Jeevanandham',
    'Bala Saravanan',
    'Kavin Vetrivel',
    'Akhil',
    'Jeeva',
    'Sankar',
    'Gowtham'
  ];

  List<String> Status = [
    'Select',
    'Visited',
    'Following Up',
    'Incorrect Number',
    'Rejected from management side',
    'Rejected from Customer end',
    'Delayed',
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Offset distance = isPressed ? Offset(5, 5) : Offset(10, 10);
    double blur = isPressed ? 5.0 : 25;
    return Scaffold(
      key: _scaffoldKey,
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
                    Positioned(
                        top: height * 0.01,
                        right: width * 0.01,
                        // left: width*0.3,
                        child: Image.asset(
                          'assets/searching-error.png',
                          scale: 25.0,
                        )),
                    Positioned(
                      top: height * 0.10,
                      // right: 0,
                      left: width * 0.04,
                      child: Center(
                        child: Text(
                          'Search Leads . . .',
                          style: TextStyle(
                              fontSize: height * 0.03,
                              color: Color(0xffffffff),
                              fontFamily: "Nexa",
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Positioned(
                      top: height * 0.15,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffF7F9FC),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Search With',
                              style: TextStyle(
                                  fontSize: height * 0.03,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Avenir"),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              height: 65,
                              width: width * 0.99,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  gradient: LinearGradient(
                                      colors: [
                                        // Color(0xff1A2980),
                                        // Color(0xff26D0CE),
                                        Colors.lightBlueAccent,
                                        Colors.blue
                                      ],
                                      begin: FractionalOffset.topLeft,
                                      end: FractionalOffset.bottomRight,
                                      tileMode: TileMode.repeated),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: TabBar(
                                controller: _tabController,
                                physics: BouncingScrollPhysics(),
                                indicator: BoxDecoration(
                                    color: Colors.blueGrey.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelColor: Color(0xffFFFFFF),
                                // labelColor: Color(0xffFFFFFF),
                                unselectedLabelColor: Colors.black,
                                automaticIndicatorColorAdjustment: true,
                                labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Avenir"),
                                tabs: [
                                  Tab(
                                    icon: Icon(Icons.numbers,
                                        color: Colors.black),
                                    text: 'Number',
                                  ),
                                  Tab(
                                    icon: Icon(Icons.person_outlined,
                                        color: Colors.black),
                                    text: 'PR Name',
                                  ),
                                  Tab(
                                    icon: Icon(Icons.mark_chat_read,
                                        color: Colors.black),
                                    text: 'Status',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                physics: BouncingScrollPhysics(),
                                controller: _tabController,
                                children: [
                                  ///First Screen...................................
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: height * 0.03),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 1),
                                                width: width * 0.5,
                                                height: height * 0.06,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                            10,
                                                          ),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  color: Colors.black12,
                                                  // Colors.white.withOpacity(0.3),
                                                ),
                                                child: Center(
                                                  child: TextFormField(
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          10),
                                                    ],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: "Nexa"),
                                                    controller: numberField,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontFamily:
                                                                  'Nexa',
                                                              fontSize: 15),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      hintText: 'Entre Number',
                                                      filled: true,
                                                      fillColor:
                                                          Colors.transparent,
                                                      // fillColor: Color(0xffF7F9FC),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                    ),
                                                    validator: (value) {
                                                      if (value
                                                          .toString()
                                                          .isEmpty) {
                                                        return 'Enter The Number';
                                                      } else if (value
                                                              ?.length !=
                                                          10) {
                                                        return "Enter The Correct Number";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    final isValid = formKey
                                                        .currentState
                                                        ?.validate();
                                                    if (isValid!) {
                                                      viewLeads();
                                                    }
                                                    isPressed = !isPressed;
                                                  });
                                                },
                                                child: Listener(
                                                  onPointerUp: (_) =>
                                                      setState(() {
                                                    isPressed = true;
                                                  }),
                                                  onPointerDown: (_) =>
                                                      setState(() {
                                                    isPressed = true;
                                                  }),
                                                  child: AnimatedContainer(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 1),
                                                    width: width * 0.2,
                                                    height: height * 0.06,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                10,
                                                              ),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                      color: const Color(
                                                          0xffF7F9FC),
                                                      // Colors.white.withOpacity(0.3),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black26,
                                                          offset: distance,
                                                          blurRadius: blur,
                                                          inset: isPressed,
                                                        ),
                                                        BoxShadow(
                                                          color: Colors.white12,
                                                          offset: -distance,
                                                          blurRadius: blur,
                                                          inset: isPressed,
                                                        ),
                                                      ],
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 100),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          // Icon(Icons.search_rounded,size: height*0.02,color: Colors.blueGrey,),
                                                          Text(
                                                            'Search',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    "Nexa",
                                                                fontSize:
                                                                    height *
                                                                        0.02,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            phoneNumber.length == 0
                                                ? Center(
                                                    child: Text(
                                                      "Enter Number",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Nexa',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              height * 0.03),
                                                    ),
                                                  )
                                                : buildGridView(width, height),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                  ///Second Screen...................................
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Row(
                                            children: const [
                                              Icon(
                                                Icons.list,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                            
                                            ],
                                          ),
                                          items: PR
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectPRName,
                                          onChanged: (value) {
                                            setState(() {
                                              selectPRName = value as String;
                                              a = selectPRName;
                                              // print(a);
                                              LeadInCharge();
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),

                                          iconSize: 15,
                                          iconEnabledColor: Colors.black,
                                          iconDisabledColor: Colors.black,
                                          buttonHeight: 50,
                                          buttonWidth: 250,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 13, right: 13),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(0, 0))
                                            ],
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            color: Colors.lightBlueAccent,
                                          ),
                                          buttonElevation: 2,
                                          itemHeight: 50,
                                          // itemPadding: const EdgeInsets.only(
                                          //     left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownWidth: 290,
                                          dropdownPadding: EdgeInsets.only(
                                              left: 0, right: 0),
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(0, 0))
                                            ],
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(30),
                                          scrollbarThickness: 3,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(-20, 0),
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.62,
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              inCharge.length == 0
                                                  ? Center(
                                                      child: Text(
                                                        "Select PR Name",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: 'Nexa',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                height * 0.03),
                                                      ),
                                                    )
                                                  : buildGridView(
                                                      width, height),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                  ///third Screen...................................
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Row(
                                            children: const [
                                              Icon(
                                                Icons.list,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                          items: Status.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )).toList(),
                                          value: selectStatus,
                                          onChanged: (value) {
                                            setState(() {
                                              selectStatus = value as String;
                                              a = selectStatus;
                                              // print(a);
                                              LeadStatus();
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),
                                          iconSize: 15,
                                          iconEnabledColor: Colors.black,
                                          iconDisabledColor: Colors.black,
                                          buttonHeight: 50,
                                          buttonWidth: 250,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 13, right: 13),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(0, 0))
                                            ],
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            color: Colors.lightBlueAccent,
                                          ),
                                          buttonElevation: 2,
                                          itemHeight: 50,
                                          // itemPadding: const EdgeInsets.only(
                                          //     left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownWidth: 290,
                                          dropdownPadding: EdgeInsets.only(
                                              left: 0, right: 0),
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(0, 0))
                                            ],
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(30),
                                          scrollbarThickness: 3,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(-20, 0),
                                        ),
                                      ),
                                      Container(
                                        height: height * 0.62,
                                        // color: Colors.black,
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Column(
                                            children: [
                                              status1.length == 0
                                                  ? Center(
                                                      child: Text(
                                                        "Select Status",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: 'Nexa',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                height * 0.03),
                                                      ),
                                                    )
                                                  : statusView(
                                                      width, height),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView(double width, double height) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: phoneNumber.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNotes(txt: numberField.text)));
              });
            },
            child: Container(
              height: height * 0.5,
              padding: EdgeInsets.only(top: height * 0.03),
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    colors: [
                      // Color(0xff1A2980),
                      // Color(0xff26D0CE),
                      Colors.lightBlueAccent,
                      Colors.blue
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    tileMode: TileMode.repeated),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  leadDetails("Name", "${name[index]}", Colors.black),
                  leadDetails("Phone", "${phoneNumber[index]}", Colors.black),
                  leadDetails("Location", "${location[index]}", Colors.black),
                  leadDetails("Enquiry", "${enquiry[index]}", Colors.black),
                  leadDetails("Email", "${email[index]}", Colors.black),
                  leadDetails(
                      "createdDate", "${createdDate[index]}", Colors.black),
                  leadDetails(
                      "Data Fetched From", "${fetched[index]}", Colors.black),
                  leadDetails(
                      "Lead InCharge", "${inCharge[index]}", Colors.black),
                  leadDetails(
                    'Status',
                    '${status[index]}',
                    status[index] == "Following Up"
                        ? Colors.green
                        : status[index] == "Delayed"
                            ? Colors.orange.shade800
                            : status[index] == "Rejected from management side"
                                ? Colors.red
                                : status[index] == "Rejected from Customer end"
                                    ? Colors.red
                                    : Color(0xffF7F9FC),
                  ),
                  leadDetails("Rating", "${rating[index]}", Colors.black),
                ],
              ),
            ),
          );
        });
  }
  Widget statusView(double width, double height) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: phoneNumber1.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNotes(txt: numberField.text)));
              });
            },
            child: Container(
              height: height * 0.5,
              padding: EdgeInsets.only(top: height * 0.03),
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    colors: [
                      // Color(0xff1A2980),
                      // Color(0xff26D0CE),
                      Colors.lightBlueAccent,
                      Colors.blue
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    tileMode: TileMode.repeated),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  leadDetails("Name", "${name1[index]}", Colors.black),
                  leadDetails("Phone", "${phoneNumber1[index]}", Colors.black),
                  leadDetails("Location", "${location1[index]}", Colors.black),
                  leadDetails("Enquiry", "${enquiry1[index]}", Colors.black),
                  leadDetails("Email", "${email1[index]}", Colors.black),
                  leadDetails(
                      "createdDate", "${createdDate1[index]}", Colors.black),
                  leadDetails(
                      "Data Fetched From", "${fetched1[index]}", Colors.black),
                  leadDetails(
                      "Lead InCharge", "${inCharge1[index]}", Colors.black),
                  leadDetails(
                    'Status',
                    '${status1[index]}',
                    status1[index] == "Following Up"
                        ? Colors.green
                        : status1[index] == "Delayed"
                            ? Colors.orange.shade800
                            : status1[index] == "Rejected from management side"
                                ? Colors.red
                                : status1[index] == "Rejected from Customer end"
                                    ? Colors.red
                                    : Color(0xffF7F9FC),
                  ),
                  leadDetails("Rating", "${rating1[index]}", Colors.black),
                ],
              ),
            ),
          );
        });
  }

  leadDetails(String title, String address, color) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.04,
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: height * 0.02,
                color: Colors.black,
                fontWeight: FontWeight.w800)),
        trailing: SizedBox(
          // width: 180,
          // height: 80,
          child: SingleChildScrollView(
            child: Text(address,
                style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: height * 0.02,
                    color: color,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
