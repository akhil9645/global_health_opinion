import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/controller.dart/app_controller.dart';
import 'package:global_health_opinion_sample/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../util/camer_view.dart';
import '../../../util/constant.dart';

class UploadRecords extends StatelessWidget {
  UploadRecords({super.key});

  final AppController controller = Get.put(AppController());
  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Upload Reports',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                'Upload Medical Reports',
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => controller.imageList.isNotEmpty ||
                      controller.filesResult.isNotEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 8,
                      child: ListView.builder(
                        itemCount: controller.filesResult.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.image),
                            title: Text(
                              controller.filesResult[index],
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.close),
                          );
                        },
                      ),
                    )
                  : SizedBox()),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  // addImageFunction(controller, 'GALLERY');
                  var status = await Permission.storage.request();
                  if (status.isGranted) {
                    result = await FilePicker.platform
                        .pickFiles(allowMultiple: true);
                    if (result == null) {
                      print("No file selected");
                    } else {
                      controller.filesResult.clear();
                      for (var element in result!.files) {
                        controller.filesResult.add(element.name);
                        print(element.name);
                      }
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 20,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Select File From Device',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  addImageFunction(controller, 'CAMERA');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 20,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Take Photo',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(PageRouteName.newreviews);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 20,
                  decoration: BoxDecoration(
                    color: AppUtil().backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Save',
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
      ),
    );
  }

  addImageFunction(AppController controller, String source) async {
    if (source == 'GALLERY') {
      ImagePicker _picker = ImagePicker();
      XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        await controller.capturePhoto(file);
        controller.submitImgToBatchList();
      }
    } else if (source == 'CAMERA') {
      Get.to(() => const CameraView());
    }
  }
}
