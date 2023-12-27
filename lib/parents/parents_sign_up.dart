import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kinder_joy_1/parents/parent_login_screen.dart';
import '../api_connection/api_connection.dart';
import 'parentsModel/parents.dart';
//

class ParentSignUpPage extends StatefulWidget
{
  @override
  State<ParentSignUpPage> createState() => _ParentSignUpPageState();
}

class _ParentSignUpPageState extends State<ParentSignUpPage>
{
  @override
  Widget build(BuildContext context)
  {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var noController = TextEditingController();
    var idController = TextEditingController();
    var cnameController = TextEditingController();
    var addressController = TextEditingController();

    registerAndSaveParentsRecord() async
    {
      Parents parentsModel = Parents(
        // 1,
        nameController.text.trim(),
        noController.text.trim(),
        idController.text.trim(),
        cnameController.text.trim(),
        addressController.text.trim(),
      );

      try
      {
        var res = await http.post(
          Uri.parse(API.signUpParents),
          body: parentsModel.toJson(),
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
              cnameController.clear();
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

    validateChildrenID() async
    {
      try
      {
        var res = await http.post(
            Uri.parse(API.validateChildID),
            body: {
              'children_id': idController.text.trim(),
            }
        );
        if(res.statusCode == 200)   //http 200 = success communicated with server (flutter with API to server)
            {
          var resBodyOfValidateId = jsonDecode(res.body);

          if(resBodyOfValidateId['idFound'] == true)
          {
            Fluttertoast.showToast(msg: "Children ID is already used. Check again your ID.");
          }
          else
          {
            //register account
            registerAndSaveParentsRecord();
          }
        }
      }
      catch(e)
      {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }

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
                                validator: (val) => val == "" ? "Please write your Children ID" : null,
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
                                  labelText: 'Children ID (C1234)',
                                ),
                              ),
                              const SizedBox(height: 18),

                              TextFormField(
                                controller: cnameController,
                                validator: (val) => val == "" ? "Please write your Children ID" : null,
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
                                  labelText: 'Children Full Name (JACKY LEE WEN ZHOU)',
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
                                      validateChildrenID();
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
                                        MaterialPageRoute(builder: (context) => ParentLoginPage()),
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



// import 'package:flutter/material.dart';
//
// import '../authentication/sign_up_success.dart';
//
// // ignore: must_be_immutable
// class CSignUpPage extends StatelessWidget {
//   // ignore: use_key_in_widget_constructors
//   CSignUpPage({Key? key});
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
//   String? validateChildrenID(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Children ID is required';
//     }
//
//     final RegExp childrenIDRegExp = RegExp(r'^C\d{4}$');
//     if (!childrenIDRegExp.hasMatch(value)) {
//       return 'Enter a valid Children ID in the format C1234';
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
//                       'Sign up as Parents',
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
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
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
//                         labelText: 'Children ID',
//                       ),
//                       validator: validateChildrenID,
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
