import 'package:flutter/material.dart';
import 'package:kinder_joy_1/admin/admin_upload_items.dart';
import 'package:kinder_joy_1/admin/admin_upload_meals.dart';


class AdminOp extends StatelessWidget {
  const AdminOp({super.key});

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 175.0, right: 175.0, top: 200, bottom: 0),
                  child: Image.asset('lib/images/kindergarten.png'),
                ),
                const Text(
                  'KinderJoy',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
                const Text(
                  'What would you like to update today?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('Dashboard'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminUploadItemsScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Set the button color to white
                  ),
                  child: const Text('Meals'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminUploadMealsScreen()),
                    );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 20),
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
  }
}