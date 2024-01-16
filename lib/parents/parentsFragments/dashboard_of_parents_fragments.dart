import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_home_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_mealsorder_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_order_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_profile_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsFragments/parents_study_fee_fragment_screen.dart';
import 'package:kinder_joy_1/parents/parentsPreferences/current_parents.dart';

class ParentsDashboardOfFragments extends StatelessWidget {
  // DashboardOfFragments({super.key});

  CurrentParents _rememberCurrentParents = Get.put(CurrentParents());

  final List<Widget> _fragmentsScreens = [
    ParentsHomeFragementScreen(),
    MealHomePage(),
    StudyFeeYearList(),
    MealOrderPage(),
    ParentsProfileFragementScreen(),
  ];

  final List _navigationButtonProperties = [
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
      "active_icon": Icons.wallet,
      "non_active_icon": Icons.wallet_sharp,
      "label": "Study Fee",
    },
    {
      "active_icon": Icons.money_off,
      "non_active_icon": Icons.attach_money,
      "label": "Payment",
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outlined,
      "label": "Profile",
    },
  ];

  final RxInt _indexnumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentParents(),
      initState: (currentState) {
        _rememberCurrentParents.getParentsInfo();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Obx(() => _fragmentsScreens[_indexnumber.value]),
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: _indexnumber.value,
              onTap: (value) {
                _indexnumber.value = value;
              },
              showSelectedLabels: true,
              showUnselectedLabels: true, //select or not all showing
              selectedItemColor: Colors.blue, //showing diff cokir
              unselectedItemColor: Colors.deepPurple,
              items: List.generate(5, (index) {
                var navBtnProperty = _navigationButtonProperties[index];
                return BottomNavigationBarItem(
                  backgroundColor: Colors.white,
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
