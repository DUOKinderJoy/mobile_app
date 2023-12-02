import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/components/select_button.dart';
import 'package:kinder_joy_1/meal_selection/meal_details_page.dart';
import 'package:kinder_joy_1/models/cart.dart';
import 'package:kinder_joy_1/models/meal.dart';
import 'package:provider/provider.dart';

class MealTile extends StatefulWidget {
  final Meal meal;
  final void Function()? onTap;

  const MealTile({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  State<MealTile> createState() => _MealTileState();
}

class _MealTileState extends State<MealTile> {
  @override
  Widget build(BuildContext context) {
    //add to cart method
    void addToCart() {
      //get access to cart
      final cart = context.read<Cart>();

      //add to cart
      cart.addToCart(widget.meal, 1);

      //let the user know it was successful
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            "You have selected \"" +
                widget.meal.name +
                "\" as your child's meal.",
            style: GoogleFonts.ovo(fontSize: 20),
          ),
          actions: [
            //okay button
            IconButton(
              onPressed: () {
                //pop once to remove dialog box
                Navigator.pop(context);

                //pop to Day screen
                Navigator.pop(context);
              },
              icon: Icon(Icons.done),
            )
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                widget.meal.imagePath,
                height: 140,
                width: 150,
              ),
            ),

            //text
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.meal.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 20),
                  ),
                ),

                const SizedBox(height: 5),

                //price
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    '\RM ' + widget.meal.price,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),

                //select button
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SelectButton(onTap: addToCart),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
