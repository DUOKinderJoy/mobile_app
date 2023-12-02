import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectButton extends StatelessWidget {
  final void Function()? onTap;

  const SelectButton({
    super.key,
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
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Select",
              style: GoogleFonts.ovo(
                  color: const Color.fromARGB(255, 235, 182, 182),
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
