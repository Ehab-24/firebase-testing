
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/Classes/myUser.dart';
import 'package:firebase_testing/Utils.dart';
import 'package:flutter/material.dart';

import '../../Globals/styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  // late final myUser? user;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(

        children: [
        
          const SizedBox(height: 60,),

          Row(
            children: [

              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white38,
              ),

              const SizedBox(width: 20,),

              FutureBuilder<myUser?>(
                future: loadUser(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return personalInfo(snapshot.data!);
                  }
                  else if(snapshot.hasError){
                    return Utils.showSnackBar(text: 'Error occurred.');
                  }
                  else{
                    return const CircularProgressIndicator();
                  }
                }
              ),
            ],
          )
        ],
      ),
    );
  }

  RichText personalInfo(myUser user) {

    return RichText(
      text: TextSpan(
        children: [

          TextSpan(
            children: [

              const TextSpan(
                text: 'Name\n',
                style: TextStyle(
                  color: Color.fromRGBO(97, 97, 97, 1),
                  height: 2,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.8,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: '     ${user.name}\n',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                )
              )
            ]
          ),
          TextSpan(
            children: [

              const TextSpan(
                text: 'Job title\n',
                style: TextStyle(
                  color: Color.fromRGBO(97, 97, 97, 1),
                  height: 3,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.8,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: '     ${user.post}\n',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                )
              )
            ]
          ),
          TextSpan(
            text: 'signed in as\n',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              height: 3.5,
              letterSpacing: 0.8,
              fontSize: 14,
            )
          ),
          TextSpan(
            text: '     ${FirebaseAuth.instance.currentUser!.email}',
            style: TextStyles.interactable(16)
          ),
        ]
      ),
    );
  }
  
  Future<myUser?> loadUser() async {

    final db = FirebaseFirestore.instance.collection('UserData')
      .doc(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await db.get();

    if(snapshot.exists){
      return myUser.fromJson(snapshot.data()!);
    }
    return null;
  }
}