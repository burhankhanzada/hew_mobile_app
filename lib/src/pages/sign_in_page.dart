import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:pinput/pinput.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  late String verificationId;

  late var _isLoading = widget.isLoading;
  var _isCodeSent = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16),
                child: phone(),
              ),
      ),
      floatingActionButton: _isLoading
          ? null
          : FloatingActionButton(
              onPressed: () {
                if (_isCodeSent) {
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
      _isLoading = !_isLoading;
    });
  }

  Widget phone() {
    if (_isCodeSent) {
      return Pinput(
        length: 6,
        autofocus: true,
        controller: _otpController,
      );
    }
    return MaskedTextField(
      mask: '##########',
      maxLength: 10,
      autofocus: true,
      controller: _phoneController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: '3xxxxxxxx',
        prefixText: '+92 ',
      ),
    );
  }

  Future<void> sendOTP() async {
    setIsLoading();

    final input = _phoneController.text;

    final phoneNumber = '+92$input';

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeAutoRetrievalTimeout: (verificationId) {
          debugPrint('codeAutoRetrievalTimeout');
        },
        verificationCompleted: (phoneAuthCredential) {
          debugPrint('verificationCompleted');
        },
        verificationFailed: (firebaseAuthException) {
          debugPrint('verificationFailed');
        },
        codeSent: (verificationId, resendToken) {
          debugPrint('codeSent');
          this.verificationId = verificationId;
          _isCodeSent = true;
          setIsLoading();
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint('Error code: ${e.code}');
      debugPrint('Error: message: ${e.message}}');
    }
  }

  Future<void> validateOTP() async {
    debugPrint('validateOTP');
    final smsCode = _otpController.text;

    final credential = PhoneAuthProvider.credential(
      smsCode: smsCode,
      verificationId: verificationId,
    );

    try {
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      debugPrint('Error code: ${e.code}');
      debugPrint('Error: message: ${e.message}}');
    }
  }
}
