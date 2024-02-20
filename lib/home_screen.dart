import 'package:crud_hive/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      body: FutureBuilder(
          future: controller.getAllData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (controller.data.contains('empty')) {
                return Text('No Data');
              } else {
                return Column(
                  children: [
                    Expanded(
                        child: RefreshIndicator(
                      onRefresh: controller.updateData,
                      child: ListView.builder(
                          itemCount: controller.data.length,
                          itemBuilder: (context, index) {
                            return Text('${controller.data[index]['name']}');
                          }),
                    ))
                  ],
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
