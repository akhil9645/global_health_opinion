import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/controller.dart/app_usercontroller.dart';
import 'package:global_health_opinion_sample/main.dart';
import '../../util/constant.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  final AppUserController controller = Get.put(AppUserController());
  TextEditingController currentPasscontroller = TextEditingController();
  TextEditingController newPasscontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
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
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Obx(
                () => TextFormField(
                  controller: currentPasscontroller,
                  obscureText: controller.currentpassobscureText.value,
                  cursorColor: AppUtil().backgroundColor,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.currentpassobscureText.value =
                            !controller.currentpassobscureText.value;
                      },
                      icon: Icon(controller.currentpassobscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    hintText: 'Current Password',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.all(12),
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
                  controller: newPasscontroller,
                  obscureText: controller.newpasspassobscureText.value,
                  cursorColor: AppUtil().backgroundColor,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.newpasspassobscureText.value =
                            !controller.newpasspassobscureText.value;
                      },
                      icon: Icon(controller.newpasspassobscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    hintText: 'New Password',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.all(12),
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
                  controller: confirmpasswordcontroller,
                  obscureText: controller.newconfirmpassobscureText.value,
                  cursorColor: AppUtil().backgroundColor,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.newconfirmpassobscureText.value =
                            !controller.newconfirmpassobscureText.value;
                      },
                      icon: Icon(controller.newconfirmpassobscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    hintText: 'Confirm password',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => Get.toNamed(PageRouteName.myreviews),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 20,
                decoration: BoxDecoration(
                  color: AppUtil().backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}