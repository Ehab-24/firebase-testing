
import 'package:firebase_testing/Globals/styles.dart';
import 'package:flutter/material.dart';


class BasicTextField extends StatelessWidget {
  const BasicTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.obscuretext = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool obscuretext;

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      cursorColor: Colors.grey.shade200,
      textInputAction: TextInputAction.next,
      obscureText: obscuretext,

      style: TextStyles.inputField,

      decoration: InputDecoration(
        filled: true, 
        fillColor: Colors.transparent , 
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.orange
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color foregroundColor;
  final String label;
  final MainAxisAlignment? alignment;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.alignment,
    this.borderRadius,
    this.width,
    this.height = 60.0,
    this.label = '',
    this.foregroundColor = const Color.fromRGBO(33, 33, 33, 1),
    this.gradient = const LinearGradient(colors: [Colors.yellow, Colors.orange], begin: Alignment.topLeft, end: Alignment.bottomRight),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(8);
    return Container(
     
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),

      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(

          minimumSize: Size.fromHeight(height),
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        
        child: Row(

          mainAxisAlignment: alignment?? MainAxisAlignment.center,
          children: [

            icon == null
            ? const SizedBox.shrink()
            : Icon(icon, color: foregroundColor,),

            const SizedBox(width: 10,),

            Text(
              label,
              style: TextStyles.button1(20),
            )
          ],
        ),
      ),
    );
  }
}
