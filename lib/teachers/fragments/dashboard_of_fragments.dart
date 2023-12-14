import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kinder_joy_1/teachers/fragments/home_fragment_screen.dart';
import 'package:kinder_joy_1/teachers/fragments/order_fragment_screen.dart';
import 'package:kinder_joy_1/teachers/fragments/profile_fragment_screen.dart';
import 'package:kinder_joy_1/teachers/teacherPreferences/current_user.dart';

class DashboardOfFragments extends StatelessWidget{
  // DashboardOfFragments({super.key});

  CurrentTeacher _rememberCurrentTeacher = Get.put(CurrentTeacher());

  List<Widget> _fragmentsScreens =
  [
    HomeFragementScreen(),
    OrderFragementScreen(),
    ProfileFragementScreen(),
  ];

  List _navigationButtonProperties =
      [
        {
          "active_icon": Icons.home,
          "non_active_icon": Icons.home_outlined,
          "label": "Home",
        },
        {
          "active_icon": FontAwesomeIcons.boxOpen,
          "non_active_icon": FontAwesomeIcons.box,
          "label": "Orders",
        },
        {
          "active_icon": Icons.person,
          "non_active_icon": Icons.person_outlined,
          "label": "Profile",
        },
      ];

  RxInt _indexnumber = 0.obs;

  @override
  Widget build(BuildContext context){
    return GetBuilder(
      init: CurrentTeacher(),
      initState: (currentState)
      {
        _rememberCurrentTeacher.getTeacherInfo();
      },
      builder: (controller)
      {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Obx(
                ()=> _fragmentsScreens[_indexnumber.value]
            ),
          ),
          bottomNavigationBar: Obx(
              ()=>BottomNavigationBar(
                currentIndex: _indexnumber.value,
                onTap: (value)
                {
                  _indexnumber.value = value;
                },
                showSelectedLabels: true,
                showUnselectedLabels: true, //select or not all showing
                selectedItemColor: Colors.blue, //showing diff cokir
                unselectedItemColor: Colors.pink,
                items: List.generate(3, (index)
                {
                  var navBtnProperty = _navigationButtonProperties[index];
                  return BottomNavigationBarItem
                  (
                    backgroundColor: Colors.black,
                    icon: Icon(navBtnProperty["non_active_icon"]),
                    activeIcon: Icon(navBtnProperty["active_icon"]),
                    label: navBtnProperty["label"],
                  );
                }),
              ),
          ),
        );
      },
    );
  }
}