import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * Text的使用
 * 1)textAlign: 文本的对齐方式；可以选择左对齐、右对齐还是居中。注意，对齐的参考系是Text widget 本身。
 * 只有 Text 宽度大于文本内容长度时指定此属性才有意义。
 * 2)maxLines、overflow：指定文本显示的最大行数，默认情况下，文本是自动折行的，如果指定此参数，则文本最多不会超过指
 * 定的行。如果有多余的文本，可以通过overflow来指定截断方式，默认是直接截断，本例中指定的截断方式TextOverflow.ellipsis，它会
 * 将多余文本截断后以省略符“...”表示
 * 3)textScaleFactor:代表文本相对于当前字体大小的缩放因子，相对于去设置文本的样式style属性的fontSize，它是
 * 调整字体大小的一个快捷方式。该属性的默认值可以通过MediaQueryData.textScaleFactor获得，如果没有MediaQuery，
 * 那么会默认值将为1.0。
 * 4)TextStyle:TextStyle用于指定文本显示的样式如颜色、字体、粗细、背景等。
 * height：该属性用于指定行高，但它并不是一个绝对值，而是一个因子，具体的行高等于fontSize*height。
    fontFamily ：由于不同平台默认支持的字体集不同，所以在手动指定字体时一定要先在不同平台测试一下。
    fontSize：该属性和 Text 的textScaleFactor都用于控制字体大小。但是有两个主要区别：
    fontSize可以精确指定字体大小，而textScaleFactor只能通过缩放比例来控制。
    textScaleFactor主要是用于系统字体大小设置改变时对 Flutter 应用字体进行全局调整，而fontSize通常用于单个文
    本，字体大小不会跟随系统字体大小变化
    5)富文本：children是一个TextSpan的数组，也就是说TextSpan可以包括其他TextSpan。recognizer用于对该文本
    片段上用于手势进行识别处理。
   5）DefaultTextStyle：默认文本样式，如果在 Widget 树的某一个节点处设置一个默认的文本样式，那么该节点的子树中所
    有文本都会默认使用这个样式，而DefaultTextStyle正是用于设置默认文本样式的。
 */
class TextDemo extends StatefulWidget {
  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<TextDemo> {
  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer _recognizer = TapGestureRecognizer();
    _recognizer.onTap = () {
      print("click");
    };
    return CustomMaterialApp(
      home: Scaffold(
        appBar:CustomAppbar(
          title: 'Text的使用',
          context: context,
        ),
        body: Column(
          children: [
            Text("我是一个Text", textAlign: TextAlign.right).withContainer(),
            Text(
              "我是一个Text,此时textAlign才有效" * 4,
              textAlign: TextAlign.center,
            ).withContainer(),
            Text(
              "我是一个Text,限制了一行，行尾省略" * 4,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ).withContainer(),
            Text(
              "我是一个Text,此时textAlign才有效" * 4,
              textScaleFactor: 1.5,
            ).withContainer(),
            Text(
              "设置Text的TextStyle",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                  height: 1.2,
                  fontFamily: "Courier",
                  background: Paint()..color = Colors.yellow,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dashed),
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: "Home: "),
              TextSpan(
                text: "https://flutterchina.club",
                style: TextStyle(color: Colors.blue),
                recognizer: _recognizer,
              ),
            ])),
            DefaultTextStyle(//默认文本样式
              //1.设置文本默认样式
              style: TextStyle(
                color: Colors.red,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.start,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("hello world"),
                  Text("I am Jack"),
                  Text(
                    "I am Jack",
                    style: TextStyle(
                        inherit: false, //2.不继承默认样式
                        color: Colors.grey),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
