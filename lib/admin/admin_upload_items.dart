import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kinder_joy_1/admin/admin_login.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';

class AdminUploadItems extends StatefulWidget
{
  @override
  State<AdminUploadItems> createState() => _AdminUploadItemsState();
}

class _AdminUploadItemsState extends State<AdminUploadItems>
{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var ratingController = TextEditingController();
  var tagsController = TextEditingController();
  var priceController = TextEditingController();
  var sizesController = TextEditingController();
  var colorsController = TextEditingController();
  var descriptionController = TextEditingController();
  var imageLink = "";

  ImagePicker _picker = ImagePicker();
  XFile? pickedImageXFile;

  //defaultScreen methods
  captureImageWithPhoneCamera() async
  {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);

    Get.back();

    setState(() => pickedImageXFile);
  }

  pickImageFromPhoneGallery() async
  {
    pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);

    Get.back();

    setState(() => pickedImageXFile);

  }

  showDialogBoxForImagePickingAndCapturing()
  {
    return showDialog(
        context: context,
        builder: (context)
        {
          return SimpleDialog(
            title: const Text(
              "Item Image",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              )
            ),
            children: [
              SimpleDialogOption(
                onPressed: ()
                {
                  captureImageWithPhoneCamera();
                },
                child: const Text(
                  "Capture with phone camera",
                  style: TextStyle(
                    color: Colors.purple,

                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: ()
                {
                  pickImageFromPhoneGallery();
                },
                child: const Text(
                  "Select Image from phone gallery",
                  style: TextStyle(
                    color: Colors.purple,

                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: ()
                {
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

        }
    );
  }
  //defaultScreen methods end here

  Widget defaultScreen()
  {
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
        title: Text(
          "Admin site",
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:  NetworkImage(
              "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_photo_alternate,
                color: Colors.purple,
                size: 50,
              ),

              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: ()
                  {
                    showDialogBoxForImagePickingAndCapturing();
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Text(
                      "Add New Item",
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
      ),
    );
  }


  //UploadItemFormScreen methods
  uploadItemImage() async
  {
    var requestImgurApi = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.imgur.com/3/image")
    );

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    requestImgurApi.fields['title'] = imageName;
    requestImgurApi.headers['Authorization'] = "Client-ID " + "3d86816278d7c0b";

    var imageFile = await http.MultipartFile.fromPath(
        'image',
        pickedImageXFile!.path,
      filename: imageName,
    );

    requestImgurApi.files.add(imageFile);
    var responseFromImgurApi = await requestImgurApi.send();

    var responseDataFromImgurApi = await responseFromImgurApi.stream.toBytes();
    var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);

    // print("Result :: ");   //just for testing purpose
    // print(resultFromImgurApi);

    Map<String, dynamic>jsonRes = json.decode(resultFromImgurApi);
    imageLink = (jsonRes["data"]["link"]).toString();
    String deleteHash = (jsonRes["data"]["deletehash"]).toString();

    saveItemInfoToDatabase();
    // print("imageLink :: ");    //just for testing
    // print(imageLink);
    //
    // print("deleteHash :: ");
    // print(deleteHash);
  }
  //UploadItemFormScreen methods ends here

  saveItemInfoToDatabase() async
  {
    List<String> tagsList = tagsController.text.split(',');

    try
    {
      var response = await http.post(
        Uri.parse(API.hostUploadItem),
        body:
        {
          'item_id': '1',
          'item_name': nameController.text.trim().toString(),
          'item_tags': tagsList.toString(),
          'item_description': descriptionController.text.trim().toString(),
          'item_image': imageLink.toString(),
        },
      );

      if(response.statusCode == 200)
      {
        var resBodyOfUploadItem = jsonDecode(response.body);

        if(resBodyOfUploadItem['success'] == true)
        {
          Fluttertoast.showToast(msg: "New item uploaded successfully.");
        }
        else
        {
          Fluttertoast.showToast(msg: "New item uploaded unsuccessfully. Try again");
        }
      }
    }
    catch(errorMsg)
    {
      print("Error: "+errorMsg.toString());
    }
  }

  Widget uploadItemsFormScreen()
  {
    return Scaffold(
      backgroundColor: Colors.black,
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
        title: Text(
          "Upload Form",
          style: TextStyle(
            color: Colors.white24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: ()
          {
            Get.to(AdminLoginPage());
          },
          icon: const Icon(
            Icons.clear,
          ),
        ),
        actions: [
          TextButton(
              onPressed: ()
              {
                Get.to(AdminLoginPage());
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
            // height: 240,
            height: MediaQuery.of(context).size.height * 0.3,  //follow phone size
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

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.all(
                  Radius.circular(60),
                ),
                boxShadow: [
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
                            validator: (val) => val == "" ? "Please write item name" : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.title,
                                color: Colors.black,
                              ),
                              hintText: "item name...",
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
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),

                          const SizedBox(height: 18,),

                          //item ratings
                          // TextFormField(
                          //   controller: ratingController,
                          //   validator: (val) => val == "" ? "Please give item rating" : null,
                          //   decoration: InputDecoration(
                          //     prefixIcon: const Icon(
                          //       Icons.rate_review,
                          //       color: Colors.black,
                          //     ),
                          //     hintText: "item rating...",
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

                          // const SizedBox(height: 18,),

                          //item tags
                          TextFormField(
                            controller: tagsController,
                            validator: (val) => val == "" ? "Please write item tags" : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.tag,
                                color: Colors.black,
                              ),
                              hintText: "item tags...",
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
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),

                          // const SizedBox(height: 18,),

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

                          // const SizedBox(height: 18,),

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

                          // const SizedBox(height: 18,),

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

                          const SizedBox(height: 18,),

                          //item description
                          TextFormField(
                            controller: descriptionController,
                            validator: (val) => val == "" ? "Please write item description" : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.description,
                                color: Colors.black,
                              ),
                              hintText: "item description...",
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
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),

                          const SizedBox(height: 18,),

                          //button
                          Material(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  Fluttertoast.showToast(msg: "Uploading now...");

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
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],

      ),

    );
  }


  @override
  Widget build(BuildContext context)
  {
    return pickedImageXFile == null ? defaultScreen() : uploadItemsFormScreen();    //? means if, : means else
  }
}