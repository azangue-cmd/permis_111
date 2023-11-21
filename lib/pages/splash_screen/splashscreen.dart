import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permis_111/view/auth_screen/auth_sreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6)).then((value) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx) => const AuthScreen()));
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Image(
              image: AssetImage("assets/images/permis111_3.png"),
              width: 200,
            ),
            SizedBox(
              height: 10,
            ),
            SpinKitSpinningLines(
              color: Colors.red,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
