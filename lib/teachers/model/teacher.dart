class Teacher
{
  String teacher_name;
  String teacher_no;
  String teacher_id;
  String teacher_address;

  Teacher(
      this.teacher_name,
      this.teacher_no,
      this.teacher_id,
      this.teacher_address,
  );

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
      json["teacher_name"],
      json["teacher_no"],
      json["teacher_id"],
      json["teacher_address"],
  );

  Map<String, dynamic> toJson() =>
      {
        'teacher_name': teacher_name,
        'teacher_no': teacher_no,
        'teacher_id': teacher_id,
        'teacher_address': teacher_address,
      };
}