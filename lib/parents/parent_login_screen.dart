import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kinder_joy_1/parents/parentsFragments/dashboard_of_parents_fragments.dart';
import 'package:kinder_joy_1/parents/parentsModel/parents.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/parents_preferences.dart';
import 'package:kinder_joy_1/parents/parents_sign_up.dart';
import '../api_connection/api_connection.dart';

class ParentLoginPage extends StatefulWidget
{
  @override
  State<ParentLoginPage> createState() => _ParentLoginPageState();
}

class _ParentLoginPageState extends State<ParentLoginPage>
{
  @override
  Widget build(BuildContext context)
  {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var noController = TextEditingController();

    loginParentsNow() async
    {
      try
      {
        var res = await http.post(
          Uri.parse(API.loginParents),
          body: {
            "parents_name": nameController.text.trim(),
            "parents_no": noController.text.trim(),
          },
        );
        if(res.statusCode == 200)   //http 200 = success communicated with server (flutter with API to server)
          {
          var resBodyOfLogin = jsonDecode(res.body);
          if(resBodyOfLogin['success'] == true)
          {
            Fluttertoast.showToast(msg: "Login successfully. Directing to home page.");

            Parents parentsInfo = Parents.fromJson(resBodyOfLogin["parentsData"]);

            //save parentsInfo to local storage using Shared Preferences
            await RememberParentsPres.storeParentsInfo(parentsInfo);

            Future.delayed(Duration(milliseconds: 2000), ()
            {
              Get.to(ParentsDashboardOfFragments());
            });
          }
          else
          {
            Fluttertoast.showToast(msg: "Login unsuccessfully, incorrect name / contact no. Try again");
          }
        }
      }
      catch(errorMsg)
      {
        print("Error::" + errorMsg.toString());
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
                    'Login',
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
                                  labelText: 'Parents Full Name (JAYDEN NY LEE JIA)',
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
                              Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                child: InkWell(
                                  onTap: (){
                                    if(formKey.currentState!.validate())
                                    {
                                      loginParentsNow();
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
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
                                  const Text('Does not have an account?'),
                                  TextButton(
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ParentSignUpPage()),
                                      );//signup screen
                                    },
                                  ),
                                ],
                              ),

                              const Text(
                                "Or",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              //admin button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Are you an admin?'),
                                  TextButton(
                                    child: const Text(
                                      'Click here',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => const SignUpOp()),
                                      // );//signup screen
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