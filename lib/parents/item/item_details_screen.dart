import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kinder_joy_1/parents/parentsModel/dashboard.dart';

class ItemDetailsScreen extends StatefulWidget
{
  final Clothes? itemInfo;

  ItemDetailsScreen({this.itemInfo,});

  @override
  State<ItemDetailsScreen> createState()=> _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:  NetworkImage(
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
            imageErrorBuilder: (context, error, stackTraceError)
            {
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
          )
        ],
      )

    );
  }

  itemInfoWidget()
  {
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
            color: Colors.purpleAccent,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18,),

            Center(
              child: Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(height: 30,),

            //name
            Text(
              widget.itemInfo!.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10,),

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
                              "Date: "+widget.itemInfo!.date!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          //
                            const SizedBox(height: 10,),
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

                        const SizedBox(height: 8,),

                        //tags
                        Text(
                          widget.itemInfo!.tags!.toString().replaceAll("[", "").replaceAll("]", ""),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ) ,
                ),
              ],
            ),

            const SizedBox(height: 18,),

            //Description
            const Text(
              "Description:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.itemInfo!.description!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}