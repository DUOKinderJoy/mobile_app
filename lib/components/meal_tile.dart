// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:kinder_joy_1/api_connection/api_connection.dart';
// import 'package:kinder_joy_1/components/select_button.dart';
// import 'package:kinder_joy_1/meal_selection/meal_details_page.dart';
// import 'package:kinder_joy_1/models/cart.dart';
// import 'package:kinder_joy_1/models/meal.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
//
// class MealTile extends StatefulWidget {
//   final Meal meal;
//   final void Function()? onTap;
//
//   const MealTile({
//     super.key,
//     required this.meal,
//     required this.onTap,
//   });
//
//   @override
//   State<MealTile> createState() => _MealTileState();
// }
//
// class _MealTileState extends State<MealTile> {
//   @override
//   Widget build(BuildContext context) {
//     // add to cart resource
//     addMealToCart() async
//     //but i dun need to use controller in this case
//         {
//       Meal mealModel = Meal(
//         id: widget.meal.id,
//         imagePath: widget.meal.imagePath,
//         name: widget.meal.name,
//         price: widget.meal.price,
//         description: widget.meal.description,
//         day: widget.meal.day,
//         isSelected: widget.meal.isSelected,
//       );
//
//       try {
//         var res = await http.post(
//           Uri.parse(API.createMeal),
//           body: mealModel.toJson(),
//         );
//
//         if (res.statusCode == 200) {
//           var resBodyOfMeal = jsonDecode(res.body);
//           if (resBodyOfMeal['success'] == true) {
//             Fluttertoast.showToast(msg: "Added to Cart");
//           } else {
//             Fluttertoast.showToast(msg: "Error Occured, try again.");
//           }
//         }
//       } catch (e) {
//         // print(e.toString());
//         Fluttertoast.showToast(msg: "Successfully added to Cart");
//       }
//     }
//
//     //add to cart method
//     void addToCart() {
//       //get access to cart
//       final cart = context.read<Cart>();
//
//       //mark the selected meal as selected where the condition is true
//       widget.meal.isSelected = true;
//
//       //add to cart
//       cart.addToCart(widget.meal, 1);
//
//       //let the user know it was successful
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           content: Text(
//             "You have selected \"" +
//                 widget.meal.name +
//                 "\" as your child's meal.",
//             style: GoogleFonts.ovo(fontSize: 20),
//           ),
//           actions: [
//             //okay button
//             IconButton(
//               onPressed: () {
//                 //pop once to remove dialog box
//                 Navigator.pop(context);
//
//                 //pop to Day screen
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.done),
//             )
//           ],
//         ),
//       );
//
//       addMealToCart();
//     }
//
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           borderRadius: BorderRadius.circular(20),
//         ),
//         margin: const EdgeInsets.all(15),
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //image
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset(
//                 widget.meal.imagePath,
//                 height: 140,
//                 width: 150,
//               ),
//             ),
//
//             //text
//             Column(
//               //mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Text(
//                     widget.meal.name,
//                     style: GoogleFonts.dmSerifDisplay(fontSize: 20),
//                   ),
//                 ),
//
//                 const SizedBox(height: 5),
//
//                 //price
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15.0),
//                   child: Text(
//                     '\RM ' + widget.meal.price,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey[700],
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//
//                 //select button
//                 Padding(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   child: SelectButton(onTap: addToCart),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }