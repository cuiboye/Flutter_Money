import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * 对话框
 * 1)AlertDialog和SimpleDialog中使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸，这就导致他们
 * 的子组件不能是延迟加载模型的组件（如ListView、GridView 、 CustomScrollView等）
 * 2)如果我们就是需要嵌套一个ListView应该怎么做？这时，我们可以直接使用Dialog类
 */
class DialogDemo extends StatefulWidget {
  @override
  _DialogDemoState createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(
          title: '对话框',
          context: context,
        ),
        body: Column(
          children: [
            ElevatedButton(
              child: Text("对话框1"),
              onPressed: () async {
                //弹出对话框并等待其关闭
                bool? delete = await showDeleteConfirmDialog();
                if (delete == null) {
                  Fluttertoast.showToast(
                      msg: "This is Center Short Toast",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  print("取消删除");
                } else {
                  print("已确认删除");
                  //... 删除文件
                }
              },
            ),
            ElevatedButton(
              child: Text("对话框2"),
              onPressed: ()=>changeLanguage()
            ),
            ElevatedButton(
                child: Text("对话框3"),
                onPressed: ()=>showListDialog()
            ),
            ElevatedButton(
                child: Text("弹出底部菜单列表模态"),
              onPressed: () async {
                int? type = await _showModalBottomSheet();
                print(type);
              },
            ),
            ElevatedButton(
              child: Text("Loading框"),
              onPressed: () =>showLoadingDialog()
            ),
            ElevatedButton(
                child: Text("日历选择器"),
                onPressed: () =>_showDatePicker1()
            ),
            ElevatedButton(
                child: Text("IOS风格日历选择器"),
                onPressed: () =>_showDatePicker2()
            ),
          ],
        ),
      ),
    );
  }

  //日历选择器
  Future<DateTime?> _showDatePicker1() {
    var date = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add( //未来30天可选
        Duration(days: 30),
      ),
    );
  }

  //iOS风格的日历选择器需要使用showCupertinoModalPopup方法和CupertinoDatePicker组件来实现
  Future<DateTime?> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              print(value);
            },
          ),
        );
      },
    );
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  // 弹出底部菜单列表模态对话框
  Future<int?> _showModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      },
    );
  }

  // 弹出对话框
  Future<bool?> showDeleteConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> changeLanguage() async {
    int? i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(//SimpleDialogOption
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('美国英语'),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }

  Future<void> showListDialog() async {
    int? index = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        var child = Column(
          children: <Widget>[
            ListTile(title: Text("请选择")),
            Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () => Navigator.of(context).pop(index),
                    );
                  },
                )),
          ],
        );
        //使用AlertDialog会报错
        //return AlertDialog(content: child);
        return Dialog(child: child);
      },
    );
    if (index != null) {
      print("点击了：$index");
    }
  }

  Future<T?> showCustomDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    required WidgetBuilder builder,
    ThemeData? theme,
  }) {
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87, // 自定义遮罩颜色
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}
