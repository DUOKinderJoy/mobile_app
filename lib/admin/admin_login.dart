import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kinder_joy_1/admin/admin_upload_items.dart';
import 'package:kinder_joy_1/admin/options.dart';
import 'package:kinder_joy_1/authentication/roles_op.dart';
import 'package:kinder_joy_1/teachers/fragments/dashboard_of_fragments.dart';
import 'package:kinder_joy_1/teachers/teacherPreferences/teacher_preferences.dart';
import 'package:kinder_joy_1/teachers/teacher_sign_up.dart';

import '../api_connection/api_connection.dart';
import '../teachers/model/teacher.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var isObsecure = true.obs;


    loginAdminNow() async {
      try {
        var res = await http.post(
          Uri.parse(API.loginAdmin),
          body: {
            "admin_email": emailController.text.trim(),
            "admin_password": passwordController.text.trim(),
          },
        );
        if (res.statusCode ==
            200) //http 200 = success communicated with server (flutter with API to server)
        {
          var resBodyOfLogin = jsonDecode(res.body);
          if (resBodyOfLogin['success'] == true) {
            Fluttertoast.showToast(msg: "Admin Login successfully.");

            Future.delayed(const Duration(milliseconds: 2000), () {
              Get.to(AdminOp());
            });
          } else {
            Fluttertoast.showToast(
                msg:
                    "Login unsuccessfully, incorrect name / contact no. Try again");
          }
        }
      } catch (errorMsg) {
        print("Error::" + errorMsg.toString());
      }
    }

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
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'KinderJoy',
                    style: GoogleFonts.ovo(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Login',
                    style: GoogleFonts.ovo(fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Form(
                          key: formKey,
                          child: Column(
                            children: [
                              //name
                              TextFormField(
                                controller: emailController,
                                validator: (val) => val == ""
                                    ? "Please write your admin email"
                                    : null,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.people,
                                    color: Colors.deepPurple,
                                  ),
                                  border: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  labelText: 'Admin email',
                                ),
                              ),
                              const SizedBox(height: 18),
                              Obx(
                                    ()=> TextFormField(
                                  controller: passwordController,
                                  obscureText: isObsecure.value,
                                  validator: (val) => val == "" ? "Please write password" : null,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.vpn_key_sharp,
                                      color: Colors.deepPurple,
                                    ),
                                    suffixIcon: Obx(
                                          ()=> GestureDetector(
                                        onTap: ()
                                        {
                                          isObsecure.value = !isObsecure.value;
                                        },
                                        child: Icon(
                                          isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ),
                                    hintText: "password...",
                                    border: OutlineInputBorder(
                                      // borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      // borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                             
                                  ),
                                ),
                              ),
                              // TextFormField(
                              //   controller: passwordController,
                              //   validator: (val) => val == ""
                              //       ? "Please write your password"
                              //       : null,
                              //   decoration: const InputDecoration(
                              //     prefixIcon: Icon(
                              //       Icons.phone,
                              //       color: Colors.deepPurple,
                              //     ),
                              //     border: OutlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       // borderRadius: BorderRadius.circular(30),
                              //       borderSide: BorderSide(
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //     labelText: 'Password',
                              //   ),
                              // ),
                              const SizedBox(height: 18),
                              Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      loginAdminNow();
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(25, 10, 25, 10),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Not admin?'),
                                  TextButton(
                                    child: const Text(
                                      'Click here',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.deepPurple),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RolesOp()),
                                      ); //signup screen
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}


// ignore: must_be_immutable
// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                   "assets/background.jpg",
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: ListView(
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.all(10),
//                   child: const Text(
//                     'KinderJoy',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 30,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.all(10),
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: TextField(
//                     controller: nameController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Name',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     obscureText: true,
//                     controller: passwordController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Contact No',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 50,
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: ElevatedButton(
//                     child: const Text('Login'),
//                     onPressed: () {
//                       print(nameController.text);
//                       print(passwordController.text);
//                     },
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const Text('Does not have an account?'),
//                     TextButton(
//                       child: const Text(
//                         'Sign up',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const SignUpOp()),
//                         );//signup screen
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 10,
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
