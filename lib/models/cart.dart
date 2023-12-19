import 'package:flutter/material.dart';
import 'meal.dart';

class Cart extends ChangeNotifier {
  final List<Meal> _mealMenu = [
    //chicken porridge
    Meal(
      id: "M001",
      imagePath: "lib/images/chicken_porridge.png",
      name: "Chicken Porridge",
      price: "4.90",
      description:
          "Rice, sliced chicken, sesame oil, thinly sliced spring onion, fried shallots",
      day: "Monday",
      isSelected: false,
    ),

    //fried mee hoon
    Meal(
      id: "M002",
      imagePath: "lib/images/fried_mee_hoon.png",
      name: "Fried Mee Hoon",
      price: "5.50",
      description:
          "Rice vermicelli, egg, luncheon meat, soy sauce, garlic, and seasonings",
      day: "Monday",
      isSelected: false,
    ),

    //fried rice
    Meal(
      id: "M003",
      imagePath: "lib/images/fried_rice.png",
      name: "Fried Rice",
      price: "5.50",
      description:
          "Cooked rice, spring onion, eggs, shrimp, soy sauce, and seasonings",
      day: "Monday",
      isSelected: false,
    ),

    //bagel
    Meal(
      id: "M004",
      imagePath: "lib/images/bagel.png",
      name: "Bagel",
      price: "6.50",
      description: "Bagel, ham and cheese",
      day: "Tuesday",
      isSelected: false,
    ),

    // bibimbap
    Meal(
      id: "M005",
      imagePath: "lib/images/bibimbap.png",
      name: "Bibimbap",
      price: "7.00",
      description: "Rice, vegetable, mushroom, chicken",
      day: "Tuesday",
      isSelected: false,
    ),

    //fruit sandwich
    Meal(
      id: "M006",
      imagePath: "lib/images/fruit_sandwich.png",
      name: "Fruit sandwich",
      price: "5.50",
      description: "Bread, cream cheese, strawberry",
      day: "Tuesday",
      isSelected: false,
    ),

    //big breakfast
    Meal(
      id: "M007",
      imagePath: "lib/images/big breakfast.png",
      name: "Big breakfast",
      price: "6.50",
      description: "Bread, tomato slice, egg, strawberry, beef sausage",
      day: "Wednesday",
      isSelected: false,
    ),

    // onigiri
    Meal(
      id: "M008",
      imagePath: "lib/images/onigiri.png",
      name: "Onigiri",
      price: "5.50",
      description: "Seedweed, rice, tuna",
      day: "Wednesday",
      isSelected: false,
    ),

    // aglio olio
    Meal(
      id: "M009",
      imagePath: "lib/images/aglio_olio.png",
      name: "Aglio Olio",
      price: "6.50",
      description: "Pasta, shrimp, chilli flakes, garlic",
      day: "Wednesday",
      isSelected: false,
    ),

    // criossant
    Meal(
      id: "M010",
      imagePath: "lib/images/croissant.png",
      name: "Croissant",
      price: "6.90",
      description: "Croissant, ham, cheese",
      day: "Thursday",
      isSelected: false,
    ),

    //oatmeal
    Meal(
      id: "M011",
      imagePath: "lib/images/oatmeal.png",
      name: "Oatmeal",
      price: "7.50",
      description: "Oat, milk, walnut, blueberries",
      day: "Thursday",
      isSelected: false,
    ),

    //pancake
    Meal(
      id: "M012",
      imagePath: "lib/images/pancake.png",
      name: "Pancake",
      price: "6.50",
      description: "Pancake, honey, raspberries, blueberries",
      day: "Thursday",
      isSelected: false,
    ),

    //sandwich
    Meal(
      id: "M012",
      imagePath: "lib/images/sandwich.png",
      name: "Sandwich",
      price: "5.50",
      description: "Bread, ham, cheese, sliced tomato",
      day: "Friday",
      isSelected: false,
    ),

    //spaghetti
    Meal(
      id: "M013",
      imagePath: "lib/images/spaghetti.png",
      name: "Spaghetti",
      price: "7.50",
      description: "Pasta, tomato sauce, shrimp, mushroom",
      day: "Friday",
      isSelected: false,
    ),

    //keuytiao
    Meal(
      id: "M0014",      
      imagePath: "lib/images/kuey_tiao.png",
      name: "Fried Kuey Tiao",
      price: "6.50",
      description:
          "Flat rice noodles, bean sprouts, chives, eggs, garlic, and soy sauce ",
      day: "Friday",
      isSelected: false,
    ),
  ];

  //Cart
  final List<Meal> _cart = [];

  //getter methods
  List<Meal> get mealMenu => _mealMenu;
  List<Meal> get cart => _cart;

  //add to Cart
  void addToCart(Meal mealItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(mealItem);
      notifyListeners();
    }
  }
}
