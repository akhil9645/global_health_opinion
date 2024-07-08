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
    List<String> names = ['Ajay', 'Rahul', 'Vishnu', 'Irshad', 'Sebin'];
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
              'My Review List',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
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
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Material(
                      elevation: 5,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: 150,
                                  height: 100,
                                  child:
                                      Image.asset('assets/images/387552.png')),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    names[index],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                              Spacer(),
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    color: AppUtil().backgroundColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                  child: Text(
                                    'View Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}
