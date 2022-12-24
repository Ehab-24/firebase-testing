
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/Globals/widgets.dart';
import 'package:firebase_testing/Utils.dart';
import 'package:flutter/material.dart';


class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final TextEditingController nameController = TextEditingController();
    final TextEditingController postController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    
    return SingleChildScrollView(

      padding: const EdgeInsets.only(top: 100, left: 20, right: 20,),
      physics: const BouncingScrollPhysics(),

      child: Column(
        children: [
        
          inputField(
            context: context,
            controller: nameController,
            label: 'Name',
            onpressed: (){
              updateName(context, nameController.text.trim());
            }
          ),
        
          const SizedBox(height: 20),
          
          inputField(
            context: context,
            controller: postController,
            label: 'Job title',
            onpressed: (){
              updatePost(context, postController.text.trim());
            }
          ),
        
          const SizedBox(height: 20),
        
          inputField(
            context: context,
            controller: addressController,
            label: 'Address',
            onpressed: (){
              updateAddress(context, addressController.text.trim());
            }
          ),
          const SizedBox(height: 130,),

          MyElevatedButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            label: 'Sign Out',
            icon: Icons.arrow_circle_down_outlined,
          )
        ],  
      ),
    );
  }

  Column inputField({
    required BuildContext context, 
    required VoidCallback onpressed, 
    required TextEditingController controller, 
    required String label,
  }) {
    return Column(
      children: [
        
        BasicTextField(label: label, controller: controller),
        const SizedBox(height: 8,),
        Align(
          alignment: Alignment.centerRight,
          child: MyElevatedButton(
            onPressed: onpressed,
            icon: Icons.save,
            width: 65,
            height: 40,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }

  Future updateName(BuildContext context, String name) async {

    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) =>
        const Center( child: CircularProgressIndicator() ),
    );

    try{
      if(name == ''){
        throw 'Name is empty';
      }

      DocumentReference db = FirebaseFirestore.instance.collection('UserData')
        .doc(FirebaseAuth.instance.currentUser!.uid);

      await db.update(
        {'name': name}
      );
    }
    on FirebaseException catch(e){
      Utils.showSnackBar(text: e.message);
    }
    catch(e) {
      Utils.showSnackBar(text: e.toString());
    }

    Utils.navigatorKey.currentState!.pop();
  }

  Future updatePost(BuildContext context, String post) async {

    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) =>
        const Center( child: CircularProgressIndicator() ),
    );

    try{
      if(post == ''){
        throw 'Job title is empty';
      }

      DocumentReference db = FirebaseFirestore.instance.collection('UserData')
        .doc(FirebaseAuth.instance.currentUser!.uid);

      await db.update(
        {'post': post}
      );
    }
    on FirebaseException catch(e){
      Utils.showSnackBar(text: e.message);
    }
    catch(e) {
      Utils.showSnackBar(text: e.toString());
    }

    Utils.navigatorKey.currentState!.pop();
  }

  Future updateAddress(BuildContext context, String address) async {

    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) =>
        const Center( child: CircularProgressIndicator() ),
    );

    try{
      if(address == ''){
        throw 'Address is empty';
      }

      DocumentReference db = FirebaseFirestore.instance.collection('UserData')
        .doc(FirebaseAuth.instance.currentUser!.uid);

      await db.update(
        {'address': address}
      );
    }
    on FirebaseException catch(e){
      Utils.showSnackBar(text: e.message);
    }
    catch(e) {
      Utils.showSnackBar(text: e.toString());
    }

    Utils.navigatorKey.currentState!.pop();
  }
}
