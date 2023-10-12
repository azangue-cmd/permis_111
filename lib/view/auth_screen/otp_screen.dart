/*  code otp


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navigation_bar/login_splash/widget/colors.dart';
import 'package:navigation_bar/service/fonction.dart';
import 'package:pinput/pinput.dart';

class VerificationOtp extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const VerificationOtp(
      {Key? key, required this.verificationId, required this.phoneNumber})
      : super(key: key);

  @override
  State<VerificationOtp> createState() => _VerificationOtpState();
}

class _VerificationOtpState extends State<VerificationOtp> {
  String smsCode = "";
  bool loading = false;
  bool resend = false;
  int count = 20;

  @override
  void initState() {
    super.initState();
    decompte();
  }

  late Timer timer;

  void decompte() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (count < 1) {
        timer.cancel();
        count = 20;
        resend = true;
        setState(() {});
        return;
      }
      count--;
      setState(() {});
    });
  }

  void onResendSmsCode() {
    resend = false;
    setState(() {});
    authWithPhoneNumber(widget.phoneNumber, onCodeSend: (verificationId, v) {
      loading = false;
      decompte();
      setState(() {});
    },
        //authentification
        onAutoVerify: (v) async {
      await auth.signInWithCredential(v);
    }, onFailed: (e) {
      print("Le code est errone");
    }, autoRetieval: (v) {});
  }

  void onVerifySmsCode() async {
    loading = true;
    setState(() {});
    await validateOtp(smsCode, widget.verificationId);
    loading = true;
    setState(() {});
    Navigator.of(context).pop();
    print("Verification effectue avec succes");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Center(
            child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const Text(
                "Verification Otp",
                style:
                    TextStyle(fontSize: 30, color: ColorConstant.kPrimaryColor),
              ),
              const Text(
                "Veillez consulter votre messagerie",
                style:
                    TextStyle(fontSize: 14, color: ColorConstant.kPrimaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Pinput(
                length: 6,
                onChanged: (value) {
                  smsCode = value;
                  setState(() {});
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: !resend ? null : onResendSmsCode,
                  child: Text(
                    !resend
                        ? "00:${count.toString().padLeft(2, "0")}"
                        : "Renvoyer le code!",
                    style: const TextStyle(color: ColorConstant.kPrimaryColor),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorConstant.kPrimaryColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: ElevatedButton(
                      onPressed: smsCode.length < 6 || loading
                          ? null
                          : onVerifySmsCode,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                "Verifier",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 231, 193, 193),
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}

*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:pinput/pinput.dart';

import '../../utils/colors.dart';
import 'auth_sreen.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({Key? key, required this.mobileNumber}) : super(key: key);
  String mobileNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String smsCode = "";
  bool loading = false;
  bool resend = false;
  int count = 20;


@override
  void initState() {
    super.initState();
    decompte();
  }

  late Timer timer;

  void decompte() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (count < 1) {
        timer.cancel();
        count = 20;
        resend = true;
        setState(() {});
        return;
      }
      count--;
      setState(() {});
    });
  }

/*
  void onResendSmsCode() {
    resend = false;
    setState(() {});
    authWithPhoneNumber(widget.mobileNumber, onCodeSend: (verificationId, v) {
      loading = false;
      decompte();
      setState(() {});
    },
        //authentification
        onAutoVerify: (v) async {
      //await auth.signInWithCredential(v);
    }, onFailed: (e) {
      print("Le code est errone");
    }, autoRetieval: (v) {});
  }

  */

  void onVerifySmsCode() async {
    loading = true;
    setState(() {});
    //await validateOtp(smsCode, widget.verificationId);
    loading = true;
    setState(() {});
    Navigator.of(context).pop();
    print("Verification effectue avec succes");
  }

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
        title: Image(
          image: const AssetImage('assets/images/permis111_5.png'),
          height: height * 0.03,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.02
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Authentification Required',
                style: textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold
                ),
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.mobileNumber,
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          ),
                      ),
                      TextSpan(
                        text: ' Change',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                    ),
                  ),

                 CommonFunction.blankSpace(height * 0.02, 0),

                  Text(
                    'We have send a One time Password (OTP) to the mobile number above. Pleace enter it to complete verification.',
                    style: textTheme.bodyMedium,
                    ),
                CommonFunction.blankSpace(height * 0.02, 0),

                Pinput(
                length: 6,
                onChanged: (value) {
                  smsCode = value;
                  setState(() {});
                },
              ),

              CommonFunction.blankSpace(height * 0.02, 0),

                CommonAuthButton(
                  title: 'Continue',
                  onPressed: (){},
                  ),

                  CommonFunction.blankSpace(height * 0.01, 0),

                  Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: (){},
                  //onPressed: !resend ? null : onResendSmsCode,
                  child: Text(
                    !resend
                        ? "00:${count.toString().padLeft(2, "0")}"
                        : "Resend OTP !!!",
                    style: const TextStyle(color: Colors.blue ),
                  ),
                ),
              ),

              CommonFunction.blankSpace(height * 0.01, 0),

              const BottomAuthScreenWidget(),
  

            ],
          ),
        ),
        ),
    );
  }
}
