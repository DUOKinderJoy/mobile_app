class Fee
{
  int? fee_id;
  String? children_id;
  double? study_fee;
  double? meals_fee;
  double? service_fee;
  double? total_amount;
  // String? image;
  String? payment_status;
  String? months;



  Fee({
    this.fee_id,
    this.children_id,
    this.study_fee,
    this.meals_fee,
    this.service_fee,
    this.total_amount,
    this.payment_status,
    this.months,
  });

  factory Fee.fromJson(Map<String, dynamic> json)=> Fee(
    fee_id: int.parse(json["fee_id"]),
    children_id: json["children_id"],
    study_fee: double.parse(json["study_fee"]),
    meals_fee: double.parse(json["meals_fee"]),
    service_fee: double.parse(json["service_fee"]),
    total_amount: double.parse(json["total_amount"]),

    // image: json["image"],
    payment_status: json["payment_status"],
    months: json["months"],
    // dateTime: DateTime.parse(json["dateTime"]),
  );

  Map<String, dynamic> toJson()=>
      {
        "fee_id": fee_id.toString(),
        "children_id": children_id,
        "study_fee": study_fee!.toStringAsFixed(2),
        "total_amount": total_amount!.toStringAsFixed(2),
        "meals_fee": meals_fee!.toStringAsFixed(2),
        "service_fee": service_fee!.toStringAsFixed(2),
        "payment_status": payment_status,
        "months": months,
      };
}