import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kinder_joy_1/authentication/roles_op.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/current_parents.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/parents_preferences.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';


class ParentsProfileFragementScreen extends StatelessWidget
{
  final CurrentParents _currentParents = Get.put(CurrentParents());

  signOutUser() async
  {

    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Sign out",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure?\nYou want to sign out?",
        ),
        actions: [
          TextButton(
              onPressed: ()
              {
                Get.back();
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
          ),
          TextButton(
              onPressed: ()
              {
                Get.back(result: "SignOut");
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
          ),
        ],
      ),
    );

    if(resultResponse == 'SignOut')
    {
      //delete - remove user data from local storage
      RememberParentsPres.removeParentsInfo()
          .then((value)
      {
        Get.off(RolesOp());
      });
    }
  }

  Widget parentsInfoItemProfile(IconData iconData, String parentsData)
  {
    return Container(   //reusable code
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
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
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: NetworkImage(
        "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
        ),
      fit: BoxFit.cover, // You can choose other BoxFit options based on your requirements
      ),
    ),

    child: ListView(
      padding: const EdgeInsets.all(32),

      children: [
        Center(
          child: Image.asset(
            "assets/people.png",
            width: 240,
          ),

        ),

        const SizedBox(height: 20,),

        parentsInfoItemProfile(Icons.people, _currentParents.parents.parents_name),
        const SizedBox(height: 20,),

        parentsInfoItemProfile(Icons.phone, _currentParents.parents.parents_no),
        const SizedBox(height: 20,),

        parentsInfoItemProfile(Icons.abc, _currentParents.parents.children_id),
        const SizedBox(height: 20,),

        parentsInfoItemProfile(Icons.people, _currentParents.parents.children_name),
        const SizedBox(height: 20,),

        parentsInfoItemProfile(Icons.home, _currentParents.parents.parents_address),
        const SizedBox(height: 20,),

        Center(
          child: Material(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: ()
              {
                signOutUser();
              },
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),

                ),
              ),

            ),
          ),

        ),
        const SizedBox(height: 20,),


      ],
    ),
    );
  }
}