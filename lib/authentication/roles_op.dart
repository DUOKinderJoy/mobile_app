import 'package:flutter/material.dart';
import 'package:kinder_joy_1/admin/admin_login.dart';
import 'package:kinder_joy_1/authentication/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import '../parents/parent_login_screen.dart';
import '../parents/parents_sign_up.dart';
import '../teachers/teacher_sign_up.dart';

class RolesOp extends StatelessWidget {
  const RolesOp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 175.0, right: 175.0, top: 200, bottom: 0),
                  child: Image.asset('lib/images/kindergarten.png'),
                ),
                Text(
                  'KinderJoy',
                  style: GoogleFonts.ovo(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),

                Text(
                  'Welcome! What roles are you?',
                  style: GoogleFonts.ovo(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Set the button color to white
                  ),
                  child: Text(
                    'Parents',
                    style: GoogleFonts.ovo(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParentLoginPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.white, // Set the button color to white
                  ),
                  child: Text(
                    'Teachers',
                    style: GoogleFonts.ovo(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    //teacher sign up page
                  },
                ),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white, // Set the button color to white
                //   ),
                //   child: const Text('Admin'),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => AdminLoginPage()),
                //     );
                //     //teacher sign up page
                //   },
                // ),
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
