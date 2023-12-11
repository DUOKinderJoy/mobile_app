import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../parentsModel/parents.dart';

class RememberParentsPres
{
  //save user info
  static Future<void> storeParentsInfo (Parents parentsInfo) async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String parentsJsonData = jsonEncode(parentsInfo.toJson());
    await preferences.setString("currentParents", parentsJsonData);
  }

  //get-read Parents - info
  static Future<Parents?> readParentsInfo() async
  {
    Parents? currentParentsInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? parentsInfo = preferences.getString("currentParents");
    if(parentsInfo != null)
    {
      Map<String, dynamic> parentsDataMap = jsonDecode(parentsInfo);
      currentParentsInfo = Parents.fromJson(parentsDataMap);
    }
    return currentParentsInfo;
  }


  static Future<void> removeParentsInfo() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentParents");
  }
}