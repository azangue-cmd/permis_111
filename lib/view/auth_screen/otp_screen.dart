import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/controller/services/auth_services/signInLogic.dart';
import 'package:pinput/pinput.dart';
import '../../controller/services/auth_services/function.dart';
import '../../pages/widgets/bottomAuthScrenWidget.dart';
import '../../pages/widgets/commonAuthButon.dart';
import '../../utils/colors.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({
    Key? key,
    required this.verificationId,
    required this.mobileNumber,
  }) : super(key: key);
  final String mobileNumber;
  final String verificationId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  bool loading = false;
  String smsCode = '';
  bool resend = false;
  int count = 20;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    decompte();
  }

  late Timer timer;

  void decompte() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
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
    authWithPhoneNumber(widget.mobileNumber, onCodeSend: (verificationId, v) {
      loading = false;
      decompte();
      setState(() {});
    }, onAutoVerify: (v) async {
      auth.signInWithCredential(v);
      // Navigator.of(context).pop();
    }, onFailed: (e) {
      print('Le code est errone');
    }, autoRetieval: (v) {});
  }

  void onVerifySmsCode() async {
    loading = true;
    setState(() {});
    await validateOtp(smsCode, widget.verificationId);
    loading = false;
    setState(() {});
   
    print('Verification effectue avec succes');
    Navigator.push(
          context,
          PageTransition(
            child: const SignInLogic(),
            type: PageTransitionType.rightToLeft,
          ));
    // Navigator.of(context).pop();
  }

//region essaye de la deuxieme methode
/*
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

  //redion resend code
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
      await auth.signInWithCredential(v);
    }, onFailed: (e) {
      print("Le code est errone");
    }, autoRetieval: (v) {});
  }
  //endregion

  //region sms code
  void onVerifySmsCode() async {
    loading = true;
    setState(() {});
    await validateOtp(smsCode, widget.verificationId);
    loading = true;
    setState(() {});
    Navigator.of(context).pop();
    print("Verification effectue avec succes");
  }
  //endregion

//endregion
*/
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
                  'Authentification Required',
                  style: textTheme.displayMedium!
                      .copyWith(fontWeight: FontWeight.bold),
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

                /*
                TextField(
                  controller: otpController,
                  
                  decoration: InputDecoration(
                            
                            hintText: 'Enter OTP code',
                            
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
                */

                // region pinput

                Center(
                  child: Pinput(
                    length: 6,
                    onChanged: (value) {
                      smsCode = value;
                      setState(() {});
                    },
                  ),
                ),

                // endregion

                //             CommonFunction.blankSpace(height * 0.02, 0),
// region texte resend code
/*
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: !resend ? null : onResendSmsCode,
                    child: Text(
                      !resend
                          ? "00:${count.toString().padLeft(2, "0")}"
                          : "Renvoyer le code!",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
*/
// endregion
                CommonFunction.blankSpace(height * 0.02, 0),
/*
                Container(
                  width: double.infinity,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(22)),
                  child: ElevatedButton(
                    onPressed:
                        smsCode.length < 6 || loading ? null : onVerifySmsCode,
                    child: loading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text("Continue", style: textTheme.displaySmall),
                  ),
                ),
*/

                CommonAuthButton(
                  title: 'Continue',
                  btnWidth: 0.88,
                  onPressed: () {
                    smsCode.length < 6 || loading ? null : onVerifySmsCode();
                  },
                  /*
                  onPressed: () { 
                  AuthServices.verifyOTP(
                    context: context,
                    otp: otpController.text.trim(),
                  );
                },
                */
                ),

                CommonFunction.blankSpace(height * 0.01, 0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: !resend ? null : onResendSmsCode,
                    child: Text(
                      /*
                      'Resend OTP !!!',
                      style: textTheme.bodyMedium!.copyWith(
                        color: Colors.blue,
                      ),
                      */

                      !resend
                          ? "00:${count.toString().padLeft(2, "0")}"
                          : "Resend OTP !!!",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                const BottomAuthScreenWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
