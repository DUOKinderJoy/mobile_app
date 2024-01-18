import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kinder_joy_1/meal_selection/cart/cart_list_screen.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_home_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/current_parents.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';
import '../../meal_selection/meals_day.dart';
import '../../models/order.dart';
import '../parentsFragments/parents_order_fragment_screen.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final List<int>? selectedCartIDs;
  final List<Map<String, dynamic>>? selectedCartListItemsInfo;
  final double? totalAmount;

  OrderConfirmationScreen({
    this.selectedCartIDs,
    this.selectedCartListItemsInfo,
    this.totalAmount,
  });

  CurrentParents currentUser = Get.put(CurrentParents());

  saveNewOrderInfo() async {
    String selectedItemsString = selectedCartListItemsInfo!
        .map((eachSelectedItem) => jsonEncode(eachSelectedItem))
        .toList()
        .join("||");

    Order order = Order(
      order_id: 1,
      children_id: currentUser.parents.children_id,
      selectedItems: selectedItemsString,
      totalAmount: totalAmount,
      status: "new",
      week: 1,
      month: "Dec",
    );

    try {
      var res = await http.post(
        Uri.parse(API.addOrder),
        body: order.toJson(),
      );

      if (res.statusCode == 200) {
        var responseBodyOfAddNewOrder = jsonDecode(res.body);

        if (responseBodyOfAddNewOrder["success"] == true) {
          //delete selected items from user cart
          Fluttertoast.showToast(msg: "your new order has been placed Successfully.");

          selectedCartIDs!.forEach((eachSelectedItemCartID) {
            deleteSelectedMealsFromUserCartList(eachSelectedItemCartID);
          });

          Get.to(MealDay());


        } else {
          Fluttertoast.showToast(
              msg: "Error:: \nyour new order do NOT placed.");
        }
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: "Error12: " + errorMsg.toString());
    }
  }

  deleteSelectedMealsFromUserCartList(int cartID) async {
    try {
      var res = await http
          .post(Uri.parse(API.deleteSelectedMealsFromCartList), body: {
        "cart_id": cartID.toString(),
      });

      if (res.statusCode == 200) {
        var responseBodyFromDeleteCart = jsonDecode(res.body);

        if (responseBodyFromDeleteCart["success"] == true) {
          // Fluttertoast.showToast(msg: "your new order has been placed Successfully.");

          Get.to(MealDay());
        }
      } else {
        Fluttertoast.showToast(msg: "Error, Status Code is not 200");
      }
    } catch (errorMessage) {
      print("Error: " + errorMessage.toString());

      Fluttertoast.showToast(msg: "Error: " + errorMessage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  child: Text(
                    "Are you confirm to submit the order for your child?",
                    style: GoogleFonts.ovo(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 8,
                  color: Color.fromARGB(255, 82, 76, 76),
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      saveNewOrderInfo();
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: Text(
                        "Submit Order",
                        style: GoogleFonts.ovo(
                          color: Color.fromARGB(255, 235, 182, 182),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Material(
                  elevation: 8,
                  color: Color.fromARGB(255, 235, 182, 182),
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => CartListScreen());
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: Text(
                        "No",
                        style: GoogleFonts.ovo(
                          color: Color.fromARGB(255, 82, 76, 76),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                //confirm and proceed
                // Obx(()=> Material(
                //   elevation: 8,
                //   color: imageSelectedByte.length > 0 ? Colors.purpleAccent : Colors.grey,
                //   borderRadius: BorderRadius.circular(30),
                //   child: InkWell(
                //     onTap: ()
                //     {
                //       if(imageSelectedByte.length > 0)
                //       {
                //         //save order info
                //         saveNewOrderInfo();
                //       }
                //       else
                //       {
                //         Fluttertoast.showToast(msg: "Please attach the transaction proof / screenshot.");
                //       }
                //     },
                //     borderRadius: BorderRadius.circular(30),
                //     child: const Padding(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 30,
                //         vertical: 12,
                //       ),
                //       child: Text(
                //         "Confirmed & Proceed",
                //         style: TextStyle(
                //           color: Colors.white70,
                //           fontSize: 16,
                //         ),
                //       ),
                //     ),
                //   ),
                // )),
              ],
            ),
          ),
        ]));
  }
}
