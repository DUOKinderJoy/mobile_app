import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:kinder_joy_1/meal_selection/meal_details_screen.dart';
import '../../api_connection/api_connection.dart';
import '../models/meal.dart';
import 'cart/cart_list_screen.dart';

class MealsWeek1 extends StatelessWidget
{
  Future<List<Meals>> getMealItems() async
  {
    List<Meals> allMealItemsList = [];

    try
    {
      var res = await http.post(
        Uri.parse(API.getMealWeek1),
        body: {
          "days": "Mon",
        },
      );

      if(res.statusCode == 200)
      {
        var responseBodyOfAllMeals = jsonDecode(res.body);
        if(responseBodyOfAllMeals["success"] == true)
        {
          (responseBodyOfAllMeals["mealData"] as List).forEach((eachRecord)
          {
            allMealItemsList.add(Meals.fromJson(eachRecord));
            // Fluttertoast.showToast(msg: "Status code is 200");
          });
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "Error, status code is not 200");
      }
    }
    catch(errorMsg)
    {
      print("Error:: " + errorMsg.toString());
    }

    return allMealItemsList;
  }

  @override
  Widget build(BuildContext context){
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: NetworkImage(
        "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
    ),
    fit: BoxFit.cover,
    ),
    ),
    child: Scaffold(
    backgroundColor: Colors.transparent, // Set scaffold background to transparent
    body:
    SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16,),

          //search bar widget
          showCartWidget(),

          const SizedBox(height: 24,),

          //all new collections/items
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Meals Week 1 Monday",
              style: TextStyle(
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          allMealWidget(context),
        ],
        ),
    ),
    ),

    );
  }

  Widget showCartWidget()
  {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: AppBar(
        title: const Text(""),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 222, 134, 163),
        actions: [
          IconButton(
              onPressed: ()
              {
                Get.to(CartListScreen());
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.purple,
              )
          ),
          //cart button
          // IconButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, "/cartpage");
          //   },
          //   icon: Icon(Icons.shopping_bag),
          // )
        ],
      ),
    );
  }

  allMealWidget(context)
  {
    return FutureBuilder(
        future: getMealItems(),
        builder: (context, AsyncSnapshot<List<Meals>> dataSnapShot)
        {
          if(dataSnapShot.connectionState == ConnectionState.waiting)
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(dataSnapShot.data == null)
          {
            return const Center(
              child: Text(
                "No Meals found",
              ),
            );
          }
          if(dataSnapShot.data!.length > 0)
          {
            return ListView.builder(
              itemCount: dataSnapShot.data!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index)
              {
                Meals eachMealItemRecord = dataSnapShot.data![index];

                return GestureDetector(
                  onTap: ()
                  {
                    Get.to(MealDetailsScreen(mealInfo: eachMealItemRecord,));
                    // Get.to(ItemDetailsScreen(itemInfo: eachClothItemRecord));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      16,
                      index == dataSnapShot.data!.length - 1 ? 16 : 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow:
                      const [
                        BoxShadow(
                          offset: Offset(0,0),
                          blurRadius: 6,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [

                        //name + price
                        //tags
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                //name and price
                                Row(
                                  children: [

                                    //name
                                    Expanded(
                                      child: Text(
                                        eachMealItemRecord.name!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    //price
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, right: 12),
                                      child: Text(
                                        "\RM " + eachMealItemRecord.price.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.purpleAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                                const SizedBox(height: 16,),

                                Text(
                                  "Day: " + eachMealItemRecord.days!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 16,),

                                //week
                                Text(
                                  eachMealItemRecord.month! + " Week: " + eachMealItemRecord.week!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //image clothes
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: FadeInImage(
                            height: 130,
                            width: 130,
                            fit: BoxFit.cover,
                            placeholder: const AssetImage("images/place_holder.png"),
                            image: NetworkImage(
                              eachMealItemRecord.image!,
                            ),
                            imageErrorBuilder: (context, error, stackTraceError)
                            {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image_outlined,
                                ),
                              );
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            );
          }
          else
          {
            return const Center(
              child: Text("Empty, No Data."),
            );
          }
        }
    );
  }
}

