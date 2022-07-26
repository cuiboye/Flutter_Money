import 'package:flutter/material.dart';
import 'package:flutter_money/sqllite/sqflite_instance.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

class SqfliteDemo extends StatefulWidget {
  @override
  _SqfliteDemoState createState() => _SqfliteDemoState();
}

class _SqfliteDemoState extends State<SqfliteDemo> {

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        body: Wrap(
          children: [
           ElevatedButton(
               onPressed: ()=>{
                 SqfliteInstance.getInstance().openDB("person.db")
               },
               child: Text("打开数据库")
           ),
            ElevatedButton(
                onPressed: ()=>{
                  SqfliteInstance.getInstance().closeDatabase()
                },
                child: Text("关闭数据库")
            ),
            ElevatedButton(
                onPressed: ()=>{
                  SqfliteInstance.getInstance().createTable()
                },
                child: Text("创建表")
            ),
            ElevatedButton(
                onPressed: ()=>{
                  SqfliteInstance.getInstance().insertData()
                },
                child: Text("插入数据")
            ),
            ElevatedButton(
                onPressed: ()=>{
                  SqfliteInstance.getInstance().queryData()
                },
                child: Text("查询数据")
            ),
            ElevatedButton(
                onPressed: ()=>{
                  SqfliteInstance.getInstance().updateData()
                },
                child: Text("更新数据")
            ),
            ElevatedButton(
                onPressed: ()=>{
                  SqfliteInstance.getInstance().deleteTable()
                },
                child: Text("删除表")
            ),
            ElevatedButton(
                onPressed: ()=>{
                  SqfliteInstance.getInstance().deleteData()
                },
                child: Text("删除数据")
            ),
            ElevatedButton(
                onPressed: ()=>{
                  SqfliteInstance.getInstance().handleWithBatch()
                },
                child: Text("Batch批量处理")
            ),
          ],
        ),
        appBar:CustomAppbar(
          title: 'Sqflite的使用',
          context: context,
        ),
      ),
    );
  }

  @override
  void initState() {
    SqfliteInstance.getInstance().requestPermission();
  }
}
