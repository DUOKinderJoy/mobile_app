class Clothes
{
  int? item_id;
  String? name;
  // double? rating;
  List<String>? tags;
  // double? price;
  // List<String>? sizes;
  // List<String>? colors;
  String? date;
  String? description;
  String? image;

  Clothes({
    this.item_id,
    this.name,
    // this.rating,
    this.tags,
    // this.price,
    // this.sizes,
    // this.colors,
    this.date,
    this.description,
    this.image,
  });

  factory Clothes.fromJson(Map<String, dynamic> json) => Clothes(
    item_id: int.parse(json["item_id"]),
    name: json["name"],
    // rating: double.parse(json["rating"]),
    tags: json["tags"].toString().split(", "),
    // price: double.parse(json["price"]),
    // sizes: json["sizes"].toString().split(", "),
    // colors: json["colors"].toString().split(", "),
    date: json['date'],
    description: json['description'],
    image: json['image'],
  );
}

// class Dashboard
// {
//   int? item_id;
//   String? item_name;
//   List<String>? item_tags;
//   String? item_description;
//   String? item_image;
//
//   Dashboard({
//     this.item_id,
//     this.item_name,
//     this.item_tags,
//     this.item_description,
//     this.item_image,
//   });
//
//   factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
//     item_id: int.parse(json["item_id"]),
//     item_name: json["item_name"],
//     item_tags: json["item_tags"].toString().split(", "),
//     item_description: json['item_description'],
//     item_image: json['item_image'],
//   );
// }