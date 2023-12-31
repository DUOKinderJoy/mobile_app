import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_home_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_order_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_profile_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_study_fee_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/current_parents.dart';

class ParentsDashboardOfFragments extends StatelessWidget{
  // DashboardOfFragments({super.key});

  CurrentParents _rememberCurrentParents = Get.put(CurrentParents());

  List<Widget> _fragmentsScreens =
  [
    ParentsHomeFragementScreen(),
    MealHomePage(),
    StudyFeeYearList(),
    ParentsProfileFragementScreen(),

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
      "label": "Meals",
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outlined,
      "label": "Study Fee",
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
      init: CurrentParents(),
      initState: (currentState)
      {
        _rememberCurrentParents.getParentsInfo();
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
              items: List.generate(4, (index)
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