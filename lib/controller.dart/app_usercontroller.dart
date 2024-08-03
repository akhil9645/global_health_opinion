import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:global_health_opinion_sample/controller.dart/app_controller.dart';
import 'package:global_health_opinion_sample/main.dart';
import 'package:global_health_opinion_sample/util/dio_handler.dart';

import '../util/shared_prefences.dart';

class AppUserController extends GetxController {
  Rx<bool> loginpassobscureText = true.obs;
  Rx<bool> registerpassobscureText = true.obs;
  Rx<bool> registerconfirmpassobscureText = true.obs;
  Rx<bool> currentpassobscureText = true.obs;
  Rx<bool> newpasspassobscureText = true.obs;
  Rx<bool> newconfirmpassobscureText = true.obs;
  int? responsestatus;
  int? otp;
  String email = '';
  String data = '';
  String tokenMsg = '';
  Rx<bool> isLoading = false.obs;

  logoutCheck() async {
    SharedPrefs.clearStorage();
    var userToken = await SharedPrefs.getString(SharedPrefs.TOKEN);
    if (userToken != null) {
      Get.offAllNamed(PageRouteName.myreviews);
    } else {
      Get.offAllNamed(PageRouteName.login);
      update();
    }
  }

  userRegistration(
    String firstname,
    String lastname,
    String email,
    String password,
    String phone,
  ) async {
    isLoading.value = true;
    var body = {
      "Token": "",
      "Tags": [
        {"T": "Action", "V": "SIGNUP"},
        {"T": "src", "V": "MOBILE"},
        {"T": "dk1", "V": firstname},
        {"T": "dk2", "V": lastname},
        {"T": "c1", "V": email},
        {"T": "c2", "V": password},
        {"T": "c3", "V": phone},
        {"T": "c4", "V": "91"}
      ]
    };

    // Encode body as JSON string
    String jsonBody = jsonEncode(body);

    // Print the encoded JSON body
    log('Encoded Request Body: $jsonBody');

    var response = await DioHandler.dioPOST(body: jsonBody);
    responsestatus = response['Status'];
    if (responsestatus == 1) {
      otp = response['Data'][0][0]['Otp'];
      print('the otp $otp');
      print('values $responsestatus');
      log(response.toString());
      data = response['Info'];
      isLoading.value = false;
    } else {
      isLoading.value = false;
      data = response['Info'];
      print(data);
      log(response.toString());
    }

    return responsestatus;
  }

  userOTPConfirmation(
    String email,
    String otp,
  ) async {
    isLoading.value = true;
    var body = {
      "Token": "",
      "Tags": [
        {"T": "Action", "V": "OTP"},
        {"T": "src", "V": "MOBILE"},
        {"T": "dk1", "V": email},
        {"T": "dk2", "V": otp},
      ]
    };

    // Encode body as JSON string
    String jsonBody = jsonEncode(body);

    // Print the encoded JSON body
    log('Encoded Request Body: $jsonBody');

    var response = await DioHandler.dioPOST(body: jsonBody);
    responsestatus = response['Status'];
    var responsedata = response['Data'];
    if (responsestatus == 1 && responsedata == null) {
      data = response['Info'];
    } else if (responsestatus == 1) {
      if (response['Data'] != null && response['Data'].isNotEmpty) {
        var lastElement = response['Data'].last;
        if (lastElement.isNotEmpty &&
            lastElement[0] != null &&
            lastElement[0].containsKey('msg')) {
          tokenMsg = lastElement[0]['msg'];
          SharedPrefs.setString(tokenMsg, SharedPrefs.TOKEN);
          isLoading.value = false;
        } else {
          isLoading.value = false;
          log('The last element does not contain a "msg" key or is empty.');
        }
      } else {
        log('The response data is null or empty.');
      }
    }

    log(response.toString());
    return responsestatus;
  }

  userSignIN(
    String email,
    String password,
  ) async {
    isLoading.value = true;
    var body = {
      "Token": "",
      "Tags": [
        {"T": "Action", "V": "SIGNIN"},
        {"T": "src", "V": "MOBILE"},
        {"T": "dk1", "V": email},
        {"T": "dk2", "V": password},
      ]
    };

    // Encode body as JSON string
    String jsonBody = jsonEncode(body);

    // Print the encoded JSON body
    log('Encoded Request Body: $jsonBody');

    var response = await DioHandler.dioPOST(body: jsonBody);
    responsestatus = response['Status'];
    if (responsestatus == 1) {
      log(response.toString());
      isLoading.value = false;
      otp = response['Data'][0][0]['Otp'];
      data = response['Info'];
    } else if (responsestatus == 0) {
      data = response['Info'];
      isLoading.value = false;
    }
    isLoading.value = false;
    return responsestatus;
  }
}
