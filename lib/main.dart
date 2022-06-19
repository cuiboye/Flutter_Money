//此行代码作用是导入了 Material UI 组件库。Material (opens new window)是一种标准的移
//动端和web端的视觉设计语言， Flutter 默认提供了一套丰富的 Material 风格的UI组件。
import 'package:flutter/material.dart';
import 'package:flutter_money/layout_demo.dart';
import 'package:flutter_money/statefulwidget_demo.dart';
import 'channel.dart';
import 'http/http_demo.dart';
import 'launch_page.dart';
import 'statelesswidget_demo.dart';

// import 'statefulwidget_demo.dart';

//Flutter 应用中 main 函数为应用程序的入口。main 函数中调用了runApp 方法，它的功能是启
//动Flutter应用。runApp它接受一个 Widget参数，
//main函数使用了(=>)符号，这是 Dart 中单行函数或方法的简写。
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //MaterialApp 是Material 库中提供的 Flutter APP 框架，通过它可以设置应用的名
    //称、主题、语言、首页及路由列表等。MaterialApp也是一个 widget。
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Scaffold(
          appBar: AppBar(
            title: Text("首页"),
          ),
          body: RouteNavigator()
      ),//home 为 Flutter 应用的首页，它也是一个 widget。
      routes:  <String,WidgetBuilder>{
        "statelesswidget":(BuildContext context) => StatelessWidgetDemo(),
        "statefulwidget":(BuildContext context) => StatefulWidgetDemo(),
        "layoutwidget":(BuildContext context) => LayoutDemoWidget(),
        "channel":(BuildContext context) => const PlatformChannel(),
        "launchpage":(BuildContext context) =>  LaunchPage(),
        "http":(BuildContext context) =>  HttpDemo(),
      },
    );
  }
}
class RouteNavigator extends StatefulWidget {
  const RouteNavigator({Key? key}) : super(key: key);

  @override
  _RouteNavigatorState createState() => _RouteNavigatorState();
}

class _RouteNavigatorState extends State<RouteNavigator> {
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SwitchListTile(
            title:Text('${byName ? '' : '不'}通过路由名跳转'),
            value: byName,
            onChanged: (value) {
              setState(() {
                byName = value;
              });
            }),
        _item('StatelessWidget组件的使用', StatelessWidgetDemo(), 'statelesswidget'),
        _item('StatefulWidget组件的使用', StatefulWidgetDemo(), 'statefulwidget'),
        _item('布局的使用', LayoutDemoWidget(), 'layoutwidget'),
        _item('flutter和原生通信', const PlatformChannel(), 'channel'),
        _item('打开第三方应用', LaunchPage(), 'launchpage'),
        _item('http请求', HttpDemo(), 'http'),
      ],
    );
  }

  _item(String title, page, String routeName) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}

