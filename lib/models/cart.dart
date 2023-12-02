import 'package:flutter/material.dart';
import 'meal.dart';

class Cart extends ChangeNotifier {
  final List<Meal> _mealMenu = [
    //chicken porridge
    Meal(
      imagePath: "lib/images/chicken_porridge.png",
      name: "Chicken Porridge",
      price: "4.90",
      description:
          "Rice, sliced chicken, sesame oil, thinly sliced spring onion, fried shallots",
      day: "Monday",
    ),

    //fried mee hoon
    Meal(
      imagePath: "lib/images/fried_mee_hoon.png",
      name: "Fried Mee Hoon",
      price: "5.50",
      description:
          "Rice vermicelli, egg, luncheon meat, soy sauce, garlic, and seasonings",
      day: "Monday",
    ),

    //fried rice
    Meal(
      imagePath: "lib/images/fried_rice.png",
      name: "Fried Rice",
      price: "5.50",
      description:
          "Cooked rice, spring onion, eggs, shrimp, soy sauce, and seasonings",
      day: "Monday",
    ),

    //bagel
    Meal(
      imagePath: "lib/images/bagel.png",
      name: "Bagel",
      price: "6.50",
      description: "Bagel, ham and cheese",
      day: "Tuesday",
    ),

    // bibimbap
    Meal(
      imagePath: "lib/images/bibimbap.png",
      name: "Bibimbap",
      price: "7.00",
      description: "Rice, vegetable, mushroom, chicken",
      day: "Tuesday",
    ),

    //fruit sandwich
    Meal(
      imagePath: "lib/images/fruit_sandwich.png",
      name: "Fruit sandwich",
      price: "5.50",
      description: "Bread, cream cheese, strawberry",
      day: "Tuesday",
    ),

    //big breakfast
    Meal(
      imagePath: "lib/images/big breakfast.png",
      name: "Big breakfast",
      price: "6.50",
      description: "Bread, tomato slice, egg, strawberry, beef sausage",
      day: "Wednesday",
    ),

    // onigiri
    Meal(
      imagePath: "lib/images/onigiri.png",
      name: "Onigiri",
      price: "5.50",
      description: "Seedweed, rice, tuna",
      day: "Wednesday",
    ),

    // aglio olio
    Meal(
      imagePath: "lib/images/aglio_olio.png",
      name: "Aglio Olio",
      price: "6.50",
      description: "Pasta, shrimp, chilli flakes, garlic",
      day: "Wednesday",
    ),

    // criossant
    Meal(
      imagePath: "lib/images/croissant.png",
      name: "Croissant",
      price: "6.90",
      description: "Croissant, ham, cheese",
      day: "Thursday",
    ),

    //oatmeal
    Meal(
      imagePath: "lib/images/oatmeal.png",
      name: "Oatmeal",
      price: "7.50",
      description: "Oat, milk, walnut, blueberries",
      day: "Thursday",
    ),

    //pancake
    Meal(
      imagePath: "lib/images/pancake.png",
      name: "Pancake",
      price: "6.50",
      description: "Pancake, honey, raspberries, blueberries",
      day: "Thursday",
    ),

    //sandwich
    Meal(
      imagePath: "lib/images/sandwich.png",
      name: "Sandwich",
      price: "5.50",
      description: "Bread, ham, cheese, sliced tomato",
      day: "Friday",
    ),

    //spaghetti
    Meal(
      imagePath: "lib/images/spaghetti.png",
      name: "Spaghetti",
      price: "7.50",
      description: "Pasta, tomato sauce, shrimp, mushroom",
      day: "Friday",
    ),

    //keuytiao
    Meal(
      imagePath: "lib/images/kuey_tiao.png",
      name: "Fried Kuey Tiao",
      price: "6.50",
      description:
          "Flat rice noodles, bean sprouts, chives, eggs, garlic, and soy sauce ",
      day: "Friday",
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
