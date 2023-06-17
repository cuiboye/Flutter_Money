import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/utils/sp.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceWidget extends StatefulWidget {
  @override
  _SharedPreferenceWidgetState createState() => _SharedPreferenceWidgetState();
}

class _SharedPreferenceWidgetState extends State<SharedPreferenceWidget> {
  String? result = "";
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  // save().then((value) => {
                  //       if (value) {print("保存成功")}
                  //     });
                  Sp().setString("mmmmmm", "hello");
                },
                child: const Text("存储数据")),
            ElevatedButton(onPressed: () {
              // getData();
              result = Sp().get<String>("mmmmmm");
              setState(() {

              });
              print("获取的数据为 $result");
            }, child:  Text("$result")),
            ElevatedButton(onPressed: () => deleteData(), child: Text("删除数据"))
          ],
        ),
        appBar: CustomAppbar(
          title: 'sharedpreference存储数据',
          context: context,
        ),
      ),
    );
  }

  /**
   * 保存数据
   */
  Future<bool> save() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();

    // Save an integer value to 'counter' key.
    return await prefs.setInt('counter', 10);
    // // Save an boolean value to 'repeat' key.
    // await prefs.setBool('repeat', true);
    // // Save an double value to 'decimal' key.
    // await prefs.setDouble('decimal', 1.5);
    // // Save an String value to 'action' key.
    // await prefs.setString('action', 'Start');
    // // Save an list of strings to 'items' key.
    // await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
  }

  /**
   * 获取数据
   */
  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    // Try reading data from the 'counter' key. If it doesn't exist, returns null.
    final int? counter = prefs.getInt('counter');
    print('$counter');
// Try reading data from the 'repeat' key. If it doesn't exist, returns null.
//     final bool? repeat = prefs.getBool('repeat');
// // Try reading data from the 'decimal' key. If it doesn't exist, returns null.
//     final double? decimal = prefs.getDouble('decimal');
// // Try reading data from the 'action' key. If it doesn't exist, returns null.
//     final String? action = prefs.getString('action');
// // Try reading data from the 'items' key. If it doesn't exist, returns null.
//     final List<String>? items = prefs.getStringList('items');
  }

  /**
   * 删除数据
   */
  Future<void> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('counter');
    if (success) {
      print('删除成功');
    }
  }
}
