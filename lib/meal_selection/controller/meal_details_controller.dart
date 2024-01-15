import 'package:get/get.dart';

class MealDetailsController extends GetxController
{
  RxInt _quantityMeal = 1.obs;
  RxInt _sizeMeal = 0.obs;
  RxInt _optionMeal = 0.obs;
  RxBool _isFavorite = false.obs;

  int get quantity => _quantityMeal.value;
  int get size => _sizeMeal.value;
  int get option => _optionMeal.value;
  bool get isFavorite => _isFavorite.value;

  setQuantityMeal(int quantityOfMeal)
  {
    _quantityMeal.value = quantityOfMeal;
  }

  setSizeMeal(int sizeOfMeal)
  {
    _sizeMeal.value = sizeOfMeal;
  }

  setOptionMeal(int optionOfMeal)
  {
    _optionMeal.value = optionOfMeal;
  }

  setIsFavorite(bool isFavorite)
  {
    _isFavorite.value = isFavorite;
  }
}