import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../meal_selection/meal_home_page.dart';

class ParentsOrderFragementScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:  NetworkImage(
                  "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'What you want to do?',
                  style: GoogleFonts.ovo(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20,),

                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: const Text(
                        'HOME',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MealHomePage()),
                      );//signup screen
                    },
                  ),
                ),
                const SizedBox(height: 20,),

                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: const Text(
                        'ATTENDANCE',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MealHomePage()),
                      // );//signup screen
                    },
                  ),
                ),
                const SizedBox(height: 20,),

                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: const Text(
                        'MEALS',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MealHomePage()),
                      );//signup screen
                    },
                  ),
                ),
                const SizedBox(height: 20,),

                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: const Text(
                        'STUDY FEE',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MealHomePage()),
                      // );//signup screen
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}