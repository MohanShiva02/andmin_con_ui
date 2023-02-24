import 'dart:async';

import 'package:andmin_con_ui/MainScreens/PR/invoice/provider_page.dart';
import 'package:andmin_con_ui/MainScreens/home_page.dart';
import 'package:andmin_con_ui/MainScreens/login_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'MainScreens/PR/invoice/image_saving/user_preference.dart';

// 2.0.0+13 older

// version 2.0.0+14   22/10/2022 currently Using...
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset(
        "assets/splashscreen.json",
      ),
      nextScreen: MainPage(),
      backgroundColor: Color(0xffF7F9FC),
      splashIconSize: 350,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final database = FirebaseDatabase.instance.ref().child("staff");
  final user = FirebaseAuth.instance.currentUser;

  String? CurrerntUser;
  var fbData;

  var dep;

  loadData() {
    database.child(user!.uid).once().then((value) {
      // print(value.snapshot.value);
      fbData = value.snapshot.value;
      setState(() {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TeamMainPage()));
      });

    });
  }
  // loadData() {
  //   database.child(user!.uid).once().then((value) {
  //     for (var element in value.snapshot.children) {
  //       fbData = element.value;
  //       if (fbData['email'] == CurrerntUser) {
  //         if (fbData['department'] == "ADMIN") {
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (context) => const CEOScreen()));
  //         } else if (fbData['department'] == "APP") {
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (context) => const ITScreen()));
  //         } else if (fbData['department'] == "PR") {
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (context) => const PRScreen()));
  //         } else if (fbData['department'] == "MEDIA") {
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (context) => const ITScreen()));
  //         } else if (fbData['department'] == "WEB") {
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (context) => const ITScreen()));
  //         } else if (fbData['department'] == "RND") {
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (context) => const ITScreen()));
  //         }
  //       }
  //     }
  //   });
  // }

  // ....................Get Location........................................


  @override
  void initState() {
    setState(() {
      // _checkVersion();
      CurrerntUser = user?.email;
      loadData();
    });
    super.initState();
  }


  // void _checkVersion() async {
  //   final newVersion = NewVersion(
  //       androidId: 'com.onwords.admin_console');
  //   final status = await newVersion.getVersionStatus();
  //   newVersion.showUpdateDialog(context: context, versionStatus: status!,
  //       dialogTitle: 'Update Available',
  //       dismissButtonText: "Skip",
  //       dialogText: "Please Update Latest Version",
  //       dismissAction: (){
  //         SystemNavigator.pop();
  //       }
  //   );
  //
  //   print('Device :' +status.localVersion);
  //   print('Store :' + status.storeVersion);
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21222D),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/81778-loading.json",
              ),
            ],
          ),
        ),
      ),
    );
  }

}
