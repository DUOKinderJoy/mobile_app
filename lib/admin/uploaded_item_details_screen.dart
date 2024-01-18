import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinder_joy_1/admin/uploaded_event_screen.dart';
import 'package:kinder_joy_1/parents/parentsModel/dashboard.dart';
import 'package:http/http.dart' as http;

import '../api_connection/api_connection.dart';
import 'admin_upload_items.dart';


class UploadedItemDetailsScreen extends StatefulWidget {
  final Clothes? itemInfo;

  UploadedItemDetailsScreen({
    this.itemInfo,
  });

  @override
  State<UploadedItemDetailsScreen> createState() => _UploadedItemDetailsScreenState();
}

class _UploadedItemDetailsScreenState extends State<UploadedItemDetailsScreen> {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var dateController = TextEditingController();
  var tagsController = TextEditingController();
  var descriptionController = TextEditingController();

  DeleteEvent() async
  {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Delete event",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure?\nYou want to delete this event?",
        ),
        actions: [
          TextButton(
              onPressed: ()
              {
                Get.back();
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
          ),
          TextButton(
              onPressed: ()
              {
                Get.back(result: "Delete");
              },
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
          ),

        ],
      ),
    );

    if(resultResponse == 'Delete')
    {
      try
      {
        var res = await http.post(
          Uri.parse(API.deleteItem),
          body: {
            "name": widget.itemInfo!.name!,
          },
        );
        if(res.statusCode == 200)   //http 200 = success communicated with server (flutter with API to server)
            {
          Fluttertoast.showToast(msg: "Delete successfully.");
          Get.to(UploadedEventScreen());

          // RememberTeacherPres.removeTeacherInfo()
          //     .then((value)
          // {
          //   Get.off(RolesOp());
          // });

        }
      }
      catch(errorMsg)
      {
        print("Error::" + errorMsg.toString());
      }
    }
  }

  saveItemInfoToDatabase() async {
    List<String> tagsList = tagsController.text.split(',');

    try {
      var response = await http.post(
        Uri.parse(API.updateItem),
        body: {
          'item_id': widget.itemInfo!.item_id!.toString(),
          'name': nameController.text.trim().toString(),
          'date': dateController.text.trim().toString(),
          'tags': tagsList.toString(),
          'description': descriptionController.text.trim().toString(),
        },
      );

      if (response.statusCode == 200) {
        var resBodyOfUploadItem = jsonDecode(response.body);

        if (resBodyOfUploadItem['success'] == true) {
          Fluttertoast.showToast(msg: "Event details modify successfully");

          setState(() {
            nameController.clear();
            dateController.clear();
            tagsController.clear();
            descriptionController.clear();
          });

          Get.to(UploadedEventScreen());
        } else {
          Fluttertoast.showToast(msg: "Event not modified. Error, Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error:: " + errorMsg.toString());
    }
  }


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
          "Modify Form",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              nameController.clear();
              dateController.clear();
              tagsController.clear();
              descriptionController.clear();
            });

            Get.to(UploadedEventScreen());
          },
          icon: const Icon(
            Icons.clear,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              saveItemInfoToDatabase();

              Fluttertoast.showToast(msg: "Modify now...");

              // saveItemInfoToDatabase();
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
          // image
          Container(
            height:
            MediaQuery.of(context).size.height * 0.5, //follow phone size
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.itemInfo!.image!.toString(),
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
                          TextFormField(
                            controller: dateController,
                            validator: (val) =>
                            val == "" ? "Please give Event Date" : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.rate_review,
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

                          //item tags
                          TextFormField(
                            controller: tagsController,
                            validator: (val) =>
                            val == "" ? "Please write event tags" : null,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.tag,
                                color: Colors.black,
                              ),
                              hintText: "Event tags",
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
                                      msg: "Modify now...");

                                  saveItemInfoToDatabase();
                                }
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 28,
                                ),
                                child: Text(
                                  "Modify Now",
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
    return Scaffold(
        backgroundColor: Colors.brown,
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

            //item image
            FadeInImage(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              placeholder: const AssetImage("images/place_holder.png"),
              image: NetworkImage(
                widget.itemInfo!.image!,
              ),
              imageErrorBuilder: (context, error, stackTraceError) {
                return const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                  ),
                );
              },
            ),

            //item information
            Align(
              alignment: Alignment.bottomCenter,
              child: itemInfoWidget(),

            ),

            // Positioned(
            //   bottom: 16, // You can adjust this value to set the distance from the bottom
            //   left: 0,
            //   right: 0,
            //   child: Center(
            //     child: Material(
            //       color: Colors.redAccent,
            //       borderRadius: BorderRadius.circular(8),
            //       child: InkWell(
            //         onTap: () {
            //           DeleteEvent();
            //         },
            //         borderRadius: BorderRadius.circular(32),
            //         child: const Padding(
            //           padding: EdgeInsets.symmetric(
            //             horizontal: 30,
            //             vertical: 12,
            //           ),
            //           child: Text(
            //             "Delete event",
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 16,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Positioned(
            //   bottom: 16, // You can adjust this value to set the distance from the bottom
            //   left: 0,
            //   right: 0,
            //   child: Center(
            //     child: Material(
            //       color: Colors.redAccent,
            //       borderRadius: BorderRadius.circular(8),
            //       child: InkWell(
            //         onTap: () {
            //           DeleteEvent();
            //         },
            //         borderRadius: BorderRadius.circular(32),
            //         child: const Padding(
            //           padding: EdgeInsets.symmetric(
            //             horizontal: 30,
            //             vertical: 12,
            //           ),
            //           child: Text(
            //             "Delete event",
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 16,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Positioned(
              bottom: 16, // You can adjust this value to set the distance from the bottom
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      color: Colors.blue, // Change the color as needed
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () {
                          Get.to(uploadItemFormScreen());
                          // Handle the second button tap
                        },
                        borderRadius: BorderRadius.circular(32),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          child: Text(
                            "Modify Event",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16), // Adjust the spacing between buttons
                    Material(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () {
                          DeleteEvent();
                        },
                        borderRadius: BorderRadius.circular(32),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                          child: Text(
                            "Delete event",
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
            ),
          ],
        ));
  }

  itemInfoWidget() {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.60,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Colors.deepPurple,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),

            Center(
              child: Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            //name
            Text(
              widget.itemInfo!.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.ovo(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //date + day
                      Row(
                        children: [
                          Text(
                            "Date: " + widget.itemInfo!.date!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.ovo(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //
                          const SizedBox(
                            height: 10,
                          ),
                          //
                          //   // Text(
                          //   //   "(" + widget.itemInfo!.name!+")",
                          //   //   style: const TextStyle(
                          //   //     fontSize: 24,
                          //   //     color: Colors.black,
                          //   //   ),
                          //   // ),
                          //
                        ],
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      //tags
                      Text(
                        widget.itemInfo!.tags!
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 18,
            ),

            //Description
            Text(
              "Description:",
              style: GoogleFonts.ovo(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.itemInfo!.description!,
              textAlign: TextAlign.justify,
              style: GoogleFonts.ovo(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
