class Meal {
  String imagePath = '';
  String name = '';
  String price = '';
  String description = '';
  String day = ' ';

  Meal({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.description,
    required this.day,
  });

  String get _name => name;
  String get _price => price;
  String get _imagePath => imagePath;
  String get _description => description;
  String get _day => day;
}
