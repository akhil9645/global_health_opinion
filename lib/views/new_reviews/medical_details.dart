import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/main.dart';

import '../../controller.dart/app_controller.dart';
import '../../util/constant.dart';

class MedicalDetails extends StatelessWidget {
  MedicalDetails({super.key});
  final AppController controller = Get.put(AppController());
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController summarycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Doctor Information',
            style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 25, top: 5),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 30,
                color: Colors.grey.shade700,
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
                  height: 100,
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
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Obx(
                    () => DropdownButton2(
                      isExpanded: true,
                      value: controller.selectedspecilization.value,
                      hint: const Text('Specialization'),
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: numbercontroller,
                    keyboardType: TextInputType.number,
                    cursorColor: AppUtil().backgroundColor,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    maxLines: 6,
                    controller: summarycontroller,
                    cursorColor: AppUtil().backgroundColor,
                    decoration: const InputDecoration(
                      hintText: 'Medical / Diagnosis Summary',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
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
      ),
    );
  }
}
