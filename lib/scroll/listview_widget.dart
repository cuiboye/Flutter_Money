import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';

import '../view/custom_materialapp.dart';

/**
 * ListView
 * 1)ListView是最常用的可滚动组件之一，它可以沿一个方向线性排布所有子组件，并且它也支持列表项懒加载（在需要时才会创建）。
 * 2)默认构造函数有一个children参数，它接受一个Widget列表（List<Widget>）。这种方式适合只有少量的子组件数量已知且比较少的情况，
 * 反之则应该使用ListView.builder 按需动态构建列表项。
    注意：虽然这种方式将所有children一次性传递给 ListView，但子组件）仍然是在需要时才会加载（build（如有）、布局、绘制），也
    就是说通过默认构造函数构建的 ListView 也是基于 Sliver 的列表懒加载模型。
 * 2)ListView.builder适合列表项比较多或者列表项不确定的情况
 * itemBuilder：它是列表项的构建器，类型为IndexedWidgetBuilder，返回值为一个widget。当列表滚动到具体的index位置时，会调用该构建器构建列表项。
 * itemCount：列表项的数量，如果为null，则为无限列表。
 * 3)ListView.separated
 * ListView.separated可以在生成的列表项之间添加一个分割组件，它比ListView.builder多了一个separatorBuilder参数，该参数是一
 * 个分割组件生成器。
 */
class ListViewWidget extends StatefulWidget {
  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  Divider _divider = new Divider(
    height: 1,
    color: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(
          title: 'ListView',
          context: context,
        ),
        // body: ListView(
        //   children:[
        //     Text("Hello",style: TextStyle(height: 40)),
        //     Text("Hello",style: TextStyle(height: 40)),
        //     Text("Hello",style: TextStyle(height: 40)),
        //     Text("Hello",style: TextStyle(height: 40)),
        //     Text("Hello",style: TextStyle(height: 40)),
        //   ]
        // )
        // body: ListView.builder(
        //     itemBuilder: (BuildContext context, int index){
        //       return _listViewItem();
        //     },
        //   itemCount: 10,
        // ),
        // body: ListView.separated(
        //     itemBuilder: (BuildContext context, int index) {
        //       return Text("item");
        //     },
        //     separatorBuilder: (BuildContext context, int index) {//item之间的view
        //       return _divider;
        //     },
        //     itemCount: 10,
        // ),

        //为ListView添加一个header
        body: Column(
          children: [
            ListTile(title: Text("ListView的header")),
            Expanded(
                child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Text("item");
                    }
                )
            )
          ],
        ),
      ),
    );
  }

  Widget _listViewItem() {
    return const Text("Hello", style: TextStyle(color: Colors.red, height: 40));
  }
}
