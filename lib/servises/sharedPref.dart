import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static String userIdkey = 'USERIDKEY';
  static String userNamekey = 'USERNAMEKEY';
  static String userEmailkey = 'USEREMAILKEY';
  static String userWalletkey = 'USERWALLETKEY';
  static String userProfileKey = 'USERPROFILEKEY';
  static String userPasswordKey = 'userPassword';
  static String authRegister = 'false';
  static String usertheme = 'light';

  Future<bool> saveUserId(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userIdkey, id);
  }

  Future<bool> saveTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(usertheme, theme);
  }

  Future<bool> saveAuthRegister(String register) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(authRegister, register);
  }

  Future<bool> saveUserName(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userNamekey, name);
  }

  Future<bool> saveUserEmail(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userEmailkey, email);
  }

  Future<bool> saveUserWallet(String walllet) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userWalletkey, walllet);
  }

  Future<bool> saveUserProfileImage(String profile) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userProfileKey, profile);
  }

  Future<bool> saveUserPassword(String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userPasswordKey, password);
  }

  Future<String?> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(userIdkey);
  }

  Future<String?> getUserTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(usertheme);
  }

  Future<String?> getAuthRegister() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(authRegister);
  }

  Future<String?> getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(userNamekey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(userEmailkey);
  }

  Future<String?> getUserWallet() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(userWalletkey);
  }

  Future<String?> getUserProfileImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(userProfileKey);
  }

  Future<String?> getUserPassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.getString(userPasswordKey);
  }
}
