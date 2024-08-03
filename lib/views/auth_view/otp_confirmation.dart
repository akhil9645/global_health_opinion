import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/controller.dart/app_usercontroller.dart';
import 'package:global_health_opinion_sample/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../util/constant.dart';

class OtpConfirmation extends StatelessWidget {
  OtpConfirmation({super.key});
  final TextEditingController otpcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppUserController controller = Get.put(AppUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppUtil().backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25, top: 3),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 25, left: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'OTP Verification',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'OTP has shared to your Registered email ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'The OTP is ${controller.otp.toString()}',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: otpcontroller,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is Required';
                      } else if (value.length != 6) {
                        return 'Please enter valid Input';
                      }
                      return null;
                    },
                    cursorColor: AppUtil().backgroundColor,
                    decoration: const InputDecoration(
                      hintText: 'Enter OTP',
                      enabledBorder: InputBorder.none,
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(85)),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(85)),
                      ),
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      var responsestatus = await controller.userOTPConfirmation(
                          controller.email, otpcontroller.text);
                      if (responsestatus == 1 && controller.data.isNotEmpty) {
                        Get.offAllNamed(PageRouteName.myreviews);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBarinfo(controller.data));
                      }
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 20,
                    decoration: BoxDecoration(
                      color: AppUtil().backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Obx(
                      () => controller.isLoading.value == false
                          ? Text(
                              'Verify OTP',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          : LoadingAnimationWidget.fourRotatingDots(
                              color: Colors.white,
                              size: 40,
                            ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SnackBar snackBarinfo(String content) {
    return SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppUtil().backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            content,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
