import 'package:flutter/material.dart';

import '../../meal_selection/meal_home_page.dart';

class ParentsHomeFragementScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     const Text('Does not have an account?'),
      //     TextButton(
      //       child: const Text(
      //         'HOME',
      //         style: TextStyle(fontSize: 15),
      //       ),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           // MaterialPageRoute(builder: (context) => ParentSignUpPage()),
      //         );//signup screen
      //       },
      //     ),
      //     TextButton(
      //       child: const Text(
      //         'ATTENDANCE',
      //         style: TextStyle(fontSize: 15),
      //       ),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           // MaterialPageRoute(builder: (context) => ParentSignUpPage()),
      //         );//signup screen
      //       },
      //     ),
      //     TextButton(
      //       child: const Text(
      //         'MEALS',
      //         style: TextStyle(fontSize: 15),
      //       ),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => MealHomePage()),
      //         );//signup screen
      //       },
      //     ),
      //     TextButton(
      //       child: const Text(
      //         'STUDY FEE',
      //         style: TextStyle(fontSize: 15),
      //       ),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => ParentSignUpPage()),
      //         );//signup screen
      //       },
      //     ),
      //     Container(
      //       decoration: const BoxDecoration(
      //         image: DecorationImage(
      //           image: NetworkImage(
      //             "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
      //           ),
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

        body: Center(
          child: Text(
            "Home Fragement Screen",
          ),
        )

    );
  }
}