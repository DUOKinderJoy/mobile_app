import 'package:flutter/material.dart';
import 'package:kinder_joy_1/authentication/roles_op.dart';
import 'package:kinder_joy_1/teachers/fragments/dashboard_of_fragments.dart';
import 'package:kinder_joy_1/teachers/teacherPreferences/teacher_preferences.dart';
import 'package:get/get.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      title: 'Kinder Joy',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: RememberTeacherPres.readTeacherInfo(),
        // appBar: AppBar(title: const Text(_title)),
        // body: const FrontPage(),
        builder: (context, dataSnapShot)
        {
          if(dataSnapShot.data == null)
            {
              return RolesOp();
            }
          else
            {
              return DashboardOfFragments();
            }
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:kinder_joy_1/meal_selection/cart_page.dart';
// import 'package:kinder_joy_1/meal_selection/meal_details_page.dart';
// import 'package:kinder_joy_1/meal_selection/meal_home_page.dart';
// import 'package:kinder_joy_1/models/cart.dart';
// import 'package:kinder_joy_1/pages/dashboard.dart';
// import 'package:kinder_joy_1/pages/front_page.dart';
// import 'package:kinder_joy_1/pages/login_page.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(ChangeNotifierProvider(
//     create: (context) => Cart(),
//     child: const MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const FrontPage(),
//       routes: {
//         //'/loginpage': (context) => LoginPage(),
//         '/dashboard': (context) => const Dashboard(),
//         '/cartpage': (context) => const CartPage(),
//         //'/mealDetailsPage':(context) => const MealDetailsPage(meal: meal[index]),
//         // '/meal':(context) => const MealHomePage(),
//       },
//     );
//   }
// }

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => LoginPage();
// }
