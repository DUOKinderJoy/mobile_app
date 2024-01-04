import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:kinder_joy_1/meal_selection/meal_details_screen.dart';
import '../../api_connection/api_connection.dart';
import '../models/meal.dart';

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
    return SingleChildScrollView(
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
              "Meals",
              style: TextStyle(
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          allMealWidget(context),
        ],
        )
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
                                          color: Colors.grey,
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
                                    color: Colors.grey,
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
                                    color: Colors.grey,
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

// {
//   TextEditingController searchController = TextEditingController();
//
//
//   // Future<List<Clothes>> getTrendingClothItems() async
//   // {
//   //   List<Clothes> trendingClothItemsList = [];
//   //
//   //   try
//   //   {
//   //     var res = await http.post(
//   //         Uri.parse(API.getTrendingMostPopularClothes)
//   //     );
//   //
//   //     if(res.statusCode == 200)
//   //     {
//   //       var responseBodyOfTrending = jsonDecode(res.body);
//   //       if(responseBodyOfTrending["success"] == true)
//   //       {
//   //         (responseBodyOfTrending["clothItemsData"] as List).forEach((eachRecord)
//   //         {
//   //           trendingClothItemsList.add(Clothes.fromJson(eachRecord));
//   //         });
//   //       }
//   //     }
//   //     else
//   //     {
//   //       Fluttertoast.showToast(msg: "Error, status code is not 200");
//   //     }
//   //   }
//   //   catch(errorMsg)
//   //   {
//   //     print("Error:: " + errorMsg.toString());
//   //   }
//   //
//   //   return trendingClothItemsList;
//   // }
//
//   Future<List<Meals>> getAllMealsItems() async
//   {
//     List<Meals> allMealsItemsList = [];
//
//     try
//     {
//       var res = await http.post(
//           Uri.parse(API.getMealWeek1)
//       );
//
//       if(res.statusCode == 200)
//       {
//         var responseBodyOfAllMeals = jsonDecode(res.body);
//         if(responseBodyOfAllMeals["success"] == true)
//         {
//           (responseBodyOfAllMeals["mealsData"] as List).forEach((eachRecord)
//           {
//             allMealsItemsList.add(Meals.fromJson(eachRecord));
//           });
//         }
//       }
//       else
//       {
//         Fluttertoast.showToast(msg: "Error, status code is not 200");
//       }
//     }
//     catch(errorMsg)
//     {
//       print("Error:: " + errorMsg.toString());
//     }
//
//     return allMealsItemsList;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           const SizedBox(height: 16,),
//
//           //search bar widget
//           showSearchBarWidget(),
//
//           const SizedBox(height: 24,),
//
//           //trending-popular items
//           // const Padding(
//           //   padding: EdgeInsets.symmetric(horizontal: 18),
//           //   child: Text(
//           //     "Trending",
//           //     style: TextStyle(
//           //       color: Colors.purpleAccent,
//           //       fontWeight: FontWeight.bold,
//           //       fontSize: 24,
//           //     ),
//           //   ),
//           // ),
//           // trendingMostPopularClothItemWidget(context),
//
//           const SizedBox(height: 24,),
//
//           //all new collections/items
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 18),
//             child: Text(
//               "Meals",
//               style: TextStyle(
//                 color: Colors.purpleAccent,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//
//           allItemWidget(context),
//
//         ],
//       ),
//     );
//   }
//
//   Widget showSearchBarWidget()
//   {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 18),
//       child: TextField(
//         style: const TextStyle(color: Colors.yellow),
//         controller: searchController,
//         decoration: InputDecoration(
//           prefixIcon: IconButton(
//               onPressed: ()
//               {
//
//               },
//               icon: const Icon(
//                 Icons.search,
//                 color: Colors.purple,
//               )
//           ),
//           hintText: "Search here...",
//           hintStyle: const TextStyle(
//             color: Colors.grey,
//             fontSize: 12,
//           ),
//           // suffixIcon: IconButton(
//           //     onPressed: ()
//           //     {
//           //
//           //     },
//           //     icon: const Icon(
//           //       Icons.shopping_cart,
//           //       color: Colors.purple,
//           //     )
//           // ),
//           border: const OutlineInputBorder(
//               borderSide: BorderSide(
//                 width: 2,
//                 color: Colors.purpleAccent,
//               )
//           ),
//           enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(
//                 width: 2,
//                 color: Colors.purpleAccent,
//               )
//           ),
//           focusedBorder: const OutlineInputBorder(
//               borderSide: BorderSide(
//                 width: 2,
//                 color: Colors.blueAccent,
//               )
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 8,
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget trendingMostPopularClothItemWidget(context)
//   // {
//   //   return FutureBuilder(
//   //     future: getTrendingClothItems(),
//   //     builder: (context, AsyncSnapshot<List<Clothes>> dataSnapShot)
//   //     {
//   //       if(dataSnapShot.connectionState == ConnectionState.waiting)
//   //       {
//   //         return const Center(
//   //           child: CircularProgressIndicator(),
//   //         );
//   //       }
//   //       if(dataSnapShot.data == null)
//   //       {
//   //         return const Center(
//   //           child: Text(
//   //             "No Trending item found",
//   //           ),
//   //         );
//   //       }
//   //       if(dataSnapShot.data!.length > 0)
//   //       {
//   //         return SizedBox(
//   //           height: 260,
//   //           child: ListView.builder(
//   //             itemCount: dataSnapShot.data!.length,
//   //             scrollDirection: Axis.horizontal,
//   //             itemBuilder: (context, index)
//   //             {
//   //               Clothes eachClothItemData = dataSnapShot.data![index];
//   //               return GestureDetector(
//   //                 onTap: ()
//   //                 {
//   //
//   //                 },
//   //                 child: Container(
//   //                   width: 200,
//   //                   margin: EdgeInsets.fromLTRB(
//   //                     index == 0 ? 16 : 8,
//   //                     10,
//   //                     index == dataSnapShot.data!.length - 1 ? 16 : 8,
//   //                     10,
//   //                   ),
//   //                   decoration: BoxDecoration(
//   //                     borderRadius: BorderRadius.circular(20),
//   //                     color: Colors.black,
//   //                     boxShadow:
//   //                     const [
//   //                       BoxShadow(
//   //                         offset: Offset(0,3),
//   //                         blurRadius: 6,
//   //                         color: Colors.grey,
//   //                       ),
//   //                     ],
//   //                   ),
//   //                   child: Column(
//   //                     children: [
//   //
//   //                       //item image
//   //                       ClipRRect(
//   //                         borderRadius: const BorderRadius.only(
//   //                           topLeft: Radius.circular(22),
//   //                           topRight: Radius.circular(22),
//   //                         ),
//   //                         child: FadeInImage(
//   //                           height: 150,
//   //                           width: 200,
//   //                           fit: BoxFit.cover,
//   //                           placeholder: const AssetImage("images/place_holder.png"),
//   //                           image: NetworkImage(
//   //                             eachClothItemData.image!,
//   //                           ),
//   //                           imageErrorBuilder: (context, error, stackTraceError)
//   //                           {
//   //                             return const Center(
//   //                               child: Icon(
//   //                                 Icons.broken_image_outlined,
//   //                               ),
//   //                             );
//   //                           },
//   //                         ),
//   //                       ),
//   //
//   //                       //item name & price
//   //                       //rating stars & rating numbers
//   //                       Padding(
//   //                         padding: const EdgeInsets.all(8.0),
//   //                         child: Column(
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           children: [
//   //
//   //                             //item name & price
//   //                             Row(
//   //                               children: [
//   //                                 Expanded(
//   //                                   child: Text(
//   //                                     eachClothItemData.name!,
//   //                                     maxLines: 2,
//   //                                     overflow: TextOverflow.ellipsis,
//   //                                     style: const TextStyle(
//   //                                       color: Colors.grey,
//   //                                       fontSize: 16,
//   //                                       fontWeight: FontWeight.bold,
//   //                                     ),
//   //                                   ),
//   //                                 ),
//   //                                 const SizedBox(
//   //                                   width: 10,
//   //                                 ),
//   //                                 Text(
//   //                                   eachClothItemData.price.toString(),
//   //                                   style: const TextStyle(
//   //                                     color: Colors.purpleAccent,
//   //                                     fontSize: 18,
//   //                                     fontWeight: FontWeight.bold,
//   //                                   ),
//   //                                 ),
//   //                               ],
//   //                             ),
//   //
//   //                             const SizedBox(height: 8,),
//   //
//   //                             //rating stars & rating numbers
//   //                             Row(
//   //                               children: [
//   //
//   //                                 RatingBar.builder(
//   //                                   initialRating: eachClothItemData.rating!,
//   //                                   minRating: 1,
//   //                                   direction: Axis.horizontal,
//   //                                   allowHalfRating: true,
//   //                                   itemCount: 5,
//   //                                   itemBuilder: (context, c)=> const Icon(
//   //                                     Icons.star,
//   //                                     color: Colors.amber,
//   //                                   ),
//   //                                   onRatingUpdate: (updateRating){},
//   //                                   ignoreGestures: true,
//   //                                   unratedColor: Colors.grey,
//   //                                   itemSize: 20,
//   //                                 ),
//   //
//   //                                 const SizedBox(width: 8,),
//   //
//   //                                 Text(
//   //                                   "(" + eachClothItemData.rating.toString() + ")",
//   //                                   style: const TextStyle(
//   //                                     color: Colors.grey,
//   //                                   ),
//   //                                 ),
//   //
//   //                               ],
//   //                             ),
//   //
//   //                           ],
//   //                         ),
//   //                       ),
//   //
//   //                     ],
//   //                   ),
//   //                 ),
//   //               );
//   //             },
//   //           ),
//   //         );
//   //       }
//   //       else
//   //       {
//   //         return const Center(
//   //           child: Text("Empty, No Data."),
//   //         );
//   //       }
//   //     },
//   //   );
//   // }
//
//   allItemWidget(context)
//   {
//     return FutureBuilder(
//         future: getAllMealsItems(),
//         builder: (context, AsyncSnapshot<List<Meals>> dataSnapShot)
//         {
//           if(dataSnapShot.connectionState == ConnectionState.waiting)
//           {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if(dataSnapShot.data == null)
//           {
//             return const Center(
//               child: Text(
//                 "No meals found",
//               ),
//             );
//           }
//           if(dataSnapShot.data!.length > 0)
//           {
//             return ListView.builder(
//               itemCount: dataSnapShot.data!.length,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               scrollDirection: Axis.vertical,
//               itemBuilder: (context, index)
//               {
//                 Meals eachMealsItemRecord = dataSnapShot.data![index];
//
//                 return GestureDetector(
//                   onTap: ()
//                   {
//                     Get.to(ItemDetailsScreen(itemInfo: eachMealsItemRecord));
//                   },
//                   child: Container(
//                     margin: EdgeInsets.fromLTRB(
//                       16,
//                       index == 0 ? 16 : 8,
//                       16,
//                       index == dataSnapShot.data!.length - 1 ? 16 : 8,
//                     ),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.black,
//                       boxShadow:
//                       const [
//                         BoxShadow(
//                           offset: Offset(0,0),
//                           blurRadius: 6,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//
//                         //name + price
//                         //tags
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 15),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//
//                                 //name and price
//                                 Row(
//                                   children: [
//
//                                     //name
//                                     Expanded(
//                                       child: Text(
//                                         eachMealsItemRecord.name!,
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                           fontSize: 18,
//                                           color: Colors.grey,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//
//                                     //price
//                                     // Padding(
//                                     //   padding: const EdgeInsets.only(left: 12, right: 12),
//                                     //   child: Text(
//                                     //     "\$ " + eachClothItemRecord.price.toString(),
//                                     //     maxLines: 2,
//                                     //     overflow: TextOverflow.ellipsis,
//                                     //     style: const TextStyle(
//                                     //       fontSize: 18,
//                                     //       color: Colors.purpleAccent,
//                                     //       fontWeight: FontWeight.bold,
//                                     //     ),
//                                     //   ),
//                                     // ),
//
//                                   ],
//                                 ),
//
//                                 const SizedBox(height: 16,),
//
//                                 //tags
//                                 Text(
//                                   "Tags: \n" + eachMealsItemRecord.month!,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         ),
//
//                         //image Meals
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             topRight: Radius.circular(20),
//                             bottomRight: Radius.circular(20),
//                           ),
//                           child: FadeInImage(
//                             height: 130,
//                             width: 130,
//                             fit: BoxFit.cover,
//                             placeholder: const AssetImage("images/place_holder.png"),
//                             image: NetworkImage(
//                               eachMealsItemRecord.image!,
//                             ),
//                             imageErrorBuilder: (context, error, stackTraceError)
//                             {
//                               return const Center(
//                                 child: Icon(
//                                   Icons.broken_image_outlined,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           else
//           {
//             return const Center(
//               child: Text("Empty, No Data."),
//             );
//           }
//         }
//     );
//   }
// }
//
// //
// // class ParentsHomeFragementScreen extends StatelessWidget
// // {
// //   TextEditingController searchController = TextEditingController();
// //
// //   Future<List<Dashboard>> getAllDashboardItems() async
// //   {
// //     List<Dashboard> allDashboardItemsList = [];
// //
// //     try
// //     {
// //       var res = await http.post(
// //           Uri.parse(API.getAllItems)
// //       );
// //
// //       if(res.statusCode == 200)
// //       {
// //         var responseBodyOfAllItems = jsonDecode(res.body);
// //         if(responseBodyOfAllItems["success"] == true)
// //         {
// //           (responseBodyOfAllItems["dashboardItemsData"] as List).forEach((eachRecord)
// //           {
// //             allDashboardItemsList.add(Dashboard.fromJson(eachRecord));
// //           });
// //         }
// //       }
// //       else
// //       {
// //         Fluttertoast.showToast(msg: "Error, status code is not 200");
// //       }
// //     }
// //     catch(errorMsg)
// //     {
// //       print("Error:: " + errorMsg.toString());
// //     }
// //
// //     return allDashboardItemsList;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //
// //           const SizedBox(height: 16,),
// //
// //           //search bar widget
// //           showSearchBarWidget(),
// //           const SizedBox(height: 16,),
// //
// //           const Padding(
// //             padding: EdgeInsets.symmetric(horizontal: 16),
// //             child: Text(
// //               "Announcement",
// //               style: TextStyle(
// //                 color: Colors.purpleAccent,
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 24,
// //               )
// //             ),
// //           ),
// //
// //           allItemWidget(context),
// //         ],
// //       ),
// //     );
// //   }
// //   Widget showSearchBarWidget()
// //   {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(horizontal: 18),
// //       child: TextField(
// //         style: const TextStyle(color: Colors.yellow),
// //         controller: searchController,
// //         decoration: InputDecoration(
// //           prefixIcon: IconButton(
// //             onPressed: ()
// //             {
// //
// //             },
// //             icon: const Icon(
// //               Icons.search,
// //               color: Colors.purple,
// //             )
// //           ),
// //           hintText: "Search here...",
// //           hintStyle: const TextStyle(
// //             color: Colors.grey,
// //             fontSize: 12,
// //           ),
// //           // suffixIcon: IconButton(
// //           //     onPressed: ()
// //           //     {
// //           //
// //           //     },
// //           //     icon: const Icon(
// //           //       Icons.shopping_cart,
// //           //       color: Colors.purple,
// //           //     )
// //           // ),
// //           border: const OutlineInputBorder(
// //             borderSide: BorderSide(
// //               width: 2,
// //               color: Colors.purpleAccent,
// //             )
// //           ),
// //           enabledBorder: const OutlineInputBorder(
// //               borderSide: BorderSide(
// //                 width: 2,
// //                 color: Colors.purpleAccent,
// //               )
// //           ),
// //           focusedBorder: const OutlineInputBorder(
// //               borderSide: BorderSide(
// //                 width: 2,
// //                 color: Colors.blueAccent,
// //               )
// //           ),
// //           contentPadding: const EdgeInsets.symmetric(
// //             horizontal: 16,
// //             vertical: 8,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   allItemWidget(context)
// //   {
// //     return FutureBuilder(
// //         future: getAllDashboardItems(),
// //         builder: (context, AsyncSnapshot<List<Dashboard>> dataSnapShot)
// //         {
// //           if(dataSnapShot.connectionState == ConnectionState.waiting)
// //           {
// //             return const Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }
// //           // if(dataSnapShot.data == null)
// //           // {
// //           //   return const Center(
// //           //     child: Text(
// //           //       "No Trending item found",
// //           //     ),
// //           //   );
// //           // }
// //           if(dataSnapShot.data!.length > 0)
// //           {
// //             return ListView.builder(
// //               itemCount: dataSnapShot.data!.length,
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               scrollDirection: Axis.vertical,
// //               itemBuilder: (context, index)
// //               {
// //                 Dashboard eachDashboardItemRecord = dataSnapShot.data![index];
// //
// //                 return GestureDetector(
// //                   onTap: ()
// //                   {
// //
// //                   },
// //                   child: Container(
// //                     margin: EdgeInsets.fromLTRB(
// //                       16,
// //                       index == 0 ? 16 : 8,
// //                       16,
// //                       index == dataSnapShot.data!.length - 1 ? 16 : 8,
// //                     ),
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(20),
// //                       color: Colors.black,
// //                       boxShadow:
// //                       const [
// //                         BoxShadow(
// //                           offset: Offset(0,0),
// //                           blurRadius: 6,
// //                           color: Colors.white,
// //                         ),
// //                       ],
// //                     ),
// //                     child: Row(
// //                       children: [
// //
// //                         //name + price
// //                         //tags
// //                         Expanded(
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(left: 15),
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //
// //                                 //name and price
// //                                 Row(
// //                                   children: [
// //
// //                                     //name
// //                                     Expanded(
// //                                       child: Text(
// //                                         eachDashboardItemRecord.item_name!,
// //                                         maxLines: 2,
// //                                         overflow: TextOverflow.ellipsis,
// //                                         style: const TextStyle(
// //                                           fontSize: 18,
// //                                           color: Colors.grey,
// //                                           fontWeight: FontWeight.bold,
// //                                         ),
// //                                       ),
// //                                     ),
// //
// //                                     //price
// //                                     // Padding(
// //                                     //   padding: const EdgeInsets.only(left: 12, right: 12),
// //                                     //   child: Text(
// //                                     //     "\$ " + eachClothItemRecord.price.toString(),
// //                                     //     maxLines: 2,
// //                                     //     overflow: TextOverflow.ellipsis,
// //                                     //     style: const TextStyle(
// //                                     //       fontSize: 18,
// //                                     //       color: Colors.purpleAccent,
// //                                     //       fontWeight: FontWeight.bold,
// //                                     //     ),
// //                                     //   ),
// //                                     // ),
// //
// //                                   ],
// //                                 ),
// //
// //                                 const SizedBox(height: 16,),
// //
// //                                 //tags
// //                                 Text(
// //                                   "Tags: \n" + eachDashboardItemRecord.item_tags.toString().replaceAll("[", "").replaceAll("]", ""),
// //                                   maxLines: 2,
// //                                   overflow: TextOverflow.ellipsis,
// //                                   style: const TextStyle(
// //                                     fontSize: 12,
// //                                     color: Colors.grey,
// //                                   ),
// //                                 ),
// //
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //
// //                         //image clothes
// //                         ClipRRect(
// //                           borderRadius: const BorderRadius.only(
// //                             topRight: Radius.circular(20),
// //                             bottomRight: Radius.circular(20),
// //                           ),
// //                           child: FadeInImage(
// //                             height: 130,
// //                             width: 130,
// //                             fit: BoxFit.cover,
// //                             placeholder: const AssetImage("images/place_holder.png"),
// //                             image: NetworkImage(
// //                               eachDashboardItemRecord.item_image!,
// //                             ),
// //                             imageErrorBuilder: (context, error, stackTraceError)
// //                             {
// //                               return const Center(
// //                                 child: Icon(
// //                                   Icons.broken_image_outlined,
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ),
// //
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             );
// //           }
// //           else
// //           {
// //             return const Center(
// //               child: Text("Empty, No Data."),
// //             );
// //           }
// //         }
// //     );
// //   }
// // }
// //
