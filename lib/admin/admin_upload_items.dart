import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kinder_joy_1/admin/admin_get_all_orders.dart';
import 'package:kinder_joy_1/admin/admin_login.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';

class AdminUploadItemsScreen extends StatefulWidget {
  @override
  State<AdminUploadItemsScreen> createState() => _AdminUploadItemsScreenState();
}

class _AdminUploadItemsScreenState extends State<AdminUploadItemsScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImageXFile;

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  // var ratingController = TextEditingController();
  var dateController = TextEditingController();
  var tagsController = TextEditingController();
  // var priceController = TextEditingController();
  // var sizesController = TextEditingController();
  // var colorsController = TextEditingController();
  var descriptionController = TextEditingController();
  var imageLink = "";

  //defaultScreen methods
  captureImageWithPhoneCamera() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);

    Get.back();

    setState(() => pickedImageXFile);
  }

  pickImageFromPhoneGallery() async {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);

    Get.back();

    setState(() => pickedImageXFile);
  }

  showDialogBoxForImagePickingAndCapturing() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            // backgroundColor: Colors.black,
            title: const Text(
              "Event Image",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  captureImageWithPhoneCamera();
                },
                child: const Text(
                  "Capture with Phone Camera",
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  pickImageFromPhoneGallery();
                },
                child: const Text(
                  "Pick Image From Phone Gallery",
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
            ],
          );
        });
  }
  //defaultScreen methods ends here

  Widget defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent,
                Colors.deepPurple,
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text("Upload Dashboard Form"),
        centerTitle: true,
      ),
      // body: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [
      //         Colors.black54,
      //         Colors.deepPurple,
      //       ],
      //     ),
      //   ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
            ),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.black54,
              Colors.deepPurple,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_photo_alternate,
                color: Colors.purple,
                size: 100,
              ),

              //button
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: () {
                    showDialogBoxForImagePickingAndCapturing();
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 28,
                    ),
                    child: Text(
                      "Add Event",
                      style: GoogleFonts.ovo(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //uploadItemFormScreen methods
  uploadItemImage() async {
    var requestImgurApi = http.MultipartRequest(
        "POST", Uri.parse("https://api.imgur.com/3/image"));

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    requestImgurApi.fields['title'] = imageName;
    requestImgurApi.headers['Authorization'] = "Client-ID " + "6ca0d6456311e4d";

    var imageFile = await http.MultipartFile.fromPath(
      'image',
      pickedImageXFile!.path,
      filename: imageName,
    );

    requestImgurApi.files.add(imageFile);
    var responseFromImgurApi = await requestImgurApi.send();

    var responseDataFromImgurApi = await responseFromImgurApi.stream.toBytes();
    var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);

    Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);
    imageLink = (jsonRes["data"]["link"]).toString();
    String deleteHash = (jsonRes["data"]["deletehash"]).toString();

    saveItemInfoToDatabase();
  }

  saveItemInfoToDatabase() async {
    List<String> tagsList = tagsController.text.split(',');
    // List<String> sizesList = sizesController.text.split(',');
    // List<String> colorsList = colorsController.text.split(',');

    try {
      var response = await http.post(
        Uri.parse(API.uploadNewItem),
        body: {
          'item_id': '1',
          'name': nameController.text.trim().toString(),
          // 'rating': ratingController.text.trim().toString(),
          'date': dateController.text.trim().toString(),
          'tags': tagsList.toString(),
          // 'price': priceController.text.trim().toString(),
          // 'sizes': sizesList.toString(),
          // 'colors': colorsList.toString(),
          'description': descriptionController.text.trim().toString(),
          'image': imageLink.toString(),
        },
      );

      if (response.statusCode == 200) {
        var resBodyOfUploadItem = jsonDecode(response.body);

        if (resBodyOfUploadItem['success'] == true) {
          Fluttertoast.showToast(msg: "New item uploaded successfully");

          setState(() {
            pickedImageXFile = null;
            nameController.clear();
            // ratingController.clear();
            dateController.clear();
            tagsController.clear();
            // priceController.clear();
            // sizesController.clear();
            // colorsController.clear();
            descriptionController.clear();
          });

          Get.to(AdminUploadItemsScreen());
        } else {
          Fluttertoast.showToast(msg: "Item not uploaded. Error, Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error:: " + errorMsg.toString());
    }
  }
  //uploadItemFormScreen methods ends here

  Widget uploadItemFormScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.purpleAccent,
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "Upload Form",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              pickedImageXFile = null;
              nameController.clear();
              // ratingController.clear();
              dateController.clear();
              tagsController.clear();
              // priceController.clear();
              // sizesController.clear();
              // colorsController.clear();
              descriptionController.clear();
            });

            Get.to(AdminUploadItemsScreen());
          },
          icon: const Icon(
            Icons.clear,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Fluttertoast.showToast(msg: "Uploading now...");

              uploadItemImage();
            },
            child: const Text(
              "Done",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          //image
          Container(
            height:
                MediaQuery.of(context).size.height * 0.5, //follow phone size
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(
                  File(pickedImageXFile!.path),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //upload item form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.blueAccent,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                child: Column(
                  children: [
                    //email-password-login button
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          //item name
                          TextFormField(
                            controller: nameController,
                            validator: (val) =>
                                val == "" ? "Please write event name" : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.title,
                                color: Colors.black,
                              ),
                              hintText: "Event Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              fillColor: Colors.purple[20],
                              filled: true,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // // item ratings
                          // TextFormField(
                          //   controller: dateController,
                          //   validator: (val) =>
                          //       val == "" ? "Please give Event Date" : null,
                          //   decoration: InputDecoration(
                          //     prefixIcon: const Icon(
                          //       Icons.rate_review,
                          //       color: Colors.black,
                          //     ),
                          //     hintText: "Event Date",
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     disabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     contentPadding: const EdgeInsets.symmetric(
                          //       horizontal: 14,
                          //       vertical: 6,
                          //     ),
                          //     fillColor: Colors.purple[20],
                          //     filled: true,
                          //   ),
                          // ),

                          // const SizedBox(
                          //   height: 18,
                          // ),

                          //item tags
                          TextFormField(
                            controller: tagsController,
                            validator: (val) =>
                                val == "" ? "Please write event date" : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.tag,
                                color: Colors.black,
                              ),
                              hintText: "Event Date",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              fillColor: Colors.purple[20],
                              filled: true,
                            ),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          //item price
                          // TextFormField(
                          //   controller: priceController,
                          //   validator: (val) => val == "" ? "Please write item price" : null,
                          //   decoration: InputDecoration(
                          //     prefixIcon: const Icon(
                          //       Icons.price_change_outlined,
                          //       color: Colors.black,
                          //     ),
                          //     hintText: "item price...",
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     disabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     contentPadding: const EdgeInsets.symmetric(
                          //       horizontal: 14,
                          //       vertical: 6,
                          //     ),
                          //     fillColor: Colors.white,
                          //     filled: true,
                          //   ),
                          // ),

                          //item sizes
                          // TextFormField(
                          //   controller: sizesController,
                          //   validator: (val) => val == "" ? "Please write item sizes" : null,
                          //   decoration: InputDecoration(
                          //     prefixIcon: const Icon(
                          //       Icons.picture_in_picture,
                          //       color: Colors.black,
                          //     ),
                          //     hintText: "item size...",
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     disabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     contentPadding: const EdgeInsets.symmetric(
                          //       horizontal: 14,
                          //       vertical: 6,
                          //     ),
                          //     fillColor: Colors.white,
                          //     filled: true,
                          //   ),
                          // ),

                          //item colors
                          // TextFormField(
                          //   controller: colorsController,
                          //   validator: (val) => val == "" ? "Please write item colors" : null,
                          //   decoration: InputDecoration(
                          //     prefixIcon: const Icon(
                          //       Icons.color_lens,
                          //       color: Colors.black,
                          //     ),
                          //     hintText: "item colors...",
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     focusedBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     disabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(30),
                          //       borderSide: const BorderSide(
                          //         color: Colors.white60,
                          //       ),
                          //     ),
                          //     contentPadding: const EdgeInsets.symmetric(
                          //       horizontal: 14,
                          //       vertical: 6,
                          //     ),
                          //     fillColor: Colors.white,
                          //     filled: true,
                          //   ),
                          // ),

                          //item description
                          TextFormField(
                            controller: descriptionController,
                            validator: (val) => val == ""
                                ? "Please write event description"
                                : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.description,
                                color: Colors.black,
                              ),
                              hintText: "Event Description...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              fillColor: Colors.purple[20],
                              filled: true,
                            ),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          //button
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  Fluttertoast.showToast(
                                      msg: "Uploading now...");

                                  uploadItemImage();
                                }
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 28,
                                ),
                                child: Text(
                                  "Upload Now",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pickedImageXFile == null ? defaultScreen() : uploadItemFormScreen();
  }
}
