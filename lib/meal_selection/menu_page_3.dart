import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/components/meal_tile.dart';
import 'package:kinder_joy_1/meal_selection/meal_details_page.dart';
import 'package:kinder_joy_1/models/cart.dart';
import 'package:provider/provider.dart';

class MenuPage_3 extends StatefulWidget {
  MenuPage_3({super.key});

  @override
  State<MenuPage_3> createState() => _MenuPage_3State();
}

class _MenuPage_3State extends State<MenuPage_3> {
  void navigateToFoodDetails(int index) {
    //get the menu from cart
    final cart = context.read<Cart>(); //?must use provider
    final mealMenu = cart.mealMenu;

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
                      "Wednesday",
                      style: GoogleFonts.ovo(
                          fontSize: 30,
                          color: const Color.fromARGB(255, 235, 182, 182)),
                    )
                  ],
                ),
              ),

              //meal tile
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: mealMenu.length,
                  itemBuilder: (context, index) {
                    if (mealMenu[index].day == 'Wednesday') {
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
