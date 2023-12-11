import 'dart:convert';

import 'package:kinderjoy_2/teachers/model/teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberTeacherPres
{
  //save user info
  static Future<void> storeTeacherInfo (Teacher teacherInfo) async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String teacherJsonData = jsonEncode(teacherInfo.toJson());
    await preferences.setString("currentTeacher", teacherJsonData);
  }

  //get-read Teacher - info
  static Future<Teacher?> readTeacherInfo() async
  {
    Teacher? currentTeacherInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? teacherInfo = preferences.getString("currentTeacher");
    if(teacherInfo != null)
    {
      Map<String, dynamic> teacherDataMap = jsonDecode(teacherInfo);
      currentTeacherInfo = Teacher.fromJson(teacherDataMap);
    }
    return currentTeacherInfo;
  }


  static Future<void> removeTeacherInfo() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentTeacher");
  }
}