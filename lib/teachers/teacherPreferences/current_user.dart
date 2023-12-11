import 'package:get/get.dart';
import 'package:kinder_joy_1/teachers/teacherPreferences/teacher_preferences.dart';

import '../model/teacher.dart';

class CurrentTeacher extends GetxController
{
  Rx<Teacher> _currentTeacher = Teacher('', '', '', '').obs;    //we can access the data of user(teacher) using this

  Teacher get teacher =>  _currentTeacher.value;

  getTeacherInfo() async
  {
    Teacher? getTeacherInfoFromLocalStorage = await RememberTeacherPres.readTeacherInfo();
    _currentTeacher.value = getTeacherInfoFromLocalStorage!;
  }
}