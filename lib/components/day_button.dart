import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const DayButton({
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
            color: Color.fromARGB(255, 82, 76, 76),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        margin: EdgeInsets.fromLTRB(100, 20, 100, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              // style: TextStyle(
              //     color: const Color.fromARGB(255, 235, 182, 182),
              //     fontWeight: FontWeight.bold),
              style: GoogleFonts.ovo(
                color: const Color.fromARGB(255, 235, 182, 182),
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
