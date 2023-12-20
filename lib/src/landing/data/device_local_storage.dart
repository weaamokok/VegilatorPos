import 'package:shared_preferences/shared_preferences.dart';
import 'package:vege/src/utils/constants.dart';

class Storage {
  Future<bool?> isFirstLunch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(AppConst.isFirstLunch)) {
      sharedPreferences.setBool(AppConst.isFirstLunch, false);
      return false;
    } else {
      return sharedPreferences.getBool(AppConst.isFirstLunch);
    }
  }
}
