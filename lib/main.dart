import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kinder_joy_1/authentication/roles_op.dart';
import 'package:kinder_joy_1/teachers/fragments/dashboard_of_fragments.dart';
import 'package:kinder_joy_1/teachers/teacherPreferences/teacher_preferences.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// import 'notused/cart_page.dart';
import 'models/cart.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51OOBkICvnNFxCr3XJWfN3mvnBpjRgVYdP9HG3hHRNlkrGidlHFkGg9v1ukvDK5VH4zDNWH6XgDLpEWruisWItkUe00beiDOTgV";
  runApp(const MyApp());
  // runApp(ChangeNotifierProvider(
  //   create: (context) => Cart(),
  //   child: const MyApp(),
  // ));
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
