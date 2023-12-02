import 'package:flutter/material.dart';
import 'package:kinder_joy_1/components/button.dart';
import '../main.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 175.0, right: 175.0, top: 200, bottom: 0),
                    child: Image.asset('lib/images/kindergarten.png'),
                  ),

                  const Text(
                    'KinderJoy',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyStatefulWidget(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, //set the button color to white
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black87),
                    ),
                    onPressed: () {
                      print('Pressed Sign Up Button');
                    },
                  ),
                  const SizedBox(height: 300),
                  MyButton(
                    text: "Get Started",
                    onTap: () {
                      Navigator.pushNamed(context, "/dashboard");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
