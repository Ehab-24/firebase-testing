
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_testing/Utils.dart';
import 'package:flutter/material.dart';

import '../../Globals/styles.dart';
import '../Home/HomeScreen.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => EmailVerificationState();
}

class EmailVerificationState extends State<EmailVerification> {
  
  bool isVerified = false;
  late Timer timer;

  @override
  void initState() {
    
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isVerified){
      sendVerificationEmail();
    }

    timer = Timer.periodic(
      const Duration(milliseconds: 300), (_) {
      checkEmailVerified();
    });

    super.initState();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
        isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isVerified){
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try{
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } 
    catch (e) {
      Utils.showSnackBar(text: e.toString());
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return isVerified
    ? const HomeScreen()
    : const VerificationPage();
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

class VerificationPage extends StatelessWidget{
  const VerificationPage({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade900,

      appBar: AppBar(backgroundColor: Colors.transparent, foregroundColor: Colors.orange,),

      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          
          verificationText(),

          const SizedBox(height: 60,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 105),
            child: TextButton(
              onPressed: () {FirebaseAuth.instance.currentUser!.delete();}, 
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(60)
              ),
              child: Text(
                'Cancel',
                style: TextStyles.interactable(22),
              ),
            ),
          )
        ],
      ),
    );
  }

  Center verificationText() {
    return Center(
      child: RichText(
        text: const TextSpan(
          children:[

            TextSpan(
              text: 'An email has been sent to your account\n',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w300
              ),
            ),

            TextSpan(
              text: '\t\t\t\tVerify using email',
              style: TextStyle(
                fontSize: 35,
                color: Colors.grey,
              ),
            )
          ] 
        )
      ),
    );
  }
}