// import 'package:flutter/material.dart';
// import 'package:kinder_joy_1/components/day_button.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:kinder_joy_1/meal_selection/menu_page_1.dart';
// import 'package:kinder_joy_1/meal_selection/menu_page_2.dart';
// import 'package:kinder_joy_1/meal_selection/menu_page_3.dart';
// import 'package:kinder_joy_1/meal_selection/menu_page_4.dart';
// import 'package:kinder_joy_1/meal_selection/menu_page_5.dart';
// import 'package:kinder_joy_1/models/cart.dart';
// import 'package:provider/provider.dart';
//
// class MealHomePage extends StatelessWidget {
//   const MealHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     //get the menu from cart
//     final cart = context.read<Cart>(); //?must use provider
//     final mealMenu = cart.mealMenu;
//
//     void popUpMessage(String text) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           content: Text(
//             "You have selected your child's meal on "+text,
//             style: GoogleFonts.ovo(fontSize: 20),
//           ),
//           actions: [
//             // TextButton
//             TextButton(
//               onPressed: () {
//                 // pop once to remove dialog box
//                 Navigator.pop(context);
//                 // Navigator.pop(context);
//                 // Navigator.pop(context);
//               },
//               child: const Text(
//                 'Done',
//                 style: TextStyle(
//                     color: Colors.black), // You can customize the color
//               ),
//             )
//           ],
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(""),
//         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         foregroundColor: const Color.fromARGB(255, 222, 134, 163),
//         actions: [
//           //cart button
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, "/cartpage");
//             },
//             icon: Icon(Icons.shopping_bag),
//           )
//         ],
//       ),
//       body: Stack(
//         children: [
//           //background image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                   "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'KinderJoy',
//                 style: GoogleFonts.ovo(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 45,
//                 ),
//               ),
//               const SizedBox(height: 0),
//
//               Text(
//                 'Meals Selection',
//                 style: GoogleFonts.ovo(
//                   color: Colors.black,
//                   fontSize: 25,
//                 ),
//               ),
//               const SizedBox(height: 30),
//
//               //Monday
//               DayButton(
//                   text: "Monday",
//                   onTap: () {
//                     if (!mealMenu[0].isSelected &&
//                         !mealMenu[1].isSelected &&
//                         !mealMenu[2].isSelected) {
//                       MaterialPageRoute route =
//                       MaterialPageRoute(builder: (context) => MenuPage_1());
//                       Navigator.push(context, route);
//                       mealMenu[0].isSelected = true;
//                       return;
//                     }
//
//                     if (mealMenu[0].isSelected) {
//                       popUpMessage("Monday");
//                     }
//                   }),
//
//               //Tuesday
//               DayButton(
//                   text: "Tuesday",
//                   onTap: () {
//                     if (!mealMenu[3].isSelected &&
//                         !mealMenu[4].isSelected &&
//                         !mealMenu[5].isSelected) {
//                       MaterialPageRoute route =
//                       MaterialPageRoute(builder: (context) => MenuPage_2());
//                       Navigator.push(context, route);
//                       mealMenu[3].isSelected = true;
//                       return;
//                     }
//
//                     if (mealMenu[3].isSelected) {
//                       popUpMessage("Tuesday");
//                     }
//                   }),
//
//               //Wednesday
//               DayButton(
//                   text: "Wednesday",
//                   onTap: () {
//                     if (!mealMenu[6].isSelected &&
//                         !mealMenu[7].isSelected &&
//                         !mealMenu[8].isSelected) {
//                       MaterialPageRoute route =
//                       MaterialPageRoute(builder: (context) => MenuPage_3());
//                       Navigator.push(context, route);
//                       mealMenu[6].isSelected = true;
//                       return;
//                     }
//
//                     if (mealMenu[6].isSelected) {
//                       popUpMessage("Wednesday");
//                     }
//                   }),
//
//               //Thursday
//               DayButton(
//                   text: "Thursday",
//                   onTap: () {
//                     if (!mealMenu[9].isSelected &&
//                         !mealMenu[10].isSelected &&
//                         !mealMenu[11].isSelected) {
//                       MaterialPageRoute route =
//                       MaterialPageRoute(builder: (context) => MenuPage_4());
//                       Navigator.push(context, route);
//                       mealMenu[9].isSelected = true;
//                       return;
//                     }
//
//                     if (mealMenu[9].isSelected) {
//                       popUpMessage("Thursday");
//                     }
//                   }),
//
//               //Friday
//               DayButton(
//                   text: "Friday",
//                   onTap: () {
//                     if (!mealMenu[12].isSelected &&
//                         !mealMenu[13].isSelected &&
//                         !mealMenu[14].isSelected) {
//                       MaterialPageRoute route =
//                       MaterialPageRoute(builder: (context) => MenuPage_5());
//                       Navigator.push(context, route);
//                       mealMenu[12].isSelected = true;
//                       return;
//                     }
//
//                     if (mealMenu[12].isSelected) {
//                       popUpMessage("Friday");
//                     }
//                   }),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }