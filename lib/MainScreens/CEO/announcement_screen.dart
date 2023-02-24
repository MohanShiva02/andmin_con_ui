import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../Drawer.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  final onyx = FirebaseDatabase.instance.ref().child("onyx");
  final textController = TextEditingController();

  bool isPressed = false;

  UpdateOnyx() {
    onyx.update({
      "announcement": textController.text,
    }).then((value) {
      textController.clear();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    textController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Offset distance = isPressed ? Offset(5, 5) : Offset(10, 10);
    double blur = isPressed ? 5.0 : 25;

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
              height: height*0.06,
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
                  Positioned(
                      top: height * 0.01,
                      // left: 20,
                      right: width * -0.03,
                      child: Image.asset(
                        'assets/megaphone.png',
                        scale: 15,
                      )),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.13,
            left: width*0.01,
            // right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GradientText(
                  "Announcements",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: "Nexa",
                    fontSize: height * 0.03,
                  ),
                  colors: [
                    Colors.blue,
                    Colors.pink,
                    Colors.yellow,
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: height * 0.25,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  // color: Color(0xffF7F9FC),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1A2980),
                      Color(0xff26D0CE),
                      // Color(0xff21409D),
                      // Color(0xff050851),
                    ],
                    // stops: [
                    //   0.0,
                    //   11.0,
                    // ],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                    // tileMode: TileMode.repeated,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                  image: DecorationImage(
                      image: AssetImage("assets/marketing.png"))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.05, horizontal: width * 0.1),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: textController,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nexa',
                            fontSize: 13,
                          ),

                          decoration: InputDecoration(
                            hintText: "Type Here",
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nexa',
                              fontSize: 13,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.orange),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.45,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            UpdateOnyx();
                            isPressed = !isPressed;
                          });
                        },
                        child: Listener(
                          onPointerUp: (_) => setState(() {
                            isPressed = true;
                          }),
                          onPointerDown: (_) => setState(() {
                            isPressed = true;
                          }),
                          child: AnimatedContainer(
                            margin: const EdgeInsets.only(top: 1),
                            width: width * 0.4,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffF7F9FC),
                              // Colors.white.withOpacity(0.3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: distance,
                                  blurRadius: blur,
                                ),
                                BoxShadow(
                                  color: Colors.white12,
                                  offset: -distance,
                                  blurRadius: blur,
                                ),
                              ],
                            ),
                            duration: Duration(milliseconds: 150),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Icon(Icons.search_rounded,size: height*0.02,color: Colors.blueGrey,),
                                  GradientText(
                                    "Announce",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Nexa",
                                      fontSize: height * 0.03,
                                    ),
                                    colors: [
                                      Colors.blue,
                                      Colors.pink,
                                      Colors.yellow,
                                    ],
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
