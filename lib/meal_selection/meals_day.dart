import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kinder_joy_1/components/day_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/meal_selection/meal_w1_thurs.dart';
import 'package:kinder_joy_1/meal_selection/meal_w1_wed.dart';
import 'package:route_detector/route_detector.dart';
// import 'package:kinder_joy_1/meal_selection/meal_week1.dart';

import 'package:kinder_joy_1/models/cart.dart';
import 'package:provider/provider.dart';

import 'package:kinder_joy_1/meal_selection/meal_week1.dart';

import 'cart/cart_list_screen.dart';
import 'meal_w1_fri.dart';
import 'meal_w1_tues.dart';

class MealDay extends StatelessWidget {
  const MealDay({super.key});
  

  @override
  Widget build(BuildContext context) {
    bool _isDayButtonTapped = false;

    

    void popUpMessage() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            "You have already selected the meal for you child. Please select for another day.",
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
    //get the menu from cart
    // final cart = context.read<CartListScreen>(); //?must use provider
    // final mealMenu = cart.mealMenu;

    //get the menu from cart
    // final cart = context.read<Cart>(); //?must use provider
    // final mealMenu = cart.days;

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 222, 134, 163),
        actions: [
          //cart button
          IconButton(
            onPressed: () {
              Get.to(CartListScreen());
            },
            icon: Icon(Icons.shopping_cart),
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

              //Monday
              DayButton(
                text: "Monday",
                onTap: () {
                  Get.to(MealsWeek1());

                  // if (remark.mon) {
                  //   popUpMessage();
                  // }

                  // if (!mealMenu[0].isSelected &&
                  //     !mealMenu[1].isSelected &&
                  //     !mealMenu[2].isSelected) {
                  //   MaterialPageRoute route =
                  //   MaterialPageRoute(builder: (context) => MenuPage_1());
                  //   Navigator.push(context, route);
                  //   mealMenu[0].isSelected = true;
                  //   return;
                  // }
                  //
                  // if (mealMenu[0].isSelected) {
                  //   popUpMessage();
                  // }
                }
                // onTap: () {
                //   if (!_isDayButtonTapped) {
                //     _isDayButtonTapped = true;
                //     Get.to(MealsWeek1());
                //     // Additional logic as needed
                //   } else {
                //     popUpMessage();
                //   }
                // },
              ),

              //Tuesday
              DayButton(
                  text: "Tuesday",
                  onTap: () {
                    Get.to(MealsWeek1Tues());

                    // if (!mealMenu[3].isSelected &&
                    //     !mealMenu[4].isSelected &&
                    //     !mealMenu[5].isSelected) {
                    //   MaterialPageRoute route =
                    //   MaterialPageRoute(builder: (context) => MenuPage_2());
                    //   Navigator.push(context, route);
                    //   mealMenu[3].isSelected = true;
                    //   return;
                    // }
                    //
                    // if (mealMenu[3].isSelected) {
                    //   popUpMessage("Tuesday");
                    // }
                  }),

              //Wednesday
              DayButton(
                  text: "Wednesday",
                  onTap: () {
                    Get.to(MealsWeek1Wed());

                    // if (!mealMenu[6].isSelected &&
                    //     !mealMenu[7].isSelected &&
                    //     !mealMenu[8].isSelected) {
                    //   MaterialPageRoute route =
                    //   MaterialPageRoute(builder: (context) => MenuPage_3());
                    //   Navigator.push(context, route);
                    //   mealMenu[6].isSelected = true;
                    //   return;
                    // }
                    //
                    // if (mealMenu[6].isSelected) {
                    //   popUpMessage("Wednesday");
                    // }
                  }),

              //Thursday
              DayButton(
                  text: "Thursday",
                  onTap: () {
                    Get.to(MealsWeek1Thurs());

                    // if (!mealMenu[9].isSelected &&
                    //     !mealMenu[10].isSelected &&
                    //     !mealMenu[11].isSelected) {
                    //   MaterialPageRoute route =
                    //   MaterialPageRoute(builder: (context) => MenuPage_4());
                    //   Navigator.push(context, route);
                    //   mealMenu[9].isSelected = true;
                    //   return;
                    // }
                    //
                    // if (mealMenu[9].isSelected) {
                    //   popUpMessage("Thursday");
                    // }
                  }),

              //Friday
              DayButton(
                  text: "Friday",
                  onTap: () {
                    Get.to(MealsWeek1Fri());

                    // if (!mealMenu[12].isSelected &&
                    //     !mealMenu[13].isSelected &&
                    //     !mealMenu[14].isSelected) {
                    //   MaterialPageRoute route =
                    //   MaterialPageRoute(builder: (context) => MenuPage_5());
                    //   Navigator.push(context, route);
                    //   mealMenu[12].isSelected = true;
                    //   return;
                    // }
                    //
                    // if (mealMenu[12].isSelected) {
                    //   popUpMessage("Friday");
                    // }
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
