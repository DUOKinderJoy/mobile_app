import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kinder_joy_1/authentication/login_screen.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';
import 'model/teacher.dart';
//

class TSignUpPage extends StatefulWidget
{
  @override
  State<TSignUpPage> createState() => _TSignUpPageState();
}

class _TSignUpPageState extends State<TSignUpPage>
{
  @override
  Widget build(BuildContext context)
  {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var noController = TextEditingController();
    var idController = TextEditingController();
    var addressController = TextEditingController();

    registerAndSaveTeacherRecord() async
    {
      Teacher teacherModel = Teacher(
        // 1,
        nameController.text.trim(),
        noController.text.trim(),
        idController.text.trim(),
        addressController.text.trim(),
      );

      try
      {
        var res = await http.post(
          Uri.parse(API.signUp),
          body: teacherModel.toJson(),
        );

        if(res.statusCode == 200)   //http 200 = success communicated with server (flutter with API to server)
        {
          var resBodyOfSignUp = jsonDecode(res.body);
          if(resBodyOfSignUp['success'] == true)
          {
            Fluttertoast.showToast(msg: "Sign up successfully.");
            setState(() {
              nameController.clear();
              noController.clear();
              idController.clear();
              addressController.clear();
            });

          }
          else
          {
            Fluttertoast.showToast(msg: "Error occur, Sign up unsuccessfully. Try again");
          }
        }
      }
      catch(e)
      {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }

    validateTeacherID() async
    {
      try
      {
        var res = await http.post(
          Uri.parse(API.validateID),
          body: {
            'teacher_id': idController.text.trim(),
          }
        );
        if(res.statusCode == 200)   //http 200 = success communicated with server (flutter with API to server)
        {
          var resBodyOfValidateId = jsonDecode(res.body);

          if(resBodyOfValidateId['idFound'] == true)
          {
            Fluttertoast.showToast(msg: "Teacher ID is already used. Check again your ID.");
          }
          else
          {
            //register account
            registerAndSaveTeacherRecord();
          }
        }
      }
      catch(e)
      {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }

    // registerAndSaveTeacherRecord() async
    // {
    //   Teacher teacherModel = Teacher(
    //     // 1,
    //     nameController.text.trim(),
    //     noController.text.trim(),
    //     idController.text.trim(),
    //     addressController.text.trim(),
    //   );
    //
    //   try
    //   {
    //     var res = await http.post(
    //       Uri.parse(API.signUp),
    //       body: teacherModel.toJson(),
    //     );
    //
    //     if(res.statusCode == 200)   //http 200 = success communicated with server (flutter with API to server)
    //     {
    //       var resBodyOfSignUp = jsonDecode(res.body);
    //       if(resBodyOfSignUp['success'] == true)
    //       {
    //         Fluttertoast.showToast(msg: "Sign up successfully.");
    //       }
    //       else
    //       {
    //         Fluttertoast.showToast(msg: "Error occur, Sign up unsuccessfully. Try again");
    //       }
    //     }
    //   }
    //   catch(e)
    //   {
    //     print(e.toString());
    //     Fluttertoast.showToast(msg: e.toString());
    //   }
    // }

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
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'KinderJoy',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
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
                                controller: nameController,
                                validator: (val) => val == "" ? "Please write your full name" : null,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.people,
                                    color: Colors.blueGrey,
                                  ) ,
                                  border: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color:  Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color:  Colors.white,
                                    ),
                                  ),
                                  labelText: 'Name',
                                ),
                              ),
                              const SizedBox(height: 18),
                              TextFormField(
                                controller: noController,
                                validator: (val) => val == "" ? "Please write your contact No" : null,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.blueGrey,
                                  ) ,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:  Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color:  Colors.white,
                                    ),
                                  ),
                                  labelText: 'Contact No (0XX -XXXX XXXX)',
                                ),
                              ),
                              const SizedBox(height: 18),

                              TextFormField(
                                controller: idController,
                                validator: (val) => val == "" ? "Please write your teacher ID" : null,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.abc,
                                    color: Colors.blueGrey,
                                  ) ,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:  Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color:  Colors.white,
                                    ),
                                  ),
                                  labelText: 'Teacher ID (T1234)',
                                ),
                              ),
                              const SizedBox(height: 18),
                              TextFormField(
                                controller: addressController,
                                validator: (val) => val == "" ? "Please write your home address" : null,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.blueGrey,
                                  ) ,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:  Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color:  Colors.white,
                                    ),
                                  ),
                                  labelText: 'Address',
                                ),
                              ),
                              const SizedBox(height: 18),
                              Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: ()
                                  {
                                    if(formKey.currentState!.validate())
                                      {
                                        //validate the ID
                                        //only one user can have this ID
                                        validateTeacherID();
                                      }

                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                                    child: Text(
                                      "SIGN UP",
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
                                  const Text('Already have an account?'),
                                  TextButton(
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );//signup screen
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                      )
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



// class TSignUpPage extends StatelessWidget {
//   TSignUpPage({Key? key});
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController contactController = TextEditingController();
//   TextEditingController idController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//
//   String? validateContact(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Contact number is required';
//     }
//
//     final RegExp contactRegExp = RegExp(r'^\d{3}-\d{7,8}$');
//     if (!contactRegExp.hasMatch(value)) {
//       return 'Enter a valid contact number in the format xxx-xxxxxxx (9-10 digits)';
//     }
//
//     return null;
//   }
//
//   String? validateTeacherID(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Teacher ID is required';
//     }
//
//     final RegExp teacherIDRegExp = RegExp(r'^T\d{4}$');
//     if (!teacherIDRegExp.hasMatch(value)) {
//       return 'Enter a valid Teacher ID in the format T1234';
//     }
//
//     return null;
//   }
//
//   String? validateField(String? value, String fieldName) {
//     if (value == null || value.isEmpty) {
//       return '$fieldName is required';
//     }
//
//     return null;
//   }
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
//             child: Form(
//               key: _formKey,
//               child: ListView(
//                 children: <Widget>[
//                   Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.all(10),
//                     child: const Text(
//                       'KinderJoy',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 30,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.all(10),
//                     child: const Text(
//                       'Sign up as Teacher',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     child: TextFormField(
//                       controller: nameController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Name',
//                       ),
//                       validator: (value) => validateField(value, 'Name'),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                     child: TextFormField(
//                       controller: contactController,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         border: const OutlineInputBorder(),
//                         labelText: 'Contact No',
//                         prefixText: '',
//                       ),
//                       validator: validateContact,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     child: TextFormField(
//                       controller: idController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Teacher ID',
//                       ),
//                       validator: validateTeacherID,
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                     child: TextFormField(
//                       controller: addressController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Address',
//                       ),
//                       validator: (value) => validateField(value, 'Address'),
//                     ),
//                   ),
//                   Container(
//                     height: 50,
//                     padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                     child: ElevatedButton(
//                       child: const Text('Sign up'),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           // Perform sign-up logic
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const SignUpSuccess()),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
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
