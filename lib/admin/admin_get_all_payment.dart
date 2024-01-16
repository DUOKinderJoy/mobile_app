import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/current_parents.dart';

import '../../api_connection/api_connection.dart';
import '../models/fee.dart';
import '../models/order.dart';


class AdminGetAllPaymentScreen extends StatelessWidget
{
  final currentOnlineUser = Get.put(CurrentParents());


  Future<List<Fee>> getAllFeeList() async
  {
    List<Fee> feeList = [];

    try
    {
      var res = await http.post(
          Uri.parse(API.adminGetAllPayments),
          body:
          {

          }
      );

      if (res.statusCode == 200)
      {
        var responseBodyOfCurrentUserFeeList = jsonDecode(res.body);

        if (responseBodyOfCurrentUserFeeList['success'] == true)
        {
          (responseBodyOfCurrentUserFeeList['allFeeData'] as List).forEach((eachFeeData)
          {
            feeList.add(Fee.fromJson(eachFeeData));
          });
        }
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

    return feeList;
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //order icon image
                // my orders
                Column(
                  children: [
                    Image.asset(
                      "assets/people.png",
                      width: 140,
                    ),
                    const Text(
                      "Payment Received",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //some info
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "All the payment received",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //displaying the user orderList
          Expanded(
            child: displayOrdersList(context),
          ),

        ],
      ),
    ),
    );
  }

  Widget displayOrdersList(context)
  {
    return FutureBuilder(
      future: getAllFeeList(),
      builder: (context, AsyncSnapshot<List<Fee>> dataSnapshot)
      {
        if(dataSnapshot.connectionState == ConnectionState.waiting)
        {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  "Connection Waiting...",
                  style: TextStyle(color: Colors.grey,),
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
                  "No payment found yet...",
                  style: TextStyle(color: Colors.grey,),
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
          List<Fee> feeList = dataSnapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index)
            {
              return const Divider(
                height: 1,
                thickness: 1,
              );
            },
            itemCount: feeList.length,
            itemBuilder: (context, index)
            {
              Fee eachFeeData = feeList[index];

              return Card(
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
                        Text(
                          "Month: " + eachFeeData.months.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Children ID: " + eachFeeData.children_id.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Amount: \RM " + eachFeeData.total_amount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        //date
                        //time
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            //date
                            // Text(
                            //   DateFormat(
                            //       "dd MMMM, yyyy"
                            //   ).format(eachOrderData.dateTime!),
                            //   style: const TextStyle(
                            //     color: Colors.grey,
                            //   ),
                            // ),

                            const SizedBox(height: 4),

                            //time
                            // Text(
                            //   DateFormat(
                            //       "hh:mm a"
                            //   ).format(eachOrderData.dateTime!),
                            //   style: const TextStyle(
                            //     color: Colors.grey,
                            //   ),
                            // ),

                          ],
                        ),

                        const SizedBox(width: 6),

                        const Icon(
                          Icons.navigate_next,
                          color: Colors.purpleAccent,
                        ),

                      ],
                    ),
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
                  style: TextStyle(color: Colors.grey,),
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
