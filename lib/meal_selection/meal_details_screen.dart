import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/meal_selection/meals_day.dart';
import 'package:kinder_joy_1/parents/parentsModel/dashboard.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/current_parents.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart/cart_list_screen.dart';
import 'controller/meal_details_controller.dart';
import '../api_connection/api_connection.dart';
import '../models/meal.dart';

class MealDetailsScreen extends StatefulWidget {
  final Meals? mealInfo;
  // final Remark? remark;

  MealDetailsScreen({
    this.mealInfo,
    // this.remark,
  });

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  final mealDetailsController = Get.put(MealDetailsController());
  // final mealDetailsController = Get.put(mealDetailsController());
  final currentOnlineUser = Get.put(CurrentParents());
  bool _mealSelected = false;

  addMealToCart() async {
    try {
      var res = await http.post(
        Uri.parse(API.addToCart),
        body: {
          "children_id": currentOnlineUser.parents.children_id.toString(),
          "meal_id": widget.mealInfo!.meal_id.toString(),
          "quantity": mealDetailsController.quantity.toString(),
          "options": widget.mealInfo!.options![mealDetailsController.option],
          //add month
          //add week
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfAddCart = jsonDecode(res.body);
        if (resBodyOfAddCart['success'] == true) {
          Fluttertoast.showToast(msg: "Meal saved to Cart Successfully.");
        } else {
          Fluttertoast.showToast(
              msg: "Error Occur. Meal not saved to Cart and Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error :: " + errorMsg.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Meals image
          FadeInImage(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            placeholder: const AssetImage("images/background.jpg"),
            image: NetworkImage(
              widget.mealInfo!.image!,
            ),
            imageErrorBuilder: (context, error, stackTraceError) {
              return const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                ),
              );
            },
          ),

          //Meal information
          Align(
            alignment: Alignment.bottomCenter,
            child: mealInfoWidget(),
          ),

          //3 buttons || back - favorite - shopping cart
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  //back
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.deepPurple,
                    ),
                  ),

                  const Spacer(),

                  //favorite

                  //shopping cart icon
                  IconButton(
                    onPressed: () {
                      Get.to(CartListScreen());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  mealInfoWidget() {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.6,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
          ),
          fit: BoxFit.cover,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Colors.deepPurple,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 18,
            ),

            // Center(
            //   child: Container(
            //     height: 8,
            //     width: 140,
            //     decoration: BoxDecoration(
            //       color: Colors.deepPurple,
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //   ),
            // ),

            const SizedBox(
              height: 30,
            ),

            //name
            Text(
              widget.mealInfo!.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            //details
            //price
            //quantity item counter
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //rating + rating num
                //tags
                //price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //month week
                      Text(
                        widget.mealInfo!.month! +
                            " Week " +
                            widget.mealInfo!.week!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),

                      Text(
                        widget.mealInfo!.days! + "day",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
//quantity obx here
                //quantity item counter
                // Obx(
                //       ()=> Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       //+
                //       IconButton(
                //         onPressed: ()
                //         {
                //           mealDetailsController.setQuantityItem(mealDetailsController.quantity + 1);
                //         },
                //         icon: const Icon(Icons.add_circle_outline, color: Colors.white,),
                //       ),
                //       Text(
                //         mealDetailsController.quantity.toString(),
                //         style: const TextStyle(
                //           fontSize: 20,
                //           color: Colors.purpleAccent,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       //-
                //       IconButton(
                //         onPressed: ()
                //         {
                //           if(mealDetailsController.quantity - 1 >= 1)
                //           {
                //             mealDetailsController.setQuantityItem(mealDetailsController.quantity - 1);
                //           }
                //           else
                //           {
                //             Fluttertoast.showToast(msg: "Quantity must be 1 or greater than 1");
                //           }
                //         },
                //         icon: const Icon(Icons.remove_circle_outline, color: Colors.white,),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 30),

            //sizes
            // Text(
            //   "Options:",
            //   style: GoogleFonts.ovo(
            //     fontSize: 18,
            //     color: Colors.black,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const SizedBox(height: 8),
            // Wrap(
            //   runSpacing: 8,
            //   spacing: 8,
            //   children:
            //       List.generate(widget.mealInfo!.options!.length, (index) {
            //     return Obx(
            //       () => GestureDetector(
            //         onTap: () {
            //           mealDetailsController.setOptionMeal(index);
            //         },
            //         child: Container(
            //           height: 35,
            //           width: 60,
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //               width: 2,
            //               color: mealDetailsController.size == index
            //                   ? Colors.transparent
            //                   : Colors.grey,
            //             ),
            //             color: mealDetailsController.size == index
            //                 ? Colors.purpleAccent.withOpacity(0.4)
            //                 : Colors.amberAccent,
            //           ),
            //           alignment: Alignment.center,
            //           child: Text(
            //             widget.mealInfo!.options![index]
            //                 .replaceAll("[", "")
            //                 .replaceAll("]", ""),
            //             style: TextStyle(
            //               fontSize: 10,
            //               color: Colors.grey[700],
            //             ),
            //           ),
            //         ),
            //       ),
            //     );
            //   }),
            // ),

            const SizedBox(height: 30),

            //description
            Text(
              "Description:",
              style: GoogleFonts.ovo(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.mealInfo!.description!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 120),

            //add to cart button
            Material(
              elevation: 4,
              color: Color.fromARGB(255, 82, 76, 76),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  // if (!widget.m) {
                  //   addMealToCart();
                  //   setState(() {
                  //     _mealSelected = true;
                  //   });
                  //   Get.to(() => MealDay());
                  // }

                  addMealToCart();
                  Get.to(() => MealDay());

                  // // doing remarks
                  // if (widget.mealInfo!.days! == "Mon") {
                  //   widget.remark!.mon = true;
                  // }
                  // if (widget.mealInfo!.days! == "Tues") {
                  //   widget.remark!.tues = true;
                  // }
                  // if (widget.mealInfo!.days! == "Wed") {
                  //   widget.remark!.wed = true;
                  // }
                  // if (widget.mealInfo!.days! == "Thurs") {
                  //   widget.remark!.thu = true;
                  // }
                  // if (widget.mealInfo!.days! == "Fri") {
                  //   widget.remark!.fri = true;
                  // }
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  // alignment: Alignment.center,
                  height: 50,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Select Meal",
                        style: GoogleFonts.ovo(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 235, 182, 182),
                        ),
                      ),

                      const SizedBox(
                        width: 140,
                      ),

                      //price
                      Text(
                        "RM " + widget.mealInfo!.price.toString() + "0",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 235, 182, 182),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}