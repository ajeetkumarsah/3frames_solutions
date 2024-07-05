import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController {
  var formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController nameCtlr = TextEditingController();
  TextEditingController phoneCtlr = TextEditingController();
  TextEditingController otpCtlr = TextEditingController();
  RxBool otpSent = false.obs;
  String _verificationId = '';
  void submit() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    //submit the form
    formKey.currentState?.save();
    sendOtp();
  }

  void sendOtp() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneCtlr.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Get.snackbar('Success',
            'Phone number automatically verified and user signed in.');
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar('Error', e.message ?? 'Verification failed.');
      },
      codeSent: (String verificationId, int? resendToken) {
        otpSent.value = true;
        _verificationId = verificationId;
        Logger().i('===>Otp Sent $_verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otpCtlr.text,
    );

    try {
      await _auth.signInWithCredential(credential);
      Get.snackbar('Success', 'User signed in successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in: $e');
    }
  }
}
