import 'package:flutter/material.dart';
import 'package:permis_111/pages/welcome.dart';
//import 'package:permis_111/pages/splash_screen/splashscreen.dart';
import 'package:permis_111/utils/theme.dart';
//import 'package:provider/provider.dart';

import 'view/auth_screen/auth_sreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      //home:  OTPScreen(mobileNumber: '+237610101010',),
      //home: AuthScreen(),
      //home: const SplashScreen(),
      home: const Welcome(),
    );
  }
}
