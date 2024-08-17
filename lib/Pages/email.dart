import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lifespark_assignment/Pages/home.dart';
import 'package:lifespark_assignment/Pages/otp.dart';
import 'package:lifespark_assignment/Widgets/button.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  bool isLoading = false;

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
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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
                      child: EmailText(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CommonButton(
                      title: 'Continue',
                      onPressed: sendEmail,
                      isLoading: isLoading),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget EmailText() {
    return TextFormField(
      controller: emailcontroller,
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
          return 'Please enter an Email';
        } else if (!GetUtils.isEmail(value)) {
          return 'Please enter a valid Email';
        }
        return null;
      },
    );
  }

  Future<void> sendEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('emailUser', emailcontroller.text.trim());
        Get.to(() => HomePage());
      } catch (e) {
        // Handle network error
        Get.snackbar('Error', 'An error occurred. Please try again.');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
