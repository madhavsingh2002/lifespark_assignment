import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lifespark_assignment/Pages/splash.dart';
import 'package:lifespark_assignment/Pages/wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override  
 Widget build(BuildContext context){
  return  GetMaterialApp(
    title: 'Flutter',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'cv', scaffoldBackgroundColor: Color.fromARGB(255, 233, 241, 236),),
    home: SplashScreen(),
  );
 }
}
