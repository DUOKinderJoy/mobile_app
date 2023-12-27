import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekButton extends StatelessWidget {
  final String week;
  final String date;
  final void Function()? onTap;

  const WeekButton({
    super.key,
    required this.week,
    required this.date,
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
            Column(
              children: [
                Text(
                  week,
                  style: GoogleFonts.ovo(
                    color: const Color.fromARGB(255, 235, 182, 182),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  date,
                  style: GoogleFonts.ovo(
                    color: const Color.fromARGB(255, 235, 182, 182),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
