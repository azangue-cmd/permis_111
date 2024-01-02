// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/controller/services/auth_services/auth_service.dart';
import 'package:permis_111/controller/services/user_data_crud_services/user_data_CRUD_services.dart';
import 'package:permis_111/view/auth_screen/auth_sreen.dart';
import 'package:permis_111/view/seller/seller_persistant_nav_bar/seller_bottom_nav_bar.dart';
import 'package:permis_111/view/user/user_data_screen/user_data_input_screen.dart';
import 'package:permis_111/view/user_persistant_nav_bar/user_bottom_nav_bar.dart';

class SignInLogic extends StatefulWidget {
  const SignInLogic({super.key});

  @override
  State<SignInLogic> createState() => _SignInLogicState();
}

class _SignInLogicState extends State<SignInLogic> {
  checkUser() async {
    bool userAlreadyThere = await UserDataCRUD.checkUser();
    log(userAlreadyThere.toString());
    if (userAlreadyThere == true) {
      bool userIsSeller = await UserDataCRUD.userIsSeller();
      log('start');
      log(userIsSeller.toString());
      if (userIsSeller == true) {


        Navigator.push(
          context,
          PageTransition(
            child: const SellerBottomNavBar(),
            type: PageTransitionType.rightToLeft,
          ),
        );
      }else{
      Navigator.push(
          context,
          PageTransition(
            child: const UserBottomNavBar(),
            type: PageTransitionType.rightToLeft,
          ));
      }
    } else {
      Navigator.push(
          context,
          PageTransition(
            child: const UserDataInputScreen(),
            type: PageTransitionType.rightToLeft,
          ));

      //Navigator.of(context)
      // .push(MaterialPageRoute(builder: (c) => const UserDataInputScreen()));
    }
  }

  chechAuthentication() {
    bool userAuthenticated = AuthServices.checkAuthentication();
    userAuthenticated
        ? checkUser()
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
      chechAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Image(
        image: AssetImage('assets/images/permis111_2.png'),
        fit: BoxFit.fill,
      ),
    );
  }
}
