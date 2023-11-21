import 'package:firebase_auth/firebase_auth.dart';
import 'package:permis_111/constants/constant_permis.dart';

void authWithPhoneNumber(String phone,
    {required Function(String value, int? value1) onCodeSend,
    required Function(PhoneAuthCredential value) onAutoVerify,
    required Function(FirebaseAuthException value) onFailed,
    required Function(String value) autoRetieval}) async {
  final auth = FirebaseAuth.instance;
  auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 20),
      verificationCompleted: onAutoVerify,
      verificationFailed: onFailed,
      codeSent: onCodeSend,
      codeAutoRetrievalTimeout: autoRetieval);
}

Future<void> validateOtp(String smsCode, String verificationId) async {
  final credential = PhoneAuthProvider.credential(
      verificationId: verificationId, smsCode: smsCode);
  await auth.signInWithCredential(credential);
  return;
}

Future<void> disconnect() async {
  await auth.signOut();
  return;
}

/*
Future<void> validateOtp(String smsCode, String verificationId) async {
  final credential = PhoneAuthProvider.credential(
      verificationId: verificationId, smsCode: smsCode);
  await auth.signInWithCredential(credential);
  return;
}

Future<void> disconnect() async {
  await auth.signOut();
  return;
}

*/ 
 