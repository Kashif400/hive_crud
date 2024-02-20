import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    //create database of mybox
    var box = await Hive.openBox('mybox');

    var b = Hive.box('mybox');
    // print(b.path);
    b.put('id', 1);
    b.put('name', 'Kashif');
    b.put('language', ['C', 'C++', 'Java']);
    b.putAll({'id': 2, 'name': 'Arshid', 'skill': 'Flutter'});

    // print(b.keys);
    // print(b.values);
    // print(b.length);

    //read data in hive database
    // print(b.get('name'));
    // print(b.get('language'));

    // print(b.get('x'));

    // print(b.get('x', defaultValue: 'this is default value'));

    //update data
    // b.put('name', 'saeed khan');
    // print(b.get('name'));
    // b.put('language', ['dart', 'js']);
    // print(b.get('language'));

    //delete a data

    // b.delete('name');

    // print(b.get('name'));

    // b.deleteAll(b.keys);
    // print(b.keys);
//delete a mybox
    // b.deleteFromDisk();
    // print(b.name);

    await getAllData();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //offline data fetch data
  late Box box;
  List data = [].obs;
  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('myData');

    return;
  }

  //get data
  Future<bool> getAllData() async {
    await openBox();
    String url = 'https://jsonplaceholder.typicode.com/users';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var _jsonDecode = jsonDecode(response.body);
        await putData(_jsonDecode);
      }
    } catch (SocketException) {
      print('no internete');
    }

    //get data for db
    var mymap = box.toMap().values.toList();

    if (mymap.isEmpty) {
      data.add('empty');
    } else {
      data = mymap;
    }
    print(box.values);
    return Future.value(true);
  }

//update data
  Future<void> updateData() async {
    await openBox();
    String url = 'https://jsonplaceholder.typicode.com/users';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var _jsonDecode = jsonDecode(response.body);
        await putData(_jsonDecode);
      }
    } catch (SocketException) {
      print('no internete');
    }
  }

  //put data
  Future putData(data) async {
    await box.clear();
    //insert data
    for (var d in data) {
      box.add(d);
    }
  }
}
