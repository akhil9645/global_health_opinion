import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/controller.dart/app_controller.dart';
import 'package:global_health_opinion_sample/main.dart';
import 'package:global_health_opinion_sample/util/constant.dart';
import 'package:iconly/iconly.dart';

class NewReviews extends StatelessWidget {
  NewReviews({super.key});
  final AppController controller = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: AppUtil.customBottomBar(controller, context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
              child: Text(
                'Fill the Below Details!',
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            NewReviewsTile(
              context,
              IconlyBold.user_2,
              'Patient Information',
              'Details about the patient',
              controller,
              'Needed',
              () => Get.toNamed(PageRouteName.patientinformation),
            ),
            const SizedBox(
              height: 20,
            ),
            NewReviewsTile(
              context,
              Icons.medical_information,
              'Medical Details',
              'Fill Required Medical Details',
              controller,
              'Needed',
              () => Get.toNamed(PageRouteName.medicaldetails),
            ),
            const SizedBox(
              height: 20,
            ),
            NewReviewsTile(
              context,
              IconlyBold.upload,
              'Upload Reports',
              'Upload Neccessary Reports',
              controller,
              'Needed',
              () => Get.toNamed(PageRouteName.uploadrecords),
            ),
            const SizedBox(
              height: 20,
            ),
            NewReviewsTile(
              context,
              IconlyBold.paper_upload,
              'Medical Records (Optional)',
              'Add Previous Medical Reports here',
              controller,
              'not',
              () => Get.toNamed(PageRouteName.medicalrecords),
            ),
            const SizedBox(
              height: 20,
            ),
            NewReviewsTile(
              context,
              IconlyBold.paper,
              'Current Medications',
              'Review Current medications here',
              controller,
              'not',
              () => Get.toNamed(PageRouteName.currentmedications),
            ),
            const SizedBox(
              height: 20,
            ),
            NewReviewsTile(
              context,
              Icons.payment_rounded,
              'Payments',
              'Complete Payment Process',
              controller,
              'not',
              () => Get.toNamed(PageRouteName.payments),
            )
          ],
        ),
      ),
    );
  }

  Padding NewReviewsTile(
      BuildContext context,
      IconData icon,
      String title,
      String description,
      AppController controller,
      String infoicon,
      void Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 12,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    blurStyle: BlurStyle.outer)
              ],
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              Icon(
                icon,
                size: 35,
                color: AppUtil().backgroundColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 55,
              ),
              infoicon == 'Needed'
                  ? Expanded(
                      child: Icon(
                        IconlyBold.info_circle,
                        color: Colors.red.shade800,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
