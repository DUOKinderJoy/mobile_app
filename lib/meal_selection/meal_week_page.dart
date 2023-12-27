import 'package:flutter/material.dart';
import 'package:kinder_joy_1/components/day_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/components/week_button.dart';
import 'package:kinder_joy_1/meal_selection/meal_home_page.dart';
import 'package:kinder_joy_1/models/cart.dart';
import 'package:provider/provider.dart';

class MealWeekPage extends StatelessWidget {
  const MealWeekPage({super.key});

  @override
  Widget build(BuildContext context) {
    void popUpMessage(String text) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            "It is \"Week $text\". Please select meal for \" Week $text\"",
            style: GoogleFonts.ovo(fontSize: 20),
          ),
          actions: [
            // TextButton
            TextButton(
              onPressed: () {
                // pop once to remove dialog box
                Navigator.pop(context);
              },
              child: const Text(
                'Done',
                style: TextStyle(
                    color: Colors.black), // You can customize the color
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 222, 134, 163),
        actions: [
          //cart button
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/cartpage");
            },
            icon: Icon(Icons.shopping_bag),
          )
        ],
      ),
      body: Stack(
        children: [
          //background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'KinderJoy',
                style: GoogleFonts.ovo(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
              const SizedBox(height: 0),

              Text(
                'Meals Selection',
                style: GoogleFonts.ovo(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30),

              //Week 1
              WeekButton(
                  week: "Week 1",
                  date: "4/12/2023 - 8/12/23",
                  onTap: () {
                    MaterialPageRoute route =
                        MaterialPageRoute(builder: (context) => MealHomePage());
                    Navigator.push(context, route);
                  }),

              //Week 2
              WeekButton(
                  week: "Week 2",
                  date: "11/12/2023 - 15/12/23",
                  onTap: () {
                    popUpMessage("1");
                  }),

              //Week 3
              WeekButton(
                  week: "Week 3",
                  date: "18/12/2023 - 22/12/23",
                  onTap: () {
                    popUpMessage("1");
                  }),

              //Week 4
              WeekButton(
                  week: "Week 4",
                  date: "25/12/2023 - 29/12/23",
                  onTap: () {
                    popUpMessage("1");
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
