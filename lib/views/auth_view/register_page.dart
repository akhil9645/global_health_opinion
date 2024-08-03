import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/controller.dart/app_usercontroller.dart';
import 'package:global_health_opinion_sample/main.dart';
import 'package:global_health_opinion_sample/util/constant.dart';

import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  final AppUserController controller = Get.put(AppUserController());
  final _formKey = GlobalKey<FormState>();

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
                const SizedBox(height: 20),
                const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Register to be a part of us',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 40),
                registerFormField(
                    txtController: firstnamecontroller,
                    hinttext: 'First Name',
                    prefixIcon: Icon(IconlyBold.user_3)),
                const SizedBox(
                  height: 20,
                ),
                registerFormField(
                    txtController: lastnamecontroller,
                    hinttext: 'Last Name',
                    prefixIcon: Icon(IconlyBold.user_3)),
                const SizedBox(
                  height: 20,
                ),
                registerFormField(
                    txtController: emailcontroller,
                    hinttext: 'Email',
                    prefixIcon: Icon(Icons.email_rounded)),
                const SizedBox(
                  height: 20,
                ),
                registerFormField(
                    prefixIcon: Icon(IconlyBold.call),
                    txtController: phonecontroller,
                    hinttext: 'Phone Number'),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Obx(
                    () => TextFormField(
                      controller: passwordcontroller,
                      obscureText: controller.registerpassobscureText.value,
                      cursorColor: AppUtil().backgroundColor,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is Required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.registerpassobscureText.value =
                                !controller.registerpassobscureText.value;
                          },
                          icon: Icon(controller.registerpassobscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintText: 'Password',
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
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Obx(
                    () => TextFormField(
                      controller: confirmcontroller,
                      obscureText:
                          controller.registerconfirmpassobscureText.value,
                      cursorColor: AppUtil().backgroundColor,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is Required';
                        } else if (value != passwordcontroller.text) {
                          return "Password doesn't Match.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.registerconfirmpassobscureText.value =
                                !controller
                                    .registerconfirmpassobscureText.value;
                          },
                          icon: Icon(
                              controller.registerconfirmpassobscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                        ),
                        hintText: 'Confirm Password',
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
                ),

                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      var responsedata = await controller.userRegistration(
                        firstnamecontroller.text,
                        lastnamecontroller.text,
                        emailcontroller.text,
                        passwordcontroller.text,
                        phonecontroller.text,
                      );

                      print('the data $responsedata');
                      if (responsedata == 1) {
                        controller.email = emailcontroller.text;
                        ScaffoldMessenger.of(context).showSnackBar(
                          snackBarinfo(controller.data),
                        );
                        Get.toNamed(PageRouteName.otpConfirmation);
                      } else {
                        print(controller.data);
                        ScaffoldMessenger.of(context).showSnackBar(
                          snackBarinfo(controller.data),
                        );
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
                                'Register',
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
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ? ",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(PageRouteName.login),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppUtil().backgroundColor),
                      ),
                    ),
                  ],
                )
                // Extra space at the bottom
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

  Container registerFormField(
      {TextEditingController? txtController,
      String? hinttext,
      Widget? prefixIcon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: txtController,
        keyboardType: hinttext == 'Phone Number'
            ? TextInputType.number
            : TextInputType.text,
        cursorColor: AppUtil().backgroundColor,
        validator: (value) {
          if (value!.isEmpty) {
            return 'This field is Required';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hinttext,
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
    );
  }
}
