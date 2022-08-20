import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:pinput/pinput.dart';

typedef OAuthSignIn = void Function();

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  late String verificationId;

  bool isLoading = false;
  bool isCodeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16),
                child: phone(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isCodeSent) {
            validateOTP();
          } else {
            sendOTP();
          }
        },
        child: const Icon(
          Icons.arrow_forward,
        ),
      ),
    );
  }

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Widget phone() {
    if (isCodeSent) {
      return Pinput(
        length: 6,
        autofocus: true,
        controller: otpController,
      );
    }
    return MaskedTextField(
      mask: '##########',
      maxLength: 10,
      autofocus: true,
      controller: phoneController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'xxxxxxxxxx',
        prefixText: '+92 ',
      ),
    );
  }

  Future<void> sendOTP() async {
    setIsLoading();

    final input = phoneController.text;

    final phoneNumber = '+92$input';

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeAutoRetrievalTimeout: (verificationId) {},
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (firebaseAuthException) {},
      codeSent: (verificationId, resendToken) {
        this.verificationId = verificationId;
        isCodeSent = true;
        setIsLoading();
      },
    );
  }

  void validateOTP() {
    final smsCode = otpController.text;

    final credential = PhoneAuthProvider.credential(
      smsCode: smsCode,
      verificationId: verificationId,
    );

    _auth.signInWithCredential(credential);
  }
}
