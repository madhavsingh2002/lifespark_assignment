import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifespark_assignment/Pages/email.dart';
import 'package:lifespark_assignment/Pages/home.dart';
import 'package:lifespark_assignment/Pages/login.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool? _hasEmailUser;

  @override
  void initState() {
    super.initState();
    _checkEmailUser();
  }

  // Function to check if emailUser exists in SharedPreferences
  Future<void> _checkEmailUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasEmailUser = prefs.getString('emailUser') != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator until the email check is complete
    if (_hasEmailUser == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Once the check is complete, proceed with the appropriate page
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (_hasEmailUser == true) {
            return const HomePage();
          } else {
            return const PhoneHome();
          }
        },
      ),
    );
  }
}
