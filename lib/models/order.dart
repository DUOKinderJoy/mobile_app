class Order
{
  int? order_id;
  String? children_id;
  String? selectedItems;
  double? totalAmount;
  // String? image;
  String? status;
  int? week;
  String? month;


  Order({
    this.order_id,
    this.children_id,
    this.selectedItems,
    this.totalAmount,
    // this.image,
    this.status,
    this.week,
    this.month,
    // this.dateTime,
  });

  factory Order.fromJson(Map<String, dynamic> json)=> Order(
    order_id: int.parse(json["order_id"]),
    children_id: json["children_id"],
    selectedItems: json["selectedItems"],
    totalAmount: double.parse(json["totalAmount"]),
    // image: json["image"],
    status: json["status"],
    week: int.parse(json["week"]),
    month: json["month"],
    // dateTime: DateTime.parse(json["dateTime"]),
  );

  Map<String, dynamic> toJson()=>
      {
        "order_id": order_id.toString(),
        "children_id": children_id,
        "selectedItems": selectedItems,
        "totalAmount": totalAmount!.toStringAsFixed(2),
        "status": status,
        "week": week.toString(),
        "month": month,
      };
}