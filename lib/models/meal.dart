class Meal {
  String id = '';
  String imagePath = '';
  String name = '';
  String price = '';
  String description = '';
  String day = ' ';
  bool isSelected;

  Meal({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.description,
    required this.day,
    required this.isSelected,
  });

  String get _id => id;
  String get _name => name;
  String get _price => price;
  String get _imagePath => imagePath;
  String get _description => description;
  String get _day => day;

  Map<String, dynamic> toJson() =>
      {
        'meal_id': id.toString(),
        'meal_imagePath' : imagePath.toString(),
        'meal_name' : name.toString(),
        'meal_price' : price.toString(),
        'meal_description' : description.toString(),
        'meal_day' : day.toString(),
        'meal_isSelected' : isSelected.toString(),
      };
}