import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:permis_111/constants/common_function.dart';
import 'package:permis_111/pages/widgets/commonAuthButon.dart';
import 'package:permis_111/utils/colors.dart';
import 'package:permis_111/view/auth_screen/otp_screen.dart';
import '../../controller/services/auth_services/function.dart';
import '../../pages/widgets/bottomAuthScrenWidget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool loading = false;
  bool inLogin = true;
  String curentCountryCode = '+237';
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  //String phoneNumber = '';
  String mobileNumber = '';

  void sendOtpCode() {
    bool loading = true;
    setState(() {});
    final auth = FirebaseAuth.instance;
    if (mobileNumber.isNotEmpty) {
      authWithPhoneNumber(mobileNumber, onCodeSend: (verificationId, v) {
        loading = false;
        setState(() {});
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => OTPScreen(
                  verificationId: verificationId,
                  mobileNumber: mobileNumber,
                )));
      }, onAutoVerify: (v) async {
        auth.signInWithCredential(v);
        Navigator.of(context).pop();
      }, onFailed: (e) {
        loading = false;
        setState(() {
          
        });
        print('Le code est errone');
      }, autoRetieval: (v) {});
    }
  }

  //region sendOtpCode

  /*
  void sendOtpCode() {
    loading = true;
    setState(() {});
    final auth = FirebaseAuth.instance;
    if (mobileNumber.isNotEmpty) {
      authWithPhoneNumber(mobileNumber,
          //verification
          onCodeSend: (verificationId, v) {
        loading = false;
        setState(() {});
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => OTPScreen(
                  verificationId: verificationId,
                  mobileNumber: mobileNumber,
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

  */
  //endregion

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
                        //return  const CreateAccount();
                        return SignIn(width, height, textTheme, context);
                      }
                      return CreateAccount(width, height, textTheme, context);
                      //return  const SignIn();
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

  //region signIn
  Container SignIn(
      double width, double height, TextTheme textTheme, BuildContext context) {
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
                IntlPhoneField(
                  initialCountryCode: "CM",
                  onChanged: (value) {
                    print(value.completeNumber);
                    mobileNumber = value.completeNumber;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  style: textTheme.displaySmall,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),

                /*
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
                */
                CommonFunction.blankSpace(height * 0.02, 0),
                CommonAuthButton(
                  title: 'SignIn',
                  btnWidth: 0.88,
                  onPressed: () {
                    loading ? null : sendOtpCode();
                  },

                  /*              
                  onPressed: () {
                    AuthServices.receiveOTP(
                        context: context,
                        mobileNo:
                            '$curentCountryCode${mobileController.text.trim()}');
                  },
*/
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
  //endregion

  //region createAccount

  Container CreateAccount(
      double width, double height, TextTheme textTheme, BuildContext context) {
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
                              text: 'New to Permis 111?',
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
                SizedBox(
                  height: height * 0.06,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'First and last Name',
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
                CommonFunction.blankSpace(height * 0.01, 0),
                IntlPhoneField(
                  initialCountryCode: "CM",
                  onChanged: (value) {
                    print(value.completeNumber);
                    mobileNumber = value.completeNumber;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  style: textTheme.displaySmall,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
/*

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

*/
                CommonFunction.blankSpace(height * 0.02, 0),
                Text(
                  'By enrolling your mobile phone number, you concent to receive automated security notifications via text message from Permis 111.\nMessage and data rates may apply.',
                  style: textTheme.bodyMedium,
                ),
                CommonFunction.blankSpace(height * 0.02, 0),
                CommonAuthButton(
                  title: 'Continue',
                  btnWidth: 0.88,
                  onPressed: () {
                    loading ? null : sendOtpCode();
                  },
                  /*
                  onPressed: () {
                    AuthServices.receiveOTP(
                        context: context,
                        mobileNo:
                            '+$curentCountryCode${mobileController.text.trim()}');
                  },
                  */
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

          ///--------------------------------------------------------------------

          Container(
            height: height * 0.06,
            width: width,
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: greyShade3),
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
                        text: 'Sign In ',
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
          ),
        ],
      ),
    );
  }

  //endregion
}
