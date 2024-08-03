import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/controller.dart/app_controller.dart';
import 'package:global_health_opinion_sample/controller.dart/app_usercontroller.dart';
import 'package:global_health_opinion_sample/main.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class AppUtil {
  Color backgroundColor = Color(0xFF014AAD);
  static DateFormat formatter = DateFormat('dd MMM yyyy');

  static Widget customBottomBar(
      AppController appController, BuildContext context) {
    return GetBuilder<AppController>(
      builder: (controller) {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppUtil().backgroundColor,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(IconlyLight.home), label: 'My Reviews'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: 'New Reviews'),
            BottomNavigationBarItem(
                icon: Icon(IconlyLight.user), label: 'Profile'),
          ],
          elevation: 6,
          currentIndex: controller.activeNavBarItem,
          onTap: (value) {
            controller.navBarController(value);
          },
        );
      },
    );
  }

  Container drawer(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 125,
                  height: 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/gho_logo-CAevCtDl.png',
                        fit: BoxFit.fill,
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                drawerItems(() => Get.toNamed(PageRouteName.changePassword),
                    IconlyLight.password, 'Change Password'),
                drawerItems(() {
                  logoutalert(context);
                }, Icons.logout_rounded, 'Logout'),
              ],
            ),
          ),
        ));
  }

  GestureDetector drawerItems(
      void Function()? onTap, IconData icon, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Icon(
              icon,
              size: 26,
              color: Colors.grey.shade600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> logoutalert(BuildContext context) {
    Get.lazyPut(
      () => AppUserController(),
    );
    final AppUserController controller = Get.find();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 125,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      'Logout',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    child: Text('Are you sure you want to logout?',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      logoutAlertButtons(() {
                        print('entered logout button');
                        controller.logoutCheck();
                      }, 'Yes', Colors.grey.shade300, Colors.black),
                      const SizedBox(
                        width: 5,
                      ),
                      logoutAlertButtons(() => Navigator.pop(context), 'No',
                          AppUtil().backgroundColor, Colors.white),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  GestureDetector logoutAlertButtons(
      void Function()? onTap, String title, Color boxColor, Color textcolor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 35,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 14, color: textcolor),
          ),
        ),
      ),
    );
  }
}
