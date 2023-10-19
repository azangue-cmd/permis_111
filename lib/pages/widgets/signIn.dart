import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/common_function.dart';
import '../../controller/services/auth_services/function.dart';
import '../../utils/colors.dart';
import '../../view/auth_screen/otp_screen.dart';
import 'commonAuthButon.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

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


  //region send otp code

  void sendOtpCode() {
    loading = true;
    setState(() {});
    final auth = FirebaseAuth.instance;
    if (phoneNumber.isNotEmpty) {
      authWithPhoneNumber(phoneNumber,
          //verification
          onCodeSend: (verificationId, v) {
        loading = false;
        setState(() {});
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => OTPScreen(
                  verificationId: verificationId,
                  mobileNumber: phoneNumber,
                )));
      },
          //authentification
          onAutoVerify: (v) async {
        await auth.signInWithCredential(v);
      }, onFailed: (e) {
        print("Le code est errone");
      }, autoRetieval: (v) {});
    }
  }

  //endregion

    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: greyShade3,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: height * 0.06,
            width: width,
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: greyShade3),
                ),
                color: greyShade1),
            //color: greyShade1,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
            ),
            //..................... create your acount.................
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      inLogin = false;
                    });
                  },
                  child: Container(
                    height: height * 0.03,
                    width: height * 0.03,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: grey,
                      ),
                      color: white,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.circle,
                      size: height * 0.015,
                      color: inLogin ? transparent : secondaryColor,
                    ),
                  ),
                ),
                CommonFunction.blankSpace(0, width * 0.02),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Create Account. ',
                        style: textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                          text: 'New to Permis 111?.',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ..............................Sign in.........................
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.01),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          inLogin = true;
                        });
                      },
                      child: Container(
                        height: height * 0.03,
                        width: height * 0.03,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: grey,
                          ),
                          color: white,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.circle,
                          size: height * 0.015,
                          color: inLogin ? secondaryColor : transparent,
                        ),
                      ),
                    ),
                    CommonFunction.blankSpace(0, width * 0.02),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sign in. ',
                            style: textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                              text: 'Already a Customer.',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                            context: context,
                            onSelect: (val) {
                              setState(() {
                                curentCountryCode = '+${val.phoneCode}';
                              });
                            });
                      },
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: grey,
                          ),
                          color: greyShade2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          curentCountryCode,
                          style: textTheme.displaySmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                      width: width * 0.64,
                      child: TextFormField(
                        controller: mobileController,
                        cursorColor: black,
                        style: textTheme.displaySmall,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Mobile number',
                          hintStyle: textTheme.bodySmall,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: secondaryColor,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CommonFunction.blankSpace(height * 0.02, 0),
                CommonAuthButton(
                  title: 'Continue',
                  btnWidth: 0.88,
                  
                  onPressed: () {
                    loading ? null : sendOtpCode();
                  },
                  

                ),
                CommonFunction.blankSpace(height * 0.02, 0),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'By continuing you agree to Permis 111 ',
                          style: textTheme.labelMedium),
                      TextSpan(
                          text: 'Conditions of use ',
                          style: textTheme.labelMedium!.copyWith(color: blue)),
                      TextSpan(text: 'and ', style: textTheme.labelMedium),
                      TextSpan(
                          text: 'Privacy notice.',
                          style: textTheme.labelMedium!.copyWith(color: blue)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          CommonFunction.blankSpace(height * 0.05, 0),

          Column(
            children: [
              Container(
                height: 2,
                width: width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [white, grey, white]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}