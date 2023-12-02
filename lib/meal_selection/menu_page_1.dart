import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/components/meal_tile.dart';
import 'package:kinder_joy_1/meal_selection/meal_details_page.dart';
import 'package:kinder_joy_1/models/cart.dart';
import 'package:provider/provider.dart';

class MenuPage_1 extends StatefulWidget {
  MenuPage_1({super.key});

  @override
  State<MenuPage_1> createState() => _MenuPage_1State();
}

class _MenuPage_1State extends State<MenuPage_1> {
  // List mealMenu = [
  //   //chicken porridge
  //   Meal(
  //       imagePath: "lib/images/chicken_porridge.png",
  //       name: "Chicken Porridge",
  //       price: "4.90",
  //       description:
  //           "Rice, sliced chicken, sesame oil, thinly sliced spring onion, fried shallots"),

  //   //fried mee hoon
  //   Meal(
  //       imagePath: "lib/images/fried_mee_hoon.png",
  //       name: "Fried Mee Hoon",
  //       price: "5.50",
  //       description:
  //           "Rice vermicelli, egg, luncheon meat, soy sauce, garlic, and"),

  //   //fried rice
  //   Meal(
  //       imagePath: "lib/images/fried_rice.png",
  //       name: "Fried Rice",
  //       price: "5.50",
  //       description:
  //           "Cooked rice, spring onion, eggs, shrimp, soy sauce, and seasonings "),
  // ];

  void navigateToFoodDetails(int index) {
    //get the menu from cart
    final cart = context.read<Cart>(); //?must use provider
    final mealMenu = cart.mealMenu;

    // MaterialPageRoute route = MaterialPageRoute(
    //   builder: (context) => MealDetailsPage(
    //     meal: mealMenu[index],
    //   ),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailsPage(
          meal: mealMenu[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //get the menu from cart
    final cart = context.read<Cart>(); //?must use provider
    final mealMenu = cart.mealMenu;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(""),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Color.fromARGB(255, 222, 134, 163),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'KinderJoy',
                    style: GoogleFonts.ovo(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                  const SizedBox(height: 2),
                ],
              ),
              Text(
                'Menu',
                style: GoogleFonts.ovo(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30),

              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 82, 76, 76),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Monday",
                      style: GoogleFonts.ovo(
                          fontSize: 30,
                          color: const Color.fromARGB(255, 235, 182, 182)),
                    )
                  ],
                ),
              ),

              //meal tile
              Expanded(
                child:
                    // ListView.builder(
                    //   scrollDirection: Axis.vertical,
                    //   itemCount: mealMenu.length,
                    //   itemBuilder: (context, index)
                    //   => MealTile(
                    //     meal: mealMenu[index],
                    //     onTap: () => navigateToFoodDetails(index),
                    //   ),
                    // ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: mealMenu.length,
                      itemBuilder: (context, index) {
                      if (mealMenu[index].day == 'Monday') {
                        return MealTile(
                        meal: mealMenu[index],
                        onTap: () => navigateToFoodDetails(index),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
