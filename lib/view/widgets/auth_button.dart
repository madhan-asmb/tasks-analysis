import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final String text;
  const AuthButtons({
    Key? key,
    required this.color,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        onPrimary: Colors.white,
        // shadowColor: Colors.greenAccent,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: Size(size.width * 0.4, 40),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
