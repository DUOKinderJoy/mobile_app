import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/components/button.dart';
import 'package:kinder_joy_1/models/cart.dart';
import 'package:kinder_joy_1/models/meal.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold();
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Meals",
            style: GoogleFonts.ovo(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          foregroundColor: const Color.fromARGB(255, 222, 134, 163),
        ),

        body: Stack(
          children: [
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
            ListView.builder(
              itemCount: value.cart.length,
              itemBuilder: (context, index) {
                //get meal from cart
                final Meal meal = value.cart[index];

                //get meal day
                final String mealDay = meal.day;

                //get meal name
                final String mealName = meal.name;

                //get meal price
                final String mealPrice = meal.price;

                //return list tile
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: ListTile(
                    title: Text(
                      mealDay,
                      style: GoogleFonts.ovo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mealName,
                          style: GoogleFonts.ovo(
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          "RM " + mealPrice,
                          style: GoogleFonts.ovo(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),

            //Pay Button
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: MyButton(text: "Pay Now", onTap: () {}))
          ],
        ),
      ),
    );
  }
}
