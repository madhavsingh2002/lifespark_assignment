import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifespark_assignment/Pages/wrapper.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget{
  final String? vid;
  const OtpPage({super.key,  this.vid});
  @override  
  State<OtpPage> createState()=> _OtpPageState();
}
class _OtpPageState extends State<OtpPage> {
  var code ='';
  signIn() async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.vid!,
      smsCode: code,
    );
    try{
      await FirebaseAuth.instance.signInWithCredential(credential).then((value){
        Get.offAll(Wrapper());
      });
    }on FirebaseAuthException catch(e){
      Get.snackbar('Error Occured', e.code);
    }
    catch(e){
      Get.snackbar('Error Occured', e.toString());
    }
  }
  @override   
  Widget build(BuildContext context){
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter the 6 digit verification code sent to +91-934534234',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 122, 122, 122),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: textcode()),
                   const SizedBox(height: 20),
                  button(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget textcode(){
    return Center(child: 
    Padding(padding: const EdgeInsets.all(6.0),
    child: Pinput(
      length: 6,
      onChanged: (value){
        setState(() {
          code = value;
        });
      },
       defaultPinTheme: PinTheme(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200, // Background color of the pin field
          ),
        ),
    ),),);
  }
  Widget button() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0F5749), // Background color
          foregroundColor: Colors.white, // Text color
          padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust padding
          fixedSize: const Size.fromHeight(65), // Set the height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Customize the border radius
          ),
        ),
        onPressed: (){
          signIn();
        }
        ,
        child: const Text('Verify'),)
    );
  }
}