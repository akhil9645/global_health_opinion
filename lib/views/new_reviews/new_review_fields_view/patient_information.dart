import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller.dart/app_controller.dart';
import '../../../util/constant.dart';

class PatientInformation extends StatelessWidget {
  PatientInformation({super.key});
  final AppController controller = Get.put(AppController());
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController heightcontroller = TextEditingController();
  TextEditingController bloodcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Patient Information',
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
            child: Obx(() => controller.saveClicked.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Add Patient Details!',
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
                          decoration: InputDecoration(
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          controller: agecontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: AppUtil().backgroundColor,
                          decoration: const InputDecoration(
                            hintText: 'Age',
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
                            value: controller.selectedgender.value,
                            hint: const Text('Select Gender'),
                            onChanged: (String? value) {
                              controller.selectedgender.value = value;
                            },
                            buttonStyleData: const ButtonStyleData(height: 50),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              maxHeight: 275,
                            ),
                            menuItemStyleData: MenuItemStyleData(height: 40),
                            items: controller.genderitems
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
                          controller: weightcontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: AppUtil().backgroundColor,
                          decoration: const InputDecoration(
                            hintText: 'Weight (KG)',
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
                          controller: heightcontroller,
                          keyboardType: TextInputType.number,
                          cursorColor: AppUtil().backgroundColor,
                          decoration: const InputDecoration(
                            hintText: 'Height (CM)',
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
                          controller: bloodcontroller,
                          cursorColor: AppUtil().backgroundColor,
                          decoration: const InputDecoration(
                            hintText: 'Blood Pressure',
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
                          // Get.toNamed(PageRouteName.newreviews);
                          controller.saveClicked.value =
                              !controller.saveClicked.value;
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
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer)
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                child: Image.asset('assets/images/387552.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Akhil Jose',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'Age : 22',
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 15),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.saveClicked.value =
                              !controller.saveClicked.value;
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
                              'Add Patient',
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
                  )),
          ),
        ));
  }
}
