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
