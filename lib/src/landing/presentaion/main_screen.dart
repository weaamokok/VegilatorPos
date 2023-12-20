import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vege/src/landing/presentaion/main_screen_controller.dart';
import 'package:vege/src/landing/presentaion/widget/bottom_screen.dart';
import 'package:vege/src/utils/constants.dart';
import 'package:video_viewer/video_viewer.dart';


class MainPage extends StatefulWidget {

  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    final VideoViewerController controller = VideoViewerController();

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    final MainPageController landingPageController =
        Get.put(MainPageController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body:
   Container()
      //  Obx(() => IndexedStack(
      //       index: landingPageController.tabIndex.value,
      //       children: AppConst.navPages,
      //     )),
    ));
  }
}