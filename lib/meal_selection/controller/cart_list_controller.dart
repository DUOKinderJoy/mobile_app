// import 'package:clothes_app/users/model/cart.dart';
import 'package:get/get.dart';

import '../../models/cart.dart';

class CartListController extends GetxController
{
  RxList<Cart> _cartlist = <Cart>[].obs; //user all items in cart + record //5
  RxList<int> _selectedMealList = <int>[].obs; //user selected items for which user want to proceed and want to place final order //2
  RxBool _isSelectedAll = false.obs;
  RxDouble _total = 0.0.obs;

  List<Cart> get cartList => _cartlist.value;
  List<int> get selectedMealList => _selectedMealList.value;
  bool get isSelectedAll => _isSelectedAll.value;
  double get total => _total.value;

  setList(List<Cart> list)
  {
    _cartlist.value = list;
  }

  addSelectedMeal(int selectedMealCartID)
  {
    _selectedMealList.value.add(selectedMealCartID);
    update();
  }

  deleteSelectedMeal(int selectedMealCartID)
  {
    _selectedMealList.value.remove(selectedMealCartID);
    update();
  }

  setIsSelectedAllMeals()
  {
                           //true
    _isSelectedAll.value = !_isSelectedAll.value;
  }

  clearAllSelectedMeals()
  {
    _selectedMealList.value.clear();
    update();
  }

  setTotal(double overallTotal)
  {
    _total.value = overallTotal;
  }

}
