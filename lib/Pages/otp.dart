import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifespark_assignment/Pages/email.dart';
import 'package:lifespark_assignment/Pages/wrapper.dart';
import 'package:lifespark_assignment/Widgets/button.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  final String? vid;
  final String? phonenumber;
  const OtpPage({super.key, this.vid, this.phonenumber});
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var code = '';
  bool isLoading = false;
  signIn() async {
    setState(() {
      isLoading = true; // Start loading
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.vid!,
      smsCode: code,
    );
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        Get.to(EmailPage());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Occured', e.code);
    } catch (e) {
      Get.snackbar('Error Occured', e.toString());
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/animation1.json',
                      height: 400,
                      reverse: true,
                      repeat: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Enter your Code',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                     'Please enter the 6 digit verification code sent to +91-${widget.phonenumber}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 122, 122, 122),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(width: double.infinity, child: textcode()),
                  const SizedBox(height: 20),
                  CommonButton(
                    title: 'Verify',
                    onPressed: signIn,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Resend the Code',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textcode() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Pinput(
          length: 6,
          onChanged: (value) {
            setState(() {
              code = value;
            });
          },
          defaultPinTheme: PinTheme(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
              color: Colors.grey.shade200, // Background color of the pin field
            ),
          ),
        ),
      ),
    );
  }
}
