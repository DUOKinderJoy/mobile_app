import 'dart:convert';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_home_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/current_parents.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

import '../../api_connection/api_connection.dart';
import '../../models/order.dart';

class OrderConfirmationScreen extends StatelessWidget
{
  final List<int>? selectedCartIDs;
  final List<Map<String, dynamic>>? selectedCartListItemsInfo;
  final double? totalAmount;


  OrderConfirmationScreen({
    this.selectedCartIDs,
    this.selectedCartListItemsInfo,
    this.totalAmount,
  });

  CurrentParents currentUser = Get.put(CurrentParents());

  saveNewOrderInfo() async
  {
    String selectedItemsString = selectedCartListItemsInfo!.map((eachSelectedItem)=> jsonEncode(eachSelectedItem)).toList().join("||");

    Order order = Order(
      order_id: 1,
      children_id: currentUser.parents.children_id,
      selectedItems: selectedItemsString,
      totalAmount: totalAmount,
      status: "new",
      // dateTime: DateTime.now(),
    );

    try
    {
      var res = await http.post(
        Uri.parse(API.addOrder),
      );

      if (res.statusCode == 200)
      {
        var responseBodyOfAddNewOrder = jsonDecode(res.body);

        if(responseBodyOfAddNewOrder["success"] == true)
        {
          //delete selected items from user cart
          selectedCartIDs!.forEach((eachSelectedItemCartID)
          {
            deleteSelectedMealsFromUserCartList(eachSelectedItemCartID);
          });
        }
        else
        {
          Fluttertoast.showToast(msg: "Error:: \nyour new order do NOT placed.");
        }
      }
    }
    catch(errorMsg)
    {
      Fluttertoast.showToast(msg: "Error12: " + errorMsg.toString());
    }
  }

  deleteSelectedMealsFromUserCartList(int cartID) async
  {
    try
    {
      var res = await http.post(
          Uri.parse(API.deleteSelectedMealsFromCartList),
          body:
          {
            "cart_id": cartID.toString(),
          }
      );

      if(res.statusCode == 200)
      {
        var responseBodyFromDeleteCart = jsonDecode(res.body);

        if(responseBodyFromDeleteCart["success"] == true)
        {
          Fluttertoast.showToast(msg: "your new order has been placed Successfully.");

          Get.to(ParentsHomeFragementScreen());
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "Error, Status Code is not 200");
      }
    }
    catch(errorMessage)
    {
      print("Error: " + errorMessage.toString());

      Fluttertoast.showToast(msg: "Error: " + errorMessage.toString());
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              elevation: 8,
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: ()
                {
                  saveNewOrderInfo();
                },
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  child: Text(
                    "Confirm selection",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

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
    );
  }
}

