import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';

///setter和getter
class SetUsePage extends StatefulWidget {
  const SetUsePage({super.key});

  @override
  State<SetUsePage> createState() => _SetUsePageState();
}

class _SetUsePageState extends State<SetUsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        context: context,
        title: 'setter和getter',
      ),
      body: ElevatedButton(
        onPressed: test,
        child: Text('setter和getter'),
      ),
    );
  }

  void test() {
    Person person = Person('zhangsan', 16);
    person.achievement = 20;
    debugPrint('${person.achievement}');
  }
}

class Person {
  // 定义变量
  final String name;
  final int age;

  // 标准构造方法, 下面的方法是常用的构造方法写法
  Person(this.name, this.age);

  // ★ get 方法 : 设置私有字段 achievement 的 get 方法,
  //            让外界可以访问 Person 对象的 _achievement 私有成员
  int get achievement => _achievement;

  // 私有字段
  int _achievement = 0;

  // ★ set 方法 : 设置私有字段 achievement 的 set 方法,
  //            让外界可以设置 Person 对象的 _achievement 私有成员值
  // set achievement(int achievement) {
  //   _achievement = achievement;
  // }
  //上面的set方法可以简写如下
  set achievement(int achievement)=>_achievement = achievement;

  // 重写父类的方法
  @override
  String toString() {
    return "$name : $age";
  }
}
