import 'package:flutter/material.dart';


class OrderNowScreen extends StatelessWidget{
  final List<Map<String, dynamic>>? selectedCartListItemsInfo;
  final double? totalAmount;
  final List<int>? selectedCartIDs;

  OrderNowScreen({
    this.selectedCartListItemsInfo,
    this.totalAmount,
    this.selectedCartIDs,
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView
        (
        children: [

        ],
      ),
    );
  }
}