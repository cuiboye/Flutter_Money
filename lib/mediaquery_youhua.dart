import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * MediaQuery的优化
 *
 * 可以看到在键盘弹起来的过程，因为 bottom 发生改变，所以 MediaQueryData 发生了改变，从而导致上一级
 * 的 MyHomePage 虽然不可见，但是在键盘弹起的过程里也被不断 build 。
 *
 * 试想一下，如果你在每个页面开始的位置都是用了 MediaQuery.of(context) ，然后打开了 5 个页面，这时候你
 * 在第 5 个页面弹出键盘时，也触发了前面 4 个页面 rebuild，自然而然可能就会出现卡顿。
 */
class MediaQueryYouhuaExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("######### MyHomePage ${MediaQuery.of(context).size}");
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
              return EditPage();
            }));
          },
          child: new Text(
            "Click",
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("ControllerDemoPage"),
      ),
      extendBody: true,
      body: Column(
        children: [
          new Spacer(),
          new Container(
            margin: EdgeInsets.all(10),
            child: new Center(
              child: new TextField(),
            ),
          ),
          new Spacer(),
        ],
      ),
    );
  }
}
