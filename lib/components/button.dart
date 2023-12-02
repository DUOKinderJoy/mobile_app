import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //1-text
            Text(
              text,
              // style: TextStyle(color: Colors.black),
              style: GoogleFonts.ovo(color: Colors.black),
            ),

            const SizedBox(width: 10),

            //2-icon
            Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
