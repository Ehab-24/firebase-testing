
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Globals/styles.dart';

class HomeBody extends StatelessWidget {

  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [

          Container(
            
            height: 300,
            margin: const EdgeInsets.symmetric(horizontal: 70),
            alignment: Alignment.center,

            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(

              children: [
                const Text(
                  'Home',
                  style: TextStyles.header1,
                ),

                const Spacer(),

                const Text(
                  'Signed in as ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    letterSpacing: 0.8
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email?? 'Email NOT FOUND',
                  style: TextStyles.interactable(18),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ]
      ),
    );
  }
}