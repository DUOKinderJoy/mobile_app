import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/authentication/roles_op.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/current_parents.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/parents_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:kinder_joy_1/parents/studyFee/tryStripe.dart';
import '../../api_connection/api_connection.dart';
import '../parentsFragments/parents_mealsorder_fragment_screen.dart';


class StudyFeeYear2023 extends StatelessWidget
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
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 175.0, right: 175.0, top: 200, bottom: 0),
                //   child: Image.asset('lib/images/kindergarten.png'),
                // ),
                // const Text(
                //   'KinderJoy',
                //   style: TextStyle(
                //     color: Colors.blue,
                //     fontWeight: FontWeight.w500,
                //     fontSize: 30,
                //   ),
                // ),
                Text(
                  'Study fee for',
                  style: GoogleFonts.ovo(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Text(
                  _currentParents.parents.children_name,
                  style: GoogleFonts.ovo(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  'in 2023',
                  style: GoogleFonts.ovo(
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
                  child:  Text(
                    '2023 Dec',
                    style: GoogleFonts.ovo(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MealOrderPage()),
                    );
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: Text('2023 Nov',
                      style: GoogleFonts.ovo(color: Colors.black)),
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
                  child: Text('2023 Oct',
                      style: GoogleFonts.ovo(color: Colors.black)),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MealOrderPage()),
                    // );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 5),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: Text('2023 Sep',
                      style: GoogleFonts.ovo(color: Colors.black)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MealOrderPage()),
                    );
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
                  child: Text('2023 Aug',
                      style: GoogleFonts.ovo(color: Colors.black)),
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
                  child: Text('2023 July',
                      style: GoogleFonts.ovo(color: Colors.black)),
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
                  child: Text('2023 June',
                      style: GoogleFonts.ovo(color: Colors.black)),
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
                  child: Text('2023 May',
                      style: GoogleFonts.ovo(color: Colors.black)),
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
                  child: Text('2023 Apr',
                      style: GoogleFonts.ovo(color: Colors.black)),
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
                  child: Text('2023 Mar',
                      style: GoogleFonts.ovo(color: Colors.black)),
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
                  child: Text('2023 Feb',
                      style: GoogleFonts.ovo(color: Colors.black)),
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
                  child: Text('2023 Jan',
                      style: GoogleFonts.ovo(color: Colors.black)),
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