class API {
  static const hostConnect = "http://192.168.188.29/api_kinderjoy";
  static const hostConnectTeacher = "$hostConnect/teacher";
  static const hostConnectMeal = "$hostConnect/meal";

  //signUp teacher
  static const validateID = "$hostConnect/teacher/validate_teacherID.php";
  static const signUp = "$hostConnect/teacher/signup.php";
  static const login = "$hostConnect/teacher/login.php";
  static const delete = "$hostConnect/teacher/delete.php";

  //signUp parents
  static const validateChildID = "$hostConnect/parents/validate_childrenID.php";
  static const signUpParents = "$hostConnect/parents/parents_signup.php";
  static const loginParents = "$hostConnect/parents/parents_login.php";
  static const deleteParents = "$hostConnect/parents/parents_delete.php";

  //add meal to cart
  static const createMeal = "$hostConnect/meal/create_meal.php";
}
