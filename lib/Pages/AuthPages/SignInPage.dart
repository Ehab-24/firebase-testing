
import 'package:firebase_testing/Globals/styles.dart';
import 'package:firebase_testing/Pages/AuthPages/ForgotPassPage.dart';
import 'package:firebase_testing/Utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Globals/widgets.dart';

class SignInPage extends StatefulWidget {
  
  final VoidCallback onClickSignUp;

  const SignInPage({
    Key? key,
    required this.onClickSignUp,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String message = '';
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.stretch,
    
      children: [

        const SizedBox(height: 60),

        SizedBox(
          height: 280,
          child: Image.asset('assets/images/login_pic.png'),
        ),
    
        const SizedBox(height: 45,),
        
        BasicTextField(controller: emailController, label: 'Email',),
    
        const SizedBox(height: 8),
    
        BasicTextField(label: 'Password', controller: passwordController, obscuretext: true,),
    
        const SizedBox(height: 20,),
    
        Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: Colors.red.shade700,
          ),
        ),
    
        const SizedBox(height: 54,),

        MyElevatedButton(
          onPressed: signIn, 
          label: 'Sign In',
          icon: Icons.arrow_right_outlined,
        ),

        const SizedBox(height: 12,),

        Center(
          child: InkWell(

            borderRadius: BorderRadius.circular(10),
            splashColor: Colors.white12,
            highlightColor: Colors.white10,
        
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPassPage())),
        
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Text(
                'Forgot password?',
                style: TextStyles.interactable(15)
              ),
            ),
          ),
        ),

        const SizedBox(height: 8,),

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

              onTap: widget.onClickSignUp,

              child: Padding(

                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),

                child: Text(
                  'Sign Up',
                  style: TextStyles.interactable(18),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20,),
      ],
    );
  }

  
  Future signIn() async {

    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      )
    );

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim(),
      );
    }
    on FirebaseAuthException catch (e) {
      Utils.showSnackBar(text: e.message);
    } 
    catch(e){
      Utils.showSnackBar(text: e.toString());
    }

    Utils.navigatorKey.currentState!.pop();
  }
}
