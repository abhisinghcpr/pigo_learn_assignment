import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/view/screens/auth/login/login_screen.dart';
import 'package:flutter_task/view/screens/auth/signup/signup_screen.dart';
import 'package:flutter_task/view/screens/home/home_screen.dart';
import 'package:flutter_task/view/utils/colors/app_color.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3),() {
      checkUser(context);
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Center(
        child: Hero(
          tag: "app_logo",
          child: CircleAvatar(
            radius: 100,
            backgroundColor: AppColors.primaryColor,
            child: Text("e-Shop",style: TextStyle(color: AppColors.white,fontSize: 35),),
          ),
        ),
      ),
    );
  }

  void navigateUser(BuildContext context,{required Widget screen}) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen,));
  }

  void checkUser(BuildContext context) async{

    bool ifExists = FirebaseAuth.instance.currentUser?.uid != null;


    if(ifExists){
      navigateUser(context, screen: HomePage());
    }else{
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      var userData = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if(userData.exists){
        navigateUser(context, screen: LoginPage());
      }else{
        navigateUser(context, screen: SignupPage());
      }
    }
  }
}
