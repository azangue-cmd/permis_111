import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/controller/services/auth_services/auth_service.dart';
import 'package:permis_111/view/auth_screen/auth_sreen.dart';
import 'package:permis_111/view/user_persistant_nav_bar/user_bottom_nav_bar.dart';

import '../../../view/user/home/home_screen.dart';

class SignInLogic extends StatefulWidget {
  const SignInLogic({super.key});

  @override
  State<SignInLogic> createState() => _SignInLogicState();
}

class _SignInLogicState extends State<SignInLogic> {
  ChechAuthentication() {
    bool userAuthenticated = AuthServices.checkAuthentication();
    userAuthenticated
        ? Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const UserBottomNavBar(),
                type: PageTransitionType.rightToLeft,
                ),
            (route) => false)
        : Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const AuthScreen(),
                type: PageTransitionType.rightToLeft,
                ),
            (route) => false,
          ); 
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ChechAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


