import 'dart:async';
import 'package:customer_app/screens/dashboard_screens/home_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        // body:Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //   child: Center(child: Image.asset(AppImages.splasImage)),
        // )
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome...",style: TextStyle(color: Colors.black54,fontSize: 40,fontStyle: FontStyle.italic),)
          ],
        ),
      ),
    );
  }
}
