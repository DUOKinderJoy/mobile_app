import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:kinder_joy_1/notused/meal_home_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Color.fromARGB(255, 222, 134, 163),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            //Home
            ListTile(
              title: Text(
                'Home',
                style: GoogleFonts.ovo(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              textColor: Colors.white,
              tileColor: Color.fromARGB(255, 222, 134, 163),
              onTap: () {
                MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => Dashboard());
                Navigator.push(context, route);
              },
            ),

            //Attendance
            ListTile(
              title: Text(
                'Attendance',
                style: GoogleFonts.ovo(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                //MaterialPageRoute route = MaterialPageRoute(builder: (context)=>Dashboard());
              },
            ),

            //Meals
            ListTile(
              title: Text(
                'Meals',
                style: GoogleFonts.ovo(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // MaterialPageRoute route =
                // // MaterialPageRoute(builder: (context) => MealHomePage());
                // Navigator.push(context, route);
              },
            ),

            //Study fee
            ListTile(
              title: Text(
                'Study Fee',
                style: GoogleFonts.ovo(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                //MaterialPageRoute route = MaterialPageRoute(builder: (context)=>Dashboard());
                //Navigator.push(context, route);
              },
            ),
          ],
        ),
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
        ],
      ),
    );
  }
}