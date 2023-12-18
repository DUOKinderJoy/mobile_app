class Parents
{
  String parents_name;
  String parents_no;
  String children_id;
  String children_name;
  String parents_address;

  Parents(
      this.parents_name,
      this.parents_no,
      this.children_id,
      this.children_name,
      this.parents_address,
      // this.parents_address,
      );

  factory Parents.fromJson(Map<String, dynamic> json) => Parents(
    json["parents_name"],
    json["parents_no"],
    json["children_id"],
    json["children_name"],
    json["parents_address"],
  );

  Map<String, dynamic> toJson() =>
      {
        'parents_name': parents_name,
        'parents_no': parents_no,
        'children_id': children_id,
        'children_name': children_name,
        'parents_address': parents_address,
      };
}