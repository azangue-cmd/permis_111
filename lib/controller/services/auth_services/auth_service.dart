import 'package:firebase_auth/firebase_auth.dart';

/// Firebase user authentification manager
class AuthService{
  static final auth = FirebaseAuth.instance;
  //static GoogleAuthProvider googleProvider = GoogleAuthProvider();

  //region Phone number and OTP Authentification
  /// Firebase authentification With Phone number
  static void authWithPhoneNumber(String phone,
      {required Function(String value, int? value1) onCodeSend,
        required Function(PhoneAuthCredential value) onAutoVerify,
        required Function(FirebaseAuthException value) onFailed,
        required Function(String value) autoRetrieval}) async {
    auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 90),
      verificationCompleted: onAutoVerify,
      verificationFailed: onFailed,
      codeSent: onCodeSend,
      codeAutoRetrievalTimeout: autoRetrieval,
    );
  }
  /// Check OPT Code and SignIn
  static Future<void> validateOtp(String smsCode, String verificationId) async {
    final _credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await auth.signInWithCredential(_credential);
    return;
  }
  // endregion
  


  /// Logout connected [User]
  static Future<void> disconnect() async {
    await auth.signOut();
    return;
  }
  /// Get Current connected [User]
  static User? get user => auth.currentUser;
}

