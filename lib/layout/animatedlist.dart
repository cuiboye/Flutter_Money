import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 *AnimatedList 和 ListView 的功能大体相似，不同的是， AnimatedList 可以在列表中插入或删除节点时执行一个动画，在需
 * 要添加或删除列表项的场景中会提高用户体验。
 */
class AnimatedListLayout extends StatefulWidget {
  @override
  _AnimatedListState createState() => _AnimatedListState();
}

class _AnimatedListState extends State<AnimatedListLayout> {
  final globalKey = GlobalKey<AnimatedListState>();
  int counter = 5;
  var data = <String>[];
  @override
  void initState() {
    for(var i=0;i<counter;i++){
      data.add("${i+1}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        home: Scaffold(
        appBar:CustomAppbar(
          title: 'AnimatedList',
          context: context,
        ),
      body: Stack(
          children: [
            AnimatedList(
              key: globalKey,
              initialItemCount: counter,
              itemBuilder: (BuildContext context, int index, Animation<double> animation) {
              //添加列表时会执行渐显动画
                return FadeTransition(
                    opacity: animation,
                    child: buildItem(context,index),
                );
            }),
            buildAddBtn(),
          ],
      ),
    ));
  }

  // 创建一个 “+” 按钮，点击后会向列表中插入一项
  Widget buildAddBtn() {
    return Positioned(
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // 添加一个列表项
          data.add('${++counter}');
          // 告诉列表项有新添加的列表项
          globalKey.currentState!.insertItem(data.length - 1);
          print('添加 $counter');
        },
      ),
      bottom: 30,
      left: 0,
      right: 0,
    );
  }


  Widget buildItem(BuildContext context, int index) {
    String char = data[index];
    return ListTile(
      //数字不会重复，所以作为Key
      key: ValueKey(char),
      title: Text("数据 $char"),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        // 点击时删除
        onPressed: () => onDelete(context, index),
      ),
    );
  }

  void onDelete(context, index) {
    setState(() {
      globalKey.currentState!.removeItem(
        index,
            (context, animation) {
          // 删除过程执行的是反向动画，animation.value 会从1变为0
          var item = buildItem(context, index);
          print('删除 ${data[index]}');
          data.removeAt(index);
          // 删除动画是一个合成动画：渐隐 + 缩小列表项告诉
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              //让透明度变化的更快一些
              curve: const Interval(0.5, 1.0),
            ),
            // 不断缩小列表项的高度
            child: SizeTransition(
              sizeFactor: animation,
              axisAlignment: 0.0,
              child: item,
            ),
          );
        },
        duration: Duration(milliseconds: 200), // 动画时间为 200 ms
      );
    });
  }
}
