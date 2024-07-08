import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/main.dart';
import 'package:image_picker/image_picker.dart';

class AppController extends GetxController {
  var isNavigating = false.obs;
  Rx<bool> loginpassobscureText = true.obs;
  Rx<bool> registerpassobscureText = true.obs;
  Rx<bool> registerconfirmpassobscureText = true.obs;
  Rx<bool> currentpassobscureText = true.obs;
  Rx<bool> newpasspassobscureText = true.obs;
  Rx<bool> newconfirmpassobscureText = true.obs;
  int activeNavBarItem = 0;
  Rx<String?> selectedcountry = Rx<String?>(null);
  final List<String> items = [
    'United States',
    'Canada',
    'Mexico',
    'India',
    'United Kingdom',
  ];

  Rx<String?> selectedgender = Rx<String?>(null);
  final List<String> genderitems = [
    'Male',
    'Female',
  ];

  Rx<String?> selectedspecilization = Rx<String?>(null);
  final List<String> speacilizationitems = [
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'Radiology',
    'Surgery',
  ];
  int checkBoxValue = 0;
  bool checkBox1 = false;
  bool checkBox2 = false;
  checkboxUpdate(int checkBoxNo, bool value) {
    if (value == true) {
      checkBoxValue++;
      if (checkBoxNo == 1) {
        checkBox1 = value;
      } else {
        checkBox2 = value;
      }
    } else {
      checkBoxValue--;
      if (checkBoxNo == 1) {
        checkBox1 = value;
      } else {
        checkBox2 = value;
      }
    }

    update();
  }

  List imgInBytesList = [];
  RxList<File> imageList = <File>[].obs;
  submitImgToBatchList() async {
    List<int> imgInBytes = await imgFile!.readAsBytes();
    String img64 = base64Encode(imgInBytes);
    // lg.log("Copy:\n$img64");
    imgInBytesList.add(img64); //Stored to send imges to server.

    imageList.add(photo!); //Stored to display in batch screen
    photo = null;
    checkboxUpdate(1, false);
    checkboxUpdate(2, false);
    update();
    // Get.back();
  }

  XFile? imgFile;
  File? photo;
  capturePhoto(XFile file) async {
    imgFile = file;

    photo = File(file.path);
    update();
  }

  void navBarController(int value) {
    if (value != activeNavBarItem) {
      activeNavBarItem = value;
      navBarNavigator(value);
      update();
    }
  }

  void navBarNavigator(int value) {
    log("Navigation Value: $value");

    switch (value) {
      case 0:
        Get.offAllNamed(PageRouteName.myreviews);
        break;
      case 1:
        Get.offAllNamed(PageRouteName.newreviews);
        break;
      case 2:
        Get.offAllNamed(PageRouteName.profile);
        break;
      default:
        break;
    }
  }

  splashcheck() async {
    if (!isNavigating.value) {
      isNavigating.value = true;
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(PageRouteName.splashDiologue);
    }
  }
}
