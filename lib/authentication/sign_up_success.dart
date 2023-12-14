// import 'package:flutter/material.dart';
//
// import 'login_screen.dart';
//
// class SignUpSuccess extends StatelessWidget {
//   const SignUpSuccess({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                   "assets/background.jpg",
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'KinderJoy',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 30,
//                   ),
//                 ),
//                 const Text(
//                   'Sign Up',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20,
//                   ),
//                 ),
//                 const Text(
//                   'Successfully',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white, // Set the button color to white
//                   ),
//                   child: const Text('Login'),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }