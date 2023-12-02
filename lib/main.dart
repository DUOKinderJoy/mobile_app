import 'package:flutter/material.dart';
import 'package:kinder_joy_1/meal_selection/cart_page.dart';
import 'package:kinder_joy_1/meal_selection/meal_details_page.dart';
import 'package:kinder_joy_1/meal_selection/meal_home_page.dart';
import 'package:kinder_joy_1/models/cart.dart';
import 'package:kinder_joy_1/pages/dashboard.dart';
import 'package:kinder_joy_1/pages/front_page.dart';
import 'package:kinder_joy_1/pages/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Cart(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FrontPage(),
      routes: {
        //'/loginpage': (context) => LoginPage(),
        '/dashboard': (context) => const Dashboard(),
        '/cartpage': (context) => const CartPage(),
        //'/mealDetailsPage':(context) => const MealDetailsPage(meal: meal[index]),
        // '/meal':(context) => const MealHomePage(),
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => LoginPage();
}
