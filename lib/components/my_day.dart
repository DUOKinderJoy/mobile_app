import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDay extends StatelessWidget {
  final String text;
  const MyDay({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 82, 76, 76),
          borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.ovo(
                fontSize: 30, color: const Color.fromARGB(255, 235, 182, 182)),
          )
        ],
      ),
    );
  }
}
