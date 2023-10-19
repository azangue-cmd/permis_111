import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/utils/colors.dart';

import '../../pages/widgets/bottomAuthScrenWidget.dart';
import '../../pages/widgets/createAccount.dart';
import '../../pages/widgets/signIn.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool inLogin = true;
  String curentCountryCode = '+237';
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool loading = false;
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: true,
          elevation: 1,
          title: Image(
            image: const AssetImage('assets/images/permis111_5.png'),
            height: height * 0.03,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: height,
              width: width,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03, vertical: height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: textTheme.displaySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),

                  CommonFunction.blankSpace(height * 0.02, 0),

                  Builder(
                    builder: (context) {
                      if (inLogin) {
                        //return  CreateAccount();
                        return const SignIn();
                      }
                      return const CreateAccount();
                      //return  SignIn();
                    },
                  ),

                  CommonFunction.blankSpace(height * 0.05, 0),

                  const BottomAuthScreenWidget(),
                ],
              ),
            ),
          ),
        ));
  }
}
