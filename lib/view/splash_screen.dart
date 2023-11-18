import 'dart:async';

import 'package:auth_app/controller/auth_provider.dart';
import 'package:auth_app/helper/colors.dart';
import 'package:auth_app/view/home_screen.dart';
import 'package:auth_app/view/login_screen.dart';
import 'package:auth_app/widgets/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final value = context.read<AuthProviders>();
    super.initState();
    Timer(const Duration(seconds: 6), () {
      value.isSignedIn == false
          ? nextScreenReplace(context, const LoginScreen())
          : nextScreenReplace(context, const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBlackColor,
      body: SafeArea(
        child: Center(
          child: Image.asset("assets/image-processing20191128-24941-unscreen.gif"),
        ),
      ),
    );
  }
}
