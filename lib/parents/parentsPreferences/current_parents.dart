import 'package:get/get.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/parents_preferences.dart';

import 'package:kinder_joy_1/parents/parentsModel/parents.dart';

class CurrentParents extends GetxController
{
  Rx<Parents> _currentParents = Parents('', '', '', '','').obs;    //we can access the data of user(teacher) using this

  Parents get parents =>  _currentParents.value;

  getParentsInfo() async
  {
    Parents? getParentsInfoFromLocalStorage = await RememberParentsPres.readParentsInfo();
    _currentParents.value = getParentsInfoFromLocalStorage!;
  }
}