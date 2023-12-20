
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vege/src/landing/presentaion/main_screen_controller.dart';
import 'package:vege/src/manage%20purchases/presentation/controller/home_controller.dart';


Future<void> init() async {
  final sharedPreferences=await SharedPreferences.getInstance();

//we give it to the get
  Get.lazyPut(() => sharedPreferences);


  //api client

//repos

//controllers
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => MainPageController());

  return;
}
