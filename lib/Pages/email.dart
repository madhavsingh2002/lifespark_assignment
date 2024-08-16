import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifespark_assignment/Pages/otp.dart';
import 'package:lifespark_assignment/Pages/wrapper.dart';
import 'package:lifespark_assignment/Widgets/button.dart';
import 'package:lottie/lottie.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phonenumber = TextEditingController();
  bool isLoading = false;
  sendcode() async {
    setState(() {
      isLoading = true; // Start loading
    });
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91' + phonenumber.text,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
             setState(() {
              isLoading = false; // Stop loading
            });
            Get.snackbar('Error occurred', e.code);
          },
          codeSent: (String vid, int? token) async {
            setState(() {
              isLoading = false; // Stop loading
            });

            // Navigate to OTP page after a slight delay to ensure the loading state is updated
            await Future.delayed(const Duration(milliseconds: 100));
           Get.offAll(Wrapper());
          },
          codeAutoRetrievalTimeout: (vid) {},
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false; // Stop loading
        });
        Get.snackbar('Error Occurred', e.code);
      } catch (e) {
        setState(() {
          isLoading = false; // Stop loading
        });
        Get.snackbar('Error Occurred', e.toString());
      }
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
                      'assets/animation3.json',
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
                      'Enter your Email',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please provide your email address to create your account.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 122, 122, 122),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: double.infinity,
                      child: phoneText(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CommonButton(
                      title: 'Continue',
                      onPressed: sendcode,
                      isLoading: isLoading),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneText() {
    return TextFormField(
      controller: phonenumber,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email), 
        labelText: 'Email Address',
        hintStyle: TextStyle(color: Colors.green.shade700),
        labelStyle: TextStyle(color: Colors.green.shade700),
        filled: true, // Enables the fill color
        fillColor: Colors.grey.shade200, // Background fill color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Border radius
          borderSide: BorderSide(
            color: Colors.grey.shade400, // Border color
            width: 2, // Border width
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Border radius when enabled
          borderSide: BorderSide(
            color: Colors.grey.shade400, // Border color when enabled
            width: 2, // Border width when enabled
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Border radius when focused
          borderSide: BorderSide(
            color: Colors.green.shade700, // Border color when focused
            width: 2, // Border width when focused
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a Email';
        } 
        // else if (value.length != 10) {
        //   return 'Email must be Valida';
        // }
        return null;
      },
    );
  }
}
