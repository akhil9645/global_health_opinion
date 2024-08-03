import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/controller.dart/app_usercontroller.dart';
import 'package:global_health_opinion_sample/main.dart';
import 'package:global_health_opinion_sample/util/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final AppUserController controller = Get.put(AppUserController());
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: AppUtil().backgroundColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 8,
                    left: MediaQuery.of(context).size.width / 12,
                  ),
                  child: const Text(
                    'Welcome \nBack...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 75),
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Login to continue using the app',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 35),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: emailcontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is Required';
                            }
                            return null;
                          },
                          cursorColor: AppUtil().backgroundColor,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            hintText: 'Email',
                            enabledBorder: InputBorder.none,
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(85)),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(85)),
                            ),
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Obx(
                          () => TextFormField(
                            controller: passwordController,
                            obscureText: controller.loginpassobscureText.value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is Required';
                              }
                              return null;
                            },
                            cursorColor: AppUtil().backgroundColor,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.loginpassobscureText.value =
                                      !controller.loginpassobscureText.value;
                                },
                                icon: Icon(controller.loginpassobscureText.value
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              hintText: 'Password',
                              enabledBorder: InputBorder.none,
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(85)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(85)),
                              ),
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(12),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () =>
                              Get.toNamed(PageRouteName.forgetPassword),
                          child: RichText(
                            text: TextSpan(
                              text: 'Forget Password?',
                              style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                color: AppUtil().backgroundColor,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            var responsedatastatus =
                                await controller.userSignIN(
                                    emailcontroller.text,
                                    passwordController.text);
                            if (responsedatastatus == 1) {
                              controller.email = emailcontroller.text;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBarinfo(controller.data));
                              Get.toNamed(PageRouteName.otpConfirmation);
                            } else if (responsedatastatus == 0) {
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
                                      'Login',
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
                            "Don't have an account ? ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(PageRouteName.register),
                            child: Text(
                              "Register",
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
            ],
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
