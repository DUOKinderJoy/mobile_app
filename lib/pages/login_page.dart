// import 'package:flutter/material.dart';
// import 'package:kinder_joy_1/main.dart';


// class LoginPage extends State<MyStatefulWidget> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                   "https://i.pinimg.com/564x/5b/ae/b8/5baeb8b0a43a143628bb855a6dbaa60d.jpg",
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: ListView(
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.all(10),
//                   child: const Text(
//                     'KinderJoy',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 30,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.all(10),
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: TextField(
//                     controller: nameController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Name',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     obscureText: true,
//                     controller: passwordController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Contact No',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 50,
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: ElevatedButton(
//                     child: const Text('Login'),
//                     onPressed: () {
//                       print(nameController.text);
//                       print(passwordController.text);
//                     },
//                   ),
//                 ),
//                 Row(
//                   children: <Widget>[
//                     const Text('Does not have an account?'),
//                     TextButton(
//                       child: const Text(
//                         'Sign up',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       onPressed: () {
//                         //signup screen
//                       },
//                     ),
//                   ],
//                   mainAxisAlignment: MainAxisAlignment.center,
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 10,
//             child: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
