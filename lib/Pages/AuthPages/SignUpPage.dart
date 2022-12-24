
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/Globals/widgets.dart';
import 'package:flutter/material.dart';

import '../../Globals/styles.dart';
import '../../Utils.dart';


class SignUpPage extends StatefulWidget {
  
  final VoidCallback onClickLogIn;

  const SignUpPage({
    Key? key,
    required this.onClickLogIn,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Column(
    
      crossAxisAlignment: CrossAxisAlignment.stretch,
    
      children: [

        const SizedBox(height: 60),

        AnimatedScale(
          
          duration: Duration(milliseconds: keyboardOpen? 0: 150),
          scale: keyboardOpen? 0.0: 1.0,

          child: SizedBox(
            height: 280,
            child: Image.asset('assets/images/signup_pic.png'),
          ),
        ),
    
        const SizedBox(height: 25,),

        TextFormField(
          controller: emailController,
          cursorColor: Colors.grey.shade200,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            filled: true, 
            fillColor: Colors.grey.shade700 , 
            labelText: 'Email'
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (email) =>
            email != null && !EmailValidator.validate(email.trim())
            ? 'Enter a valid e-mail'
            : null
        ),
    
        const SizedBox(height: 25),
    
        TextFormField(
          controller: passwordController,
          cursorColor: Colors.grey.shade200,
          textInputAction: TextInputAction.next,
          obscureText: true,
          decoration: InputDecoration(
            filled: true, 
            fillColor: Colors.grey.shade700 , 
            labelText: 'Password'
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (pass) =>
            pass!.length < 6
            ? 'Password length must be atleast 6 characters'
            : null
        ),

        const SizedBox(height: 8),
    
        TextFormField(
          controller: confirmPasswordController,
          cursorColor: Colors.grey.shade200,
          obscureText: true,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            filled: true, 
            fillColor: Colors.grey.shade700 , 
            labelText: 'Confirm password'
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (pass) =>
            pass!.length < 6
            ? 'Password length must be atleast 6 characters'
            : null
        ),
    
        const SizedBox(height: 74,),
    
        MyElevatedButton(
          onPressed: signUp, 
          label: 'Sign Up',
          icon: Icons.arrow_circle_up,
        ),

        const SizedBox(height: 16,),

        Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              'Don\'t have an account?  ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            InkWell(

              splashColor: Colors.white10,
              highlightColor: Colors.white12,
              borderRadius: BorderRadius.circular(10),

              onTap: widget.onClickLogIn,

              child: Padding(

                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),

                child: Text(
                  'Log In',
                  style: TextStyles.interactable(18),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  
  Future signUp() async {

    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      )
    );

    try{
      
      if(passwordController.text.trim() != confirmPasswordController.text.trim()){
        throw 'Passwords do not match';
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim(),
      );

      // final Map<String, dynamic> json = 

      FirebaseFirestore.instance.collection('UserData').doc(
        FirebaseAuth.instance.currentUser!.uid,
      ).set({
        'name': 'user',
        'post': 'Unemployed',
        'address': '#xx, #xx, #xx',
        }
      );
    } 
    on FirebaseAuthException catch (e){
      Utils.showSnackBar(text: e.message);
    }
    catch (e) {
      Utils.showSnackBar(text: e.toString());
    }

    Utils.navigatorKey.currentState!.pop();
  }
}