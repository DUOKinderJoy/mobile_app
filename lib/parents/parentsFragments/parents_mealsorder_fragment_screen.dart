import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart' as FlutterMaterial;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/current_parents.dart';

import '../../api_connection/api_connection.dart';
import '../../models/fee.dart';
import '../../models/order.dart';
import '../studyFee/studyFeeController.dart';
import '../studyFee/tryStripe.dart';


class MealOrderPage extends StatelessWidget
{

  final currentOnlineUser = Get.put(CurrentParents());
  final feeListController = Get.put(StudyFeeController()); //access the methods

  Map<String, dynamic>? paymentIntent;
  var clientkey = "sk_test_51OOBkICvnNFxCr3XyEcCUlFExFjaVdsfKTHJjFCyKxn04AivLF45WH6DSnsasOHD4bqFE0glkA8R90VmeN5MokzA00kA6b6y2s"; // Secret Key



  Future<List<Order>> getCurrentUserOrdersList() async
  {
    List<Order> ordersListOfCurrentUser = [];

    try
    {
      var res = await http.post(
          Uri.parse(API.readOrders),
          body:
          {
            "currentOnlineUserID": currentOnlineUser.parents.children_id,
          }
      );

      if (res.statusCode == 200)
      {
        var responseBodyOfCurrentUserOrdersList = jsonDecode(res.body);

        if (responseBodyOfCurrentUserOrdersList['success'] == true)
        {
          (responseBodyOfCurrentUserOrdersList['currentUserOrdersData'] as List).forEach((eachCurrentUserOrderData)
          {
            ordersListOfCurrentUser.add(Order.fromJson(eachCurrentUserOrderData));
          });
        }
        feeListController.setList(ordersListOfCurrentUser);
        calculateTotalAmount();

      }
      else
      {
        Fluttertoast.showToast(msg: "Status Code is not 200");
      }
    }
    catch(errorMsg)
    {
      Fluttertoast.showToast(msg: "Error:: " + errorMsg.toString());
    }

    return ordersListOfCurrentUser;
  }

  calculateTotalAmount()
  {
    feeListController.setTotal(0);

    // if(feeListController.selectedMealList.length > 0)
    // {
      feeListController.feeList.forEach((itemInCart)
      {
        // if(feeListController.selectedMealList.contains(itemInCart.order_id))
        // {
          double eachItemTotalAmount = (itemInCart.totalAmount!);

          feeListController.setTotal(feeListController.total + eachItemTotalAmount);
        // }
      });
      feeListController.setTotal(feeListController.total + 400 + 200);
    // }
  }

  calculateTotalOrderAmount()
  {
    feeListController.setTotalOrder(0);
    feeListController.setTotalOrder(feeListController.total - 400 - 200);


    //
    // if(feeListController.selectedMealList.length > 0)
    // {
    // feeListController.feeList.forEach((itemInCart)
    // {
    //   // if(feeListController.selectedMealList.contains(itemInCart.order_id))
    //   // {
    //   double eachItemTotalAmount = (itemInCart.totalAmount!);
    //
    //   feeListController.setTotalOrder(feeListController.totalOrder + eachItemTotalAmount);
    //
    //   // }
    // });
    // feeListController.setTotalOrder(0);
    //
    // // if(feeListController.selectedMealList.length > 0)
    // // {
    // feeListController.feeList.forEach((itemInCart)
    // {
    //   // if(feeListController.selectedMealList.contains(itemInCart.order_id))
    //   // {
    //   double eachItemTotalAmount = (itemInCart.totalAmount!);
    //
    //   feeListController.setTotalOrder(feeListController.totalOrder + eachItemTotalAmount);
    //   // }
    // });
    // // feeListController.setTotal(feeListController.total + 400 + 200);
    // // }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount) * 100).round();
    return calculatedAmount.toString();
  }

  Future<void> handlePayment() async {
    try {
      Map<String, dynamic>? paymentIntent =
      await createPaymentIntent(feeListController.total.toString(), 'MYR');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          applePay: null,
          googlePay: null,
          style: ThemeMode.light,
          merchantDisplayName: 'someMerchantName',
        ),
      );

      await Stripe.instance.presentPaymentSheet().then((value) {
        // Handle success
        Fluttertoast.showToast(msg: "Payment successful");
        saveNewPaymentInfo();
      }).onError((error, stackTrace) {
        // Handle error
        log('Error: $error');
        Fluttertoast.showToast(msg: "Payment failed");
      });
    } catch (e) {
      log('Exception: $e');
      Fluttertoast.showToast(msg: "Payment failed");
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ' + clientkey,
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      log('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      log('err charging user: ${err.toString()}');
      return null;
    }
  }


  // createPaymentIntent(String amount, String currency) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': calculateAmount(amount),
  //       'currency': currency,
  //       'payment_method_types[]': 'card'
  //     };
  //
  //     var response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       headers: {
  //         'Authorization': 'Bearer ' + clientkey,
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       },
  //       body: body,
  //     );
  //
  //     log('Payment Intent Body->>> ${response.body.toString()}');
  //     return jsonDecode(response.body);
  //   } catch (err) {
  //     log('err charging user: ${err.toString()}');
  //   }
  // }

  // calculateAmount(String amount) {
  //   final calculatedAmout = (double.parse(amount)) * 100;
  //   return calculatedAmout.toString();
  // }

  saveNewPaymentInfo() async
  {
    Fee fee = Fee(
      fee_id: 1,
      children_id: currentOnlineUser.parents.children_id,
      study_fee: 400,
      meals_fee: feeListController.totalOrder,
      service_fee: 200,
      total_amount: feeListController.total,
      payment_status: "Paid",
      months: "Sep",
    );

    try
    {
      var res = await http.post(
        Uri.parse(API.addFee),
        body: fee.toJson(),
      );

      if (res.statusCode == 200)
      {
        var responseBodyOfAddNewOrder = jsonDecode(res.body);

        if(responseBodyOfAddNewOrder["success"] == true)
        {
          //delete selected items from user cart
          feeListController.selectedFeeList!.forEach((eachSelectedItemCartID)
          {
            feeListController.deleteSelectedFee(eachSelectedItemCartID);
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


  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: NetworkImage(
        "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
    ),
    fit: BoxFit.cover,
    ),
    ),
    child: Scaffold(
    backgroundColor: Colors.transparent,
    body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Order image       //history image
          //myOrder title     //history title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                //order icon image
                // my orders
                const FlutterMaterial.Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      // Image.asset(
                      //   "images/orders_icon.png",
                      //   width: 140,
                      // ),
                      Text(
                        "STUDY FEE DETAILS",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                //history icon image
                // history
                GestureDetector(
                  onTap: ()
                  {
                    //send user to orders history screen
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Image.asset(
                        //   "images/history_icon.png",
                        //   width: 45,
                        // ),
                        // Text(
                        //   "History",
                        //   style: TextStyle(
                        //     color: Colors.purpleAccent,
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),

          //some info
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "Fee details in September",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black38,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          //displaying the user orderList
          Expanded(
            child: displayOrdersList(context),
          ),
          Expanded(
            child: GestureDetector(
              onTap: ()
              {
                feeListController.feeList.forEach((eachItem)
                {
                  feeListController.addSelectedFee(eachItem.order_id!);
                });
                calculateTotalOrderAmount();
                //
                // calculateTotalAmount();
                // Get.to(MealDetailsScreen(mealInfo: mealsModel));
              },
              child: Container(
                // margin: EdgeInsets.fromLTRB(
                //   0,
                //   // index == 0 ? 16 : 8,
                //   16,
                //   // index == cartListController.cartList.length - 1 ? 16 : 8,
                // ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white70,
                  boxShadow:
                  const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 6,
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: Row(
                  children: [

                    //name
                    //color size + price
                    //+ 2 -
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),

                            //name
                            const Text(
                              "Study Fee : RM 400",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              "Service Fee : RM 200",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              "Meals Fee :" + feeListController.totalOrder.toStringAsFixed(2),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //item image
                    // ClipRRect(
                    //   borderRadius: const BorderRadius.only(
                    //     topRight: Radius.circular(22),
                    //     bottomRight: Radius.circular(22),
                    //   ),
                    //   child: FadeInImage(
                    //     height: 185,
                    //     width: 150,
                    //     fit: BoxFit.cover,
                    //     placeholder: const AssetImage("images/background.jpg"),
                    //     // image: NetworkImage(
                    //     //   // cartModel.image!,
                    //     // ),
                    //     imageErrorBuilder: (context, error, stackTraceError)
                    //     {
                    //       return const Center(
                    //         child: Icon(
                    //           Icons.broken_image_outlined,
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),

                  ],
                ),
              ),
            ),
          ),


        ],
      ),
      bottomNavigationBar: GetBuilder(
        init: StudyFeeController(),
        builder: (c)
        {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -3),
                  color: Colors.white24,
                  blurRadius: 6,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [

                //total amount
                const Text(
                  "Total Amount:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Obx(()=>
                    Text(
                      "\RM " + feeListController.total.toStringAsFixed(2),
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ),

                const Spacer(),

                //order now btn
                Material(
                  color: feeListController.selectedFeeList.length > 0
                      ? Colors.purpleAccent
                      : Colors.white24,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: ()
                    async {
                      await handlePayment();
                      // Get.to(PaymentScreen());
                      // feeListController.selectedFeeList.length > 0
                      //     ? Get.to(PaymentScreen(
                      //   // selectedCartListItemsInfo: getSelectedCartListItemsInformation(),
                      //   // totalAmount: cartListController.total,
                      //   // selectedCartIDs: cartListController.selectedMealList,
                      // ))
                      //     : null;
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Text(
                        "Pay now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          );
        },
      ),
    ),
    );
  }

  Widget displayOrdersList(context)
  {
    return FutureBuilder(
      future: getCurrentUserOrdersList(),
      builder: (context, AsyncSnapshot<List<Order>> dataSnapshot)
      {
        if(dataSnapshot.connectionState == ConnectionState.waiting)
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  "Connection Waiting...",
                  style: TextStyle(color: Colors.black38,),
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
        if(dataSnapshot.data == null)
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                    "No orders found yet...",
                  style: TextStyle(color: Colors.black38,),
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
        if(dataSnapshot.data!.length > 0)
        {
          List<Order> orderList = dataSnapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index)
            {
              return const Divider(
                height: 1,
                thickness: 1,
              );
            },
            itemCount: orderList.length,
            itemBuilder: (context, index)
            {
              Order eachOrderData = orderList[index];

              return FlutterMaterial.Card(
                color: Colors.white24,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: ListTile(
                    onTap: ()
                    {
                      // Get.to(OrderDetailsScreen(
                      //   clickedOrderInfo: eachOrderData,
                      // ));
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "Order ID # " + eachOrderData.order_id.toString(),
                        //   style: const TextStyle(
                        //     fontSize: 16,
                        //     color: Colors.black38,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        Text(
                          "Month:  " + eachOrderData.month.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Week:  " + eachOrderData.week.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Amount: \RM " + eachOrderData.totalAmount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text(
                        //   "Status: " + eachOrderData.status.toString(),
                        //   style: const TextStyle(
                        //     fontSize: 16,
                        //     color: Colors.black38,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                    // trailing: Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //
                    //     //date
                    //     //time
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.end,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //
                    //         //date
                    //         // Text(
                    //         //   DateFormat(
                    //         //     "dd MMMM, yyyy"
                    //         //   ).format(eachOrderData.dateTime!),
                    //         //   style: const TextStyle(
                    //         //       color: Colors.black38,
                    //         //   ),
                    //         // ),
                    //         //
                    //         // const SizedBox(height: 4),
                    //         //
                    //         // //time
                    //         // Text(
                    //         //   DateFormat(
                    //         //       "hh:mm a"
                    //         //   ).format(eachOrderData.dateTime!),
                    //         //   style: const TextStyle(
                    //         //     color: Colors.black38,
                    //         //   ),
                    //         // ),
                    //
                    //       ],
                    //     ),
                    //
                    //     const SizedBox(width: 6),
                    //
                    //     const Icon(
                    //       Icons.navigate_next,
                    //       color: Colors.purpleAccent,
                    //     ),
                    //
                    //   ],
                    // ),
                  ),
                ),
              );
            },
          );
        }
        else
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  "Nothing to show...",
                  style: TextStyle(color: Colors.black38,),
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
      },
    );
  }
}
