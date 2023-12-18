import 'package:flutter/material.dart';
import 'package:kinder_joy_1/components/day_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/meal_selection/menu_page_1.dart';
import 'package:kinder_joy_1/meal_selection/menu_page_2.dart';
import 'package:kinder_joy_1/meal_selection/menu_page_3.dart';
import 'package:kinder_joy_1/meal_selection/menu_page_4.dart';
import 'package:kinder_joy_1/meal_selection/menu_page_5.dart';

class MealHomePage extends StatelessWidget {
  const MealHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 222, 134, 163),
        actions: [
          //cart button
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/cartpage");
            },
            icon: Icon(Icons.shopping_bag),
          )
        ],
      ),
      body: Stack(
        children: [
          //background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'KinderJoy',
                style: GoogleFonts.ovo(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
              const SizedBox(height: 0),

              Text(
                'Meals Selection',
                style: GoogleFonts.ovo(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 30),

              //Monday
              DayButton(
                  text: "Monday",
                  onTap: () {
                    MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => MenuPage_1());
                    Navigator.push(context, route);
                  }),

              //Tuesday
              DayButton(
                  text: "Tuesday",
                  onTap: () {
                    MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => MenuPage_2());
                    Navigator.push(context, route);
                  }),

              //Wednesday
              DayButton(
                  text: "Wednesday",
                  onTap: () {
                    MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => MenuPage_3());
                    Navigator.push(context, route);
                  }),

              //Thursday
              DayButton(
                  text: "Thursday",
                  onTap: () {
                    MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => MenuPage_4());
                    Navigator.push(context, route);
                  }),

              //Friday
              DayButton(
                  text: "Friday",
                  onTap: () {
                    MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => MenuPage_5());
                    Navigator.push(context, route);
                  }),
            ],
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:kinder_joy_1/parents/parentsFragments/parents_study_fee_fragment_screen.dart';
// import 'package:kinder_joy_1/parents/studyFee/yearList.dart';
// // import 'package:kinder_joy_1/parents/studyFee/tryStripe.dart';
//
// import '../../meal_selection/meal_home_page.dart';
// import '../studyFee/tryStripe.dart';
//
// class ParentsOrderFragementScreen extends StatelessWidget
// {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image:  NetworkImage(
//                     "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'What you want to do?',
//                     style: GoogleFonts.ovo(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30,
//                     ),
//                   ),
//                   const SizedBox(height: 20,),
//
//                   Material(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(30),
//                       child: const Padding(
//                         padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
//                         child: const Text(
//                           'HOME',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => MealHomePage()),
//                         );//signup screen
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 20,),
//
//                   Material(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(30),
//                       child: const Padding(
//                         padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
//                         child: const Text(
//                           'ATTENDANCE',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                       onTap: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(builder: (context) => MealHomePage()),
//                         // );//signup screen
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 20,),
//
//                   Material(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(30),
//                       child: const Padding(
//                         padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
//                         child: const Text(
//                           'MEALS',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => MealHomePage()),
//                         );//signup screen
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 20,),
//
//                   Material(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(30),
//                       child: const Padding(
//                         padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
//                         child: const Text(
//                           'STUDY FEE',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => StudyFeeYearList()),
//                         );//signup screen
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         )
//     );
//   }
// }