import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';

/**
 * Icon的使用
 * 1)Flutter 中，我们可以通过Image组件来加载并显示图片，Image的数据源可以是asset、文件、内存以及网络。
 * 2)加载本地图片
    在pubspec.yaml中的flutter部分添加如下内容：
    assets:
    - images/avatar.png
    注意: 由于 yaml 文件对缩进严格，所以必须严格按照每一层两个空格的方式进行缩进，此处 assets 前面应有两个空格。
    Image(image: AssetImage("images/avatar.png"));
    Image也提供了一个快捷的构造函数Image.asset用于从asset中加载、显示图片：
    Image.asset("images/avatar.png")
  3）从网络加载图片
    第一种：
    Image.network
    第二种：
    Image(image: NetworkImage("https://img2.woyaogexing.com/2022/06/27/cfc12e601b8aeb10.jpg"))
  4）参数
    width、height：用于设置图片的宽、高，当不指定宽高时，图片会根据当前父容器的限制，尽可能的显示其原始大小，如果只设
    置width、height的其中一个，那么另一个属性默认会按比例缩放。

    fit：该属性用于在图片的显示空间和图片本身大小不同时指定图片的适应模式。适应模式是在BoxFit中定义，它是一个枚举类型，有如下值：
    fill：会拉伸填充满显示空间，图片本身长宽比会发生变化，图片会变形。
    cover：会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁。
    contain：这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形。
    fitWidth：图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
    fitHeight：图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
    none：图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分。

    color和 colorBlendMode：在图片绘制时可以对每一个像素进行颜色混合处理，color指定混合色，而colorBlendMode指定混合模式
 5）Icon的使用
 */
class IconDemo extends StatefulWidget {
  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<IconDemo> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar:CustomAppbar(
          title: 'Icon的使用',
          context: context,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage('images/type_huodong.png'),
                  width: 80,
                  height: 80,
                ),
                Image.asset(
                  'images/type_huodong.png',
                  width: 80,
                  height: 80,
                ),
                Image(
                  image: NetworkImage("https://img2.woyaogexing.com/2022/06/27/cfc12e601b8aeb10.jpg"),
                  width: 80,
                  height: 80,
                ),
                Image.network(
                  'https://img2.woyaogexing.com/2022/06/27/cfc12e601b8aeb10.jpg',
                  width: 80,
                  height: 80,
                ),
              ],
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("参数-fit"),
                      Image.network(
                        fit:BoxFit.fill,
                        'https://img2.woyaogexing.com/2022/06/27/cfc12e601b8aeb10.jpg',
                        width: 80,
                        height: 80,
                      )
                    ],
                  ),
                  Row(
                     children: [
                       Text("参数-color和colorBlendMode"),
                       Image.network(
                         'https://img2.woyaogexing.com/2022/06/27/cfc12e601b8aeb10.jpg',
                         fit:BoxFit.fill,
                         color: Colors.blue,
                         colorBlendMode: BlendMode.difference,
                         width: 80,
                         height: 80,
                       )
                     ],
                  ),
                  Row(
                    children: [
                      Text("参数-repeat"),
                      Image.asset(
                        'images/type_huodong.png',
                        width: 80,
                        height: 80,
                        repeat: ImageRepeat.repeatY ,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Icon的使用"),
                      Icon(
                        Icons.arrow_back,
                       size: 5,//设置Icon的大小
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
