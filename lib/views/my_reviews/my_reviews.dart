import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_health_opinion_sample/controller.dart/app_controller.dart';
import 'package:global_health_opinion_sample/util/constant.dart';

class MyReviews extends StatelessWidget {
  MyReviews({super.key});

  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  final AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      backgroundColor: Colors.white,
      bottomNavigationBar: AppUtil.customBottomBar(controller, context),
      appBar: AppBar(
        backgroundColor: AppUtil().backgroundColor,
        elevation: 0,
        title: Text(
          'Global Health Opinion',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () => _scafoldKey.currentState!.openDrawer(),
            child: const SizedBox(
                width: 35,
                height: 35,
                child: Icon(
                  CupertinoIcons.line_horizontal_3_decrease,
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ),
      ),
      drawer: AppUtil().drawer(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'My Reviews',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 6,
                      blurStyle: BlurStyle.outer,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.75,
                        crossAxisCount: 2),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      var name = [
                        'Reyna Kovacek',
                        'Ravindra A',
                        'Gabriel B',
                        'Angelo Sam',
                        'Yemini Dzuza'
                      ];
                      var summary = [
                        'Lorem Ipsum is \nsimply dummy text of \nthe printing and \ntypesetting industry.',
                        'Lorem Ipsum is \nsimply dummy text of \nthe printing and typesetting \nindustry.',
                        'Lorem Ipsum is \nsimply dummy text of \nthe printing and \ntypesetting industry.',
                        'Lorem Ipsum is \nsimply dummy text of \nthe printing and \ntypesetting industry.',
                        'Lorem Ipsum is \nsimply dummy text of \nthe printing and \ntypesetting industry.',
                      ];
                      var speaciality = [
                        'Cardiology',
                        'Dermatology',
                        'Neurology',
                        'Pediatrics',
                        'Radiology'
                      ];
                      var age = ['34', '44', '22', '18', '14'];
                      var gender = ['Female', 'Male', 'Male', 'Male', 'Female'];
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400]!,
                                  blurRadius: 3.0,
                                  offset: Offset(1, 2))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Review #${index + 1}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                name[index],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                summary[index],
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(color: Colors.orange.shade100)
                                ], borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    speaciality[index],
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    age[index],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    gender[index],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Center(
                                child: Text(
                                  'Tap for details',
                                  style: TextStyle(
                                      color: AppUtil().backgroundColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
          )
        ],
      ),
    );
  }
}
