import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_guide/filter_screen.dart';
import 'login_screen.dart';
import 'package:ui_guide/register_screen.dart';
// import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';
import 'package:ui_guide/user_page.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(
    builder: (context) => MyApp(),
    enabled: !kReleaseMode,
  ));

 // runApp(
 //   MyApp()
 // );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          RegistrationScreen.id : (context) => RegistrationScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          FilterScreen.id: (context) => FilterScreen(),
        }
    );
  }
}