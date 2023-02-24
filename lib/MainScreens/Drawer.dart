import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'PR/invoice/provider_page.dart';
import 'login_screen.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String user = '';
  String mailID = '';
  String department = '';
  SharedPreferences? preferences;

  late SharedPreferences logData;

  Future init() async {
    preferences = await SharedPreferences.getInstance();

    // print('............................${preferences?.getString('name')}');
    String? name = preferences?.getString('name');
    String? emailId = preferences?.getString('email');
    String? dep = preferences?.getString('department');
    if (name == null) return;
    setState(() {
      user = name;
      mailID = emailId!;
      department = dep!;
      // print(department);
    });
  }


  getProfileImage() {
     if(_firebaseAuth.currentUser?.photoURL != null){
       print('Not Image Get ');
       return Image.network('${_firebaseAuth.currentUser?.photoURL}');

     }else{
       return Icon(Icons.account_circle);

     }
  }


  readData() async {
    logData = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    readData();
    getProfileImage();
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      // Color(0xff1A2980),
      // Color(0xff26D0CE),
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Neumorphic(
              // margin: EdgeInsets.all(0),
              style: NeumorphicStyle(
                depth: -2,
                boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.all(Radius.circular(0))),
                shadowDarkColorEmboss: Colors.black,
                shadowLightColorEmboss: Colors.black,
                color: Color(0xff21222D),
              ),
              child: Container(
                padding: EdgeInsets.only(top: height * 0.05, left: width * 0.05),
                height: height * 1,
                width: width * 0.04,
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [
                  //     // Color(0xff26D0CE),
                  //     // Color(0xff1A2980),
                  //     // Color(0xffEFA41C),
                  //     // Color(0xffD52A29),
                  //     Color(0xff21409D),
                  //     Color(0xff050851),
                  //   ],
                  //   begin: FractionalOffset.topLeft,
                  //   end: FractionalOffset.bottomRight,
                  //   tileMode: TileMode.repeated,
                  // ),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: height*0.15,
                            width: width*0.9,
                            decoration: BoxDecoration(
                          // image: DecorationImage(
                          //     image: AssetImage("assets/account.png"),
                          //     ),
                          // color: Colors.cyanAccent.shade200,
                          shape: BoxShape.circle,
                            ),
                            child: getProfileImage(),
                            // Icon(
                            //     FontAwesomeIcons.user,
                            //   size: height*0.08,
                            // ),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            user,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: height * 0.03,
                                ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        mailID,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white, fontSize: height * 0.02, fontWeight: FontWeight.w600 ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            print(department);
                            if(department == department){
                              print(Provider.of<TaskData>(context,listen: false).tasks.length);
                              if(Provider.of<TaskData>(context,listen: false).tasks.length > 1) {
                                logData.setBool('login', false);
                                logData.clear();
                                Provider.of<TaskData>(context,listen: false).invoiceListData.clear();
                                Provider.of<TaskData>(context,listen: false).value.clear();
                                Provider.of<TaskData>(context,listen: false).deleteCustomerDetails(1);
                                auth.signOut();
                                FirebaseAuth.instance.signOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainPage(),
                                  ),
                                );
                              }else{
                                auth.signOut();

                                // FirebaseAuth.instance.signOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainPage(),
                                  ),
                                );
                              }
                            }
                            else{
                              auth.signOut();
                              // FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainPage(),
                                ),
                              );
                            }
                          });
                        },
                        child: drawerMenu(
                            'Logout',
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: height * 0.03,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.75,
            right: width * 0.02,
            child: RotatedBox(
              quarterTurns: 3,
              child: Image.asset(
                'assets/light onwords 1.png',
                scale: 3,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget drawerMenu(String name, Icon icon) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListTile(
      leading: icon,
      title: Text(
        name,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          color: Colors.white,
          fontSize: height * 0.02,
        )),
      ),
    );
  }
}
