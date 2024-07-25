import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;

import '../../../controller.dart/app_controller.dart';
import '../../../util/constant.dart';

class MedicalDetails extends StatelessWidget {
  MedicalDetails({super.key});
  final AppController controller = Get.put(AppController());
  TextEditingController namecontroller = TextEditingController();
  TextEditingController summarycontroller = TextEditingController();
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Medical Information',
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
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter Details Below!',
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: namecontroller,
                  cursorColor: AppUtil().backgroundColor,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      value: controller.selectedspecilization.value,
                      hint: const Text('Speciality'),
                      onChanged: (String? value) {
                        controller.selectedspecilization.value = value;
                      },
                      buttonStyleData: const ButtonStyleData(height: 50),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        maxHeight: 275,
                      ),
                      menuItemStyleData: MenuItemStyleData(height: 40),
                      items: controller.speacilizationitems
                          .map(
                            (String item) => DropdownMenuItem<String>(
                                value: item, child: Text(item)),
                          )
                          .toList(),
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
                child: TextFormField(
                  maxLines: 6,
                  controller: summarycontroller,
                  cursorColor: AppUtil().backgroundColor,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => controller.recordingPath.value != ''
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              debugPrint(controller.recordingPath.value);
                              if (audioPlayer.playing) {
                                audioPlayer.stop();
                                controller.isPlaying.value = false;
                              } else {
                                await audioPlayer.setFilePath(
                                    controller.recordingPath.value);
                                audioPlayer.play();
                                controller.isPlaying.value = true;
                              }
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width / 1.3,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      controller.isPlaying.value
                                          ? Icons.stop
                                          : Icons.play_arrow_rounded,
                                      color: AppUtil().backgroundColor,
                                      size: 25,
                                    ),
                                    Text(
                                      controller.isPlaying.value
                                          ? 'Stop Record'
                                          : 'Play Record',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.recordingPath.value = '';
                            },
                            child: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => GestureDetector(
                  onTap: () async {
                    if (controller.isRecording.value) {
                      String? filePath = await audioRecorder.stop();
                      print(filePath);
                      if (filePath != null) {
                        controller.recordingPath.value = filePath;
                        print(controller.recordingPath.value);
                        controller.isRecording.value = false;
                      }
                    } else {
                      if (await audioRecorder.hasPermission()) {
                        final Directory appDocumentsDir =
                            await getApplicationDocumentsDirectory();
                        final String filePath =
                            p.join(appDocumentsDir.path, "recording.wav");
                        print(filePath);
                        await audioRecorder.start(const RecordConfig(),
                            path: filePath);
                        controller.isRecording.value = true;
                        controller.recordingPath.value = '';
                      }
                    }
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            controller.isRecording.value
                                ? Icons.stop
                                : Icons.mic,
                            color: AppUtil().backgroundColor,
                            size: 25,
                          ),
                          Text(
                            controller.isRecording.value
                                ? 'Stop Recording'
                                : 'Record Medical Summary',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              GestureDetector(
                onTap: () {
                  controller.apiCheck();
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
}
