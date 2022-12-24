
import 'package:firebase_testing/Pages/AuthPages/SignInPage.dart';
import 'package:flutter/material.dart';

import 'SignUpPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      backgroundColor: Colors.grey.shade900,

      body: SingleChildScrollView(
    
        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
    
        child: AnimatedCrossFade(
          
          firstChild: SignInPage(onClickSignUp: toggle,), 
          secondChild: SignUpPage(onClickLogIn: toggle,), 
          
          crossFadeState: isLogin
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
          
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 300),

          firstCurve: Curves.fastOutSlowIn,
          secondCurve: Curves.fastOutSlowIn,
        ),
      ),
    );
  }

  void toggle() => setState((() => isLogin = !isLogin));
}