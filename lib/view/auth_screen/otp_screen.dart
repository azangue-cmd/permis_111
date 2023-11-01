import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permis_111/constants/common_function.dart';
import '../../controller/services/auth_services/function.dart';
import '../../pages/widgets/bottomAuthScrenWidget.dart';
import '../../pages/widgets/commonAuthButon.dart';
import '../../utils/colors.dart';
import 'auth_sreen.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen(
      {Key? key, 
      required this.mobileNumber, 
      //required this.verificationId
      })
      : super(key: key);
  String mobileNumber;
  //final String verificationId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

TextEditingController otpController = TextEditingController();
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

  //region resend code
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
            padding:  EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.02
            ),
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
                
                // region pinput
                /*
                Center(
                  child: Pinput(
                    length: 6,
                    onChanged: (value) {
                      smsCode = value;
                      setState(() {});
                    },
                  ),
                ),
                */
                // endregion
          
                CommonFunction.blankSpace(height * 0.02, 0),
                CommonAuthButton(
                  title: 'Continue',
                  btnWidth: 0.88,

                  onPressed: () {
                    /*
                  AuthServices.verifyOTP(
                    context: context,
                    otp: otpController.text.trim(),
                  );
                  */
                },
                
                ),
                CommonFunction.blankSpace(height * 0.01, 0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    //onPressed: !resend ? null : onResendSmsCode,
                    child: Text(
                      'Resend OTP !!!',
                      style: textTheme.bodyMedium!.copyWith(
                        color: Colors.blue,
                      ),
                      /*
                      !resend
                          ? "00:${count.toString().padLeft(2, "0")}"
                          : "Resend OTP !!!",
                      style: const TextStyle(color: Colors.blue),
                      */
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
