import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_testing/Globals/widgets.dart';
import 'package:firebase_testing/Utils.dart';
import 'package:flutter/material.dart';

import '../../Globals/styles.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(

      backgroundColor: Colors.grey.shade900,

      appBar: AppBar(backgroundColor: Colors.transparent, foregroundColor: Theme.of(context).colorScheme.secondary,),

      body: SingleChildScrollView(

        reverse: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        
        child: Column(
        
          crossAxisAlignment: CrossAxisAlignment.stretch,
        
          children: [

            const SizedBox(height: 60),

            AnimatedScale(
              
              duration: Duration(milliseconds: keyboardOpen? 0: 150),
              scale: keyboardOpen? 0.0: 1.0,

              child: SizedBox(
                height: 280,
                child: Image.asset('assets/images/forgotPass.png'),
              ),
            ),
        
            const SizedBox(height: 45,),

            const Center(
              child: Text(
                'Change password by\n  receiving an e-mail',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
        
            const SizedBox(height: 8),
        
            TextField(
              controller: controller,
              cursorColor: Colors.grey.shade200,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true, 
                fillColor: Colors.grey.shade700 , 
                labelText: 'Email'
              ),
            ),
        
            const SizedBox(height: 20,),
        
            const SizedBox(height: 54,),

            MyElevatedButton(
              onPressed: resetPassword, 
              icon: Icons.arrow_circle_up,
              label: 'Reset Password',
            ),

            const SizedBox(height: 20),

            Center(
              child: InkWell(

                borderRadius: BorderRadius.circular(10),
                splashColor: Colors.white12,
                highlightColor: Colors.white10,
            
                onTap: () => Navigator.of(context).pop(),
            
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  child: Text(
                    'Back',
                    style: TextStyles.interactable(20)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future resetPassword() async {

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => const CircularProgressIndicator(),
    );

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text.trim());

      Utils.showSnackBar(text: 'Email was sent.', color: Colors.grey.shade700);
      Utils.navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } 
    on FirebaseAuthException catch (e) {
      Utils.showSnackBar(text: e.message);
      Utils.navigatorKey.currentState!.pop();

    }
    catch (e) {
      Utils.showSnackBar(text: e.toString());
      Utils.navigatorKey.currentState!.pop();
    }
  }
}