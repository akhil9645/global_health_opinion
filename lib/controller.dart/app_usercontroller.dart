import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:global_health_opinion_sample/util/dio_handler.dart';

class AppUserController extends GetxController {
  Rx<bool> loginpassobscureText = true.obs;
  Rx<bool> registerpassobscureText = true.obs;
  Rx<bool> registerconfirmpassobscureText = true.obs;
  Rx<bool> currentpassobscureText = true.obs;
  Rx<bool> newpasspassobscureText = true.obs;
  Rx<bool> newconfirmpassobscureText = true.obs;

  userRegistration(
    String firstname,
    String lastname,
    String email,
    String password,
    String phone,
  ) async {
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
    log(response.toString());
  }
}
