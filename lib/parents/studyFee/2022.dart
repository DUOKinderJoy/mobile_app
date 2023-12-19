import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kinder_joy_1/authentication/roles_op.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/current_parents.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/parents_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:kinder_joy_1/parents/studyFee/tryStripe.dart';
import '../../api_connection/api_connection.dart';


class StudyFeeYear2022 extends StatelessWidget
{
  final CurrentParents _currentParents = Get.put(CurrentParents());


  Widget parentsInfoItemProfile(IconData iconData, String parentsData)
  {
    return Container(   //reusable code
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(width: 16,),
          Text(
            parentsData,
            style: const TextStyle(
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:  NetworkImage(
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
                const Text(
                  'Study fee for',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Text(
                  _currentParents.parents.children_name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  'in year of 2022',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2023 Dec'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentScreen()),
                    );
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 Nov'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 Oct'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 Sep'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 Aug'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 July'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 June'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 May'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 Apr'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 Mar'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 Feb'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('2022 Jan'),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                    //teacher sign up page
                  },
                ),
              ],
            ),
          ),
          // Positioned(
          //   top: 0,
          //   left: 10,
          //   child: IconButton(
          //     icon: const Icon(Icons.arrow_back),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ),
        ],
      ),
    );
    //   ListView(
    //   padding: const EdgeInsets.all(32),
    //
    //   children: [
    //     Center(
    //       child: Image.asset(
    //         "assets/people.png",
    //         width: 240,
    //       ),
    //
    //     ),
    //
    //     const SizedBox(height: 20,),
    //
    //     parentsInfoItemProfile(Icons.people, _currentParents.parents.parents_name),
    //     const SizedBox(height: 20,),
    //
    //     parentsInfoItemProfile(Icons.phone, _currentParents.parents.parents_no),
    //     const SizedBox(height: 20,),
    //
    //     parentsInfoItemProfile(Icons.abc, _currentParents.parents.children_id),
    //     const SizedBox(height: 20,),
    //
    //     parentsInfoItemProfile(Icons.people, _currentParents.parents.children_name),
    //     const SizedBox(height: 20,),
    //
    //     parentsInfoItemProfile(Icons.home, _currentParents.parents.parents_address),
    //     const SizedBox(height: 20,),
    //
    //     Center(
    //       child: Material(
    //         color: Colors.redAccent,
    //         borderRadius: BorderRadius.circular(8),
    //         child: InkWell(
    //           onTap: ()
    //           {
    //             signOutUser();
    //           },
    //           borderRadius: BorderRadius.circular(32),
    //           child: const Padding(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: 30,
    //               vertical: 12,
    //             ),
    //             child: Text(
    //               "Sign Out",
    //               style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 16,
    //               ),
    //
    //             ),
    //           ),
    //
    //         ),
    //       ),
    //
    //     ),
    //     const SizedBox(height: 20,),
    //
    //     // Center(
    //     //   child: Material(
    //     //     color: Colors.redAccent,
    //     //     borderRadius: BorderRadius.circular(8),
    //     //     child: InkWell(
    //     //       onTap: ()
    //     //       {
    //     //         DeleteUser();
    //     //       },
    //     //       borderRadius: BorderRadius.circular(32),
    //     //       child: const Padding(
    //     //         padding: EdgeInsets.symmetric(
    //     //           horizontal: 30,
    //     //           vertical: 12,
    //     //         ),
    //     //         child: Text(
    //     //           "Delete account",
    //     //           style: TextStyle(
    //     //             color: Colors.white,
    //     //             fontSize: 16,
    //     //           ),
    //     //
    //     //         ),
    //     //       ),
    //     //
    //     //     ),
    //     //   ),
    //     //
    //     // )
    //
    //
    //   ],
    //
    // );
  }
}