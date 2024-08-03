import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/main.dart';
import 'package:global_health_opinion_sample/util/constant.dart';
import 'package:global_health_opinion_sample/util/dio_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../util/shared_prefences.dart';

class AppController extends GetxController {
  var isNavigating = false.obs;

  Rx<bool> isRecording = false.obs;
  int activeNavBarItem = 0;
  Rx<bool> saveClicked = true.obs;
  Rx<String> recordingPath = ''.obs;
  Rx<bool> isPlaying = false.obs;
  Rx<String?> selectedcountry = Rx<String?>(null);
  RxList<String> filesResult = <String>[].obs;
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
      await Permission.activityRecognition.request();
      await Permission.location.request();
      var userToken = await SharedPrefs.getString(SharedPrefs.TOKEN);
      if (userToken != null) {
        Get.offAllNamed(PageRouteName.myreviews);
      } else {
        Get.offAllNamed(PageRouteName.splashDiologue);
      }
    }
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  Rx<String> status = '?'.obs, steps = '?'.obs;

  void onStepCount(StepCount event) {
    print(event);

    steps.value = event.steps.toString();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);

    status.value = event.status;
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');

    status.value = 'Pedestrian Status not available';

    print(status.value);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');

    steps.value = 'Step Count not available';
  }

  void initPlatformState(var mounted) {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  Future<void> selectStartDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2015, 8),
      lastDate: currentDate,
    );
    if (picked != null && picked != currentDate) {
      selectedDate = picked;
      controller.text = AppUtil.formatter.format(selectedDate);
    }
  }

  apiCheck() async {
    var body = {
      "Token": "",
      "Prokey": "",
      "Tags": [
        {"T": "Token", "V": "jjoseph@swiftkode.com"},
        {"T": "Pass", "V": "admin"},
        {"T": "Action", "V": "XCLSIGN"},
        {"T": "Product", "V": "ey1XeErax/re3S1qnGimugx57pI9ZBapZO59VNla+FU="}
      ]
    };
    var response = await DioHandler.dioPOST(body: jsonEncode(body));
    log(response.toString());
  }

  getdata() async {
    String path = 'snjdnd';
    var response = await DioHandler.dioGET(path: path);
    log(response.toString());
  }
}
