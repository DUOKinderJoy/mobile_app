// import 'package:clothes_app/users/model/cart.dart';
import 'package:get/get.dart';
import 'package:kinder_joy_1/models/order.dart';

import '../../models/cart.dart';

class StudyFeeController extends GetxController
{
  RxList<Order> _feelist = <Order>[].obs; //user all items in cart + record //5
  RxList<int> _selectedFeeList = <int>[].obs; //user selected items for which user want to proceed and want to place final order //2
  RxBool _isSelectedAll = true.obs;
  RxDouble _total = 0.0.obs;
  RxDouble _totalOrder = 0.0.obs;

  List<Order> get feeList => _feelist.value;
  List<int> get selectedFeeList => _selectedFeeList.value;
  bool get isSelectedAll => _isSelectedAll.value;
  double get total => _total.value;
  double get totalOrder => _totalOrder.value;

  setList(List<Order> list)
  {
    _feelist.value = list;
  }
  //
  addSelectedFee(int selectedOrderID)
  {
    _selectedFeeList.value.add(selectedOrderID);
    update();
  }

  deleteSelectedFee(int selectedMealCartID)
  {
    _selectedFeeList.value.remove(selectedMealCartID);
    update();
  }
  //
  // deleteSelectedMeal(int selectedMealCartID)
  // {
  //   _selectedMealList.value.remove(selectedMealCartID);
  //   update();
  // }
  //
  // setIsSelectedAllMeals()
  // {
  //   //true
  //   _isSelectedAll.value = !_isSelectedAll.value;
  // }
  //
  // clearAllSelectedMeals()
  // {
  //   _selectedMealList.value.clear();
  //   update();
  // }

  setTotal(double overallTotal)
  {
    _total.value = overallTotal;
  }

  setTotalOrder(double overallTotalOrder)
  {
    _totalOrder.value = overallTotalOrder;
  }

}
