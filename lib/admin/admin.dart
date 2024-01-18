class Admin
{
  String admin_name;
  String admin_email;
  int admin_id;
  String admin_password;

  Admin(
      this.admin_name,
      this.admin_email,
      this.admin_id,
      this.admin_password,
      );

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    json["admin_name"],
    json["admin_email"],
    int.parse(json["admin_id"]),
    json["admin_password"],
  );

  Map<String, dynamic> toJson() =>
      {
        'admin_name': admin_name,
        'admin_email': admin_email,
        'admin_id': admin_id.toString(),
        'admin_password': admin_password,
      };
}