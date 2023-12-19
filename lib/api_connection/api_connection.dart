class API
{
  static const hostConnect = "http://10.211.102.73/api_kinderjoy";
  static const hostConnectTeacher = "$hostConnect/teacher";
  static const hostConnectParents = "$hostConnect/parents";
  static const hostConnectAdmin = "$hostConnect/admin";
  static const hostUploadItem = "$hostConnect/items";
  static const hostConnectMeal = "$hostConnect/meal";

  //signUp-login teacher
  static const validateID = "$hostConnect/teacher/validate_teacherID.php";
  static const signUp = "$hostConnect/teacher/signup.php";
  static const login = "$hostConnect/teacher/login.php";
  static const delete = "$hostConnect/teacher/delete.php";

  //signUp-login parents
  static const validateChildID = "$hostConnect/parents/validate_childrenID.php";
  static const signUpParents = "$hostConnect/parents/parents_signup.php";
  static const loginParents = "$hostConnect/parents/parents_login.php";
  static const deleteParents = "$hostConnect/parents/parents_delete.php";

  //login admin
  static const loginAdmin = "$hostConnectAdmin/login.php";    //hostConnectAdmin = api folder里面的那个admin folder

  //upload-save new items
  static const uploadNewItem = "$hostUploadItem/upload.php";

  //add meal to cart
  static const createMeal = "$hostConnect/meal/create_meal.php";
}