class Meals
{
  int? meal_id;
  String? name;
  String? week;
  String? month;
  double? price;
  String? days;
  List<String>? options;
  String? description;
  String? image;

  Meals({
    this.meal_id,
    this.name,
    this.week,
    this.month,
    this.price,
    this.days,
    this.options,
    this.description,
    this.image,
  });

  factory Meals.fromJson(Map<String, dynamic> json) => Meals(
    meal_id: int.parse(json["meal_id"]),
    name: json["name"],
    week: json["week"],
    month:json["month"],
    price: double.parse(json["price"]),
    days: json["days"],
    options: json["options"].toString().split(", "),
    description: json['description'],
    image: json['image'],
  );
}