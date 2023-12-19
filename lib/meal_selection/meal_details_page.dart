import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/api_connection/api_connection.dart';
import 'package:kinder_joy_1/components/button.dart';
import 'package:kinder_joy_1/components/my_day.dart';
import 'package:kinder_joy_1/models/cart.dart';
import 'package:kinder_joy_1/models/meal.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MealDetailsPage extends StatefulWidget {
  final Meal meal;

  const MealDetailsPage({
    super.key,
    required this.meal,
  });

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  @override
  Widget build(BuildContext context) {
    addMealToCart() async
    //but i dun need to use controller in this case
    {
      Meal mealModel = Meal(
        id: widget.meal.id,
        imagePath: widget.meal.imagePath,
        name: widget.meal.name,
        price: widget.meal.price,
        description: widget.meal.description,
        day: widget.meal.day,
        isSelected: widget.meal.isSelected,
      );

      try {
        var res = await http.post(
          Uri.parse(API.createMeal),
          body: mealModel.toJson(),
        );

        if (res.statusCode == 200) {
          var resBodyOfMeal = jsonDecode(res.body);
          if (resBodyOfMeal['success'] == true) {
            Fluttertoast.showToast(msg: "Added to Cart");
          } else {
            Fluttertoast.showToast(msg: "Error Occured, try again.");
          }
        }
      } catch (e) {
        // print(e.toString());
        Fluttertoast.showToast(msg:"Successfully added to Cart");
      }
    }

    //quantity
    int quantityCount = 0;

    //add to cart method
    void addToCart() {
      //get access to cart
      final cart = context.read<Cart>();

    //mark the selected meal as selected where the condition is true
    widget.meal.isSelected = true;

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
            // TextButton
            TextButton(
              onPressed: () {
                // pop to day page
                Navigator.pop(context);
                Navigator.pop(context);
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

      //connect to sql
      addMealToCart();
    }

    return Scaffold(
      appBar: AppBar(
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
            // mainAxisAlignment: MainAxisAlignment.center,
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
                'Meal Selection',
                style: GoogleFonts.ovo(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30),

              MyDay(text: widget.meal.day),

              //meal name
              Text(
                widget.meal.name,
                style: GoogleFonts.ovo(
                  fontSize: 25,
                  color: Colors.black,
                  height: 2,
                ),
              ),

              const SizedBox(height: 10),

              //meal image
              Image.asset(
                widget.meal.imagePath,
                height: 200,
              ),

              //meal descriptions
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Ingredients: ",
                      style: GoogleFonts.ovo(
                        fontSize: 20,
                        color: Colors.black,
                        height: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  widget.meal.description,
                  style: GoogleFonts.ovo(
                    fontSize: 17,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              //note to teacher
              //text
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Note to teacher(Optional): ",
                      style: GoogleFonts.ovo(
                        fontSize: 15,
                        color: Colors.black,
                        height: 2,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              //remarks
              const SizedBox(
                height: 168,
                width: 400,
                child: TextField(
                  decoration: InputDecoration(
                    label: Text('Remarks'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              //add to cart
              MyButton(text: "Select", onTap: addToCart)
            ],
          ),
        ],
      ),
    );
  }
}
