import 'dart:convert';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteInstance {
  late Database _database;
  static SqfliteInstance sqflite = SqfliteInstance();

  static SqfliteInstance getInstance() {
    return sqflite;
  }

  Future<bool> requestPermission() async {
    late PermissionStatus status;
    // 1、读取系统权限的弹框
    if (Platform.isIOS) {
      status = await Permission.photosAddOnly.request();
    } else {
      status = await Permission.storage.request();
    }
    // 2、假如你点not allow后，下次点击不会在出现系统权限的弹框（系统权限的弹框只会出现一次），
    // 这时候需要你自己写一个弹框，然后去打开app权限的页面
    if (status != PermissionStatus.granted) {
      print("11111111");
    } else {
      print("22222222");
      return true;
    }
    return false;
  }

  void openDB(String path) async {
    //打开数据库
    _database = await openDatabase(path);
    //判断数据库是否打开
    if (_database.isOpen) {
      print("数据库已打开");
    } else {
      print("数据库打开失败");
    }
  }

  void closeDatabase() async {
    if (null == _database) {
      return;
    }
    print("数据库状态 ${_database.isOpen}");
    await _database.close();
    print("数据库状态 ${_database.isOpen}");
  }

  void createTable() async {
    await _database.execute(
        "CREATE TABLE person(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)");
  }

  void insertData() async {
    // int result = await _database.rawInsert("INSERT INTO person(name, age) values('Jimi', 18)");
    // print("插入数据：result的值为$result");

    //下面这种方式更加优雅，更方便
    int result =
        await _database.insert("person", {"name": "是Jimi啊", "age": 28});
    print("插入数据：result的值为$result");
  }

  void queryData() async {
    // var list = await _database.rawQuery("SELECT * FROM person");
    // print(list.toString());
    //第二种：query()
    var list = await _database.query(
      "person",
    );
    print(list.toString());
  }

  void updateData() async {
    // int result = await _database.rawUpdate('UPDATE person SET name = "李四" where id = 3');
    //下面这种写法更优雅
    int result =
        await _database.update("person", {"name": "张三"}, where: "id = 4");
  }

  //删除表
  void deleteTable() async {
    await _database.execute("DROP TABLE person");
  }

  //删除数据
  void deleteData() async {
    // int result = await _database.rawDelete('delete from person where id=2');
    //下面这种方式更优雅
    int result = await _database.delete("person", where: "id=1");
  }

  //Batch批量处理
  void handleWithBatch() async {
    var batch = _database.batch();

    batch.insert("person", {"name": "是Jimi啊", "age": 28});
    batch.update("person", {"name": "张飞"}, where: "id = 5");
    var results = await batch.commit();
  }
}
