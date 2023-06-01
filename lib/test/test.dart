import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_money/widget/cache_image_view.dart';
import 'package:flutter_money/widget/custom_container_layout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(
//     //   theme: ThemeData(
//     //     primarySwatch: Colors.blue,
//     //   ),
//     //   home: HomePage(
//     //     child: Scaffold(
//     //       appBar: AppBar(
//     //         title: Text('InheritedWidget Demo'),
//     //       ),
//     //       body: Column(
//     //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //         children: <Widget>[
//     //           WidgetA(),
//     //           WidgetB(),
//     //           WidgetC(),
//     //         ],
//     //       ),
//     //     ),
//     //   ),
//     // );
//
//     return MaterialApp(
//       home: Scaffold(
//         appBar: CustomAppbar(context: context,title: "hello",),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             // WidgetA(),
//             // WidgetB(),
//             // WidgetC(),
//           ],
//         ),
//       )
//     );
//   }
// }
//
//
// class _MyInheritedWidget extends InheritedWidget {
//
//   final HomePageState data;
//
//   _MyInheritedWidget({ Key? key, required Widget child, required this.data }) : super(key: key, child: child);
//
//   @override
//   bool updateShouldNotify(_MyInheritedWidget oldWidget) {
//     return true;
//   }
//
// }
//
// class HomePage extends StatefulWidget {
//
//   final Widget child;
//
//   const HomePage({Key? key, required this.child}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() {
//     return HomePageState();
//   }
//
//   static HomePageState? of(BuildContext context, {bool rebuild = true}) {
//     if (rebuild) {
//       return context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>()?.data;
//     }
//     return context.findAncestorWidgetOfExactType<_MyInheritedWidget>()?.data;
//     //or
//     //return (context.getElementForInheritedWidgetOfExactType<_MyInheritedWidget>().widget as _MyInheritedWidget).data;
//   }
// }
// class FooterWidget extends StatelessWidget {
//   @override
//
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text("sd"),
//     );
//   }
// }
// class HomePageState extends State<HomePage> {
//   int counter = 0;
// @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//   }
//   void _incrementCounter() {
//     print('HomePageState before _incrementCounter counter $counter');
//     setState(() {
//       counter++;
//       print('HomePageState counter $counter');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _MyInheritedWidget(
//       data: this,
//       // child: widget.child,
//       child: const SizedBox(),
//
//     );
//   }
// }
//
//
// class WidgetA extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print("WidgetA");
//     final HomePageState? state = HomePage.of(context);
//
//     return Center(
//       child: Text(
//         '${state?.counter}',
//         style: Theme.of(context).textTheme.headline4,
//       ),
//     );
//   }
// }
//
// class WidgetB extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print("WidgetB");
//
//     return Text('I am a widget that will not be rebuilt.');
//   }
// }
//
// class WidgetC extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print("WidgetC");
//
//     final HomePageState? state = HomePage.of(context, rebuild: false);
//
//     return RaisedButton(
//       onPressed: () {
//         state?._incrementCounter();
//       },
//       child: Icon(Icons.add),
//     );
//   }
// }

// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() =>
//       _MSValueListenableBuilderDemoState();
// }
//
// class _MSValueListenableBuilderDemoState
//     extends State<Test> {
//   // 定义一个ValueNotifier，当数字变化时会通知 ValueListenableBuilder
//   final ValueNotifier<int> _counter = ValueNotifier<int>(0);
//   @override
//   Widget build(BuildContext context) {
//     // 点击 + 按钮不会触发整个 ValueListenableRoute 组件的 build
//     print('build');
//     return Scaffold(
//       appBar: AppBar(title: Text("ValueListenableBuilderDemo")),
//       body: Center(
//         child: ValueListenableBuilder<int>(
//           valueListenable: _counter,
//           // builder 方法只会在 _counter 变化时被调用
//           builder: (ctx, value, child) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 child!,
//                 Text("$value 次", textScaleFactor: 1.5),
//               ],
//             );
//           },
//           // 当子组件不依赖变化的数据，且子组件收件开销比较大时，指定 child 属性来缓存子组件非常有用
//           child: Text("点击了", textScaleFactor: 1.5),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           // 点击后值 +1，触发 ValueListenableBuilder 重新构建
//           _counter.value++;
//         },
//       ),
//     );
//   }
// }
// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: new Text(
//           "WrapContentPage",
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           constraints:
//
//           ///关键就是 minHeight 和  double.infinity
//           ///这样就可以由内部 children 来支撑决定外部大小
//           BoxConstraints(minHeight: 100, maxHeight: double.infinity),
//           child: Column(
//             ///min而不是max
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 ///关键就是 minHeight 和  double.infinity
//                 constraints: BoxConstraints(
//                   minHeight: 100,
//                   maxHeight: double.infinity,
//                 ),
//
//                 /// Stack 默认是 StackFit.loose, 需要内部一个固定的最大大小来支撑
//                 child: Stack(
//                   children: [
//                     new Container(
//                       height: 400,
//                       color: Colors.yellow,
//                     ),
//                     new Container(
//                       height: 50,
//                       color: Colors.red,
//                     ),
//                     Positioned(
//                       left: 0,
//                       right: 0,
//                       top: 0,
//                       child: Container(
//                         height: 56,
//                         alignment: Alignment.centerLeft,
//                         color: Colors.blueGrey,
//                         child: new Container(
//                           width: 33,
//                           height: 33,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 20),
//
//                 ///关键就是 minHeight 和  double.infinity
//                 constraints:
//                 BoxConstraints(minHeight: 100, maxHeight: double.infinity),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     new Container(
//                       height: 600,
//                       color: Colors.green,
//                     ),
//                     new Container(
//                       height: 50,
//                       color: Colors.amber,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  int num = 1;
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
          appBar: CustomAppbar(
            context: context,
            title: "hello",
          ),
          body: Column(
            children: [
              // Visibility (//不可见时，不保留位置
              //     visible: false, // 设置是否可见：true:可见 false:不可见
              //     child: Text('Hello World')),
              // // Offstage(//不可见时，不保留位置
              // //     offstage: true, // 设置是否可见：true:不可见 false:可见
              // //     child: Text('Hello World')),
              // // Opacity(//不可见时，保留位置
              // //     opacity: 0.0, // 设置是否可见：0:不可见 1:可见
              // //     child: Text('Hello World')),
              //
              // Visibility(
              //   //vip过期 或者数据为空 展示的视图
              //   replacement: num==1
              //       ? Container()
              //       : Container(
              //     child: Image.asset(
              //       ImgAssets.icon_icon_com,
              //       scale: 2.1,
              //     ),
              //   ),
              //   //vip下要展示的视图
              //   visible: !DateUtils.timeVipDiss(brandItemModel?.vipEndtime),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         child: Image.asset(
              //           Image..icon_tip_mxt,
              //           scale: 2.1,
              //         ),
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Text("盟信通认证，真实品牌商家",
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //           style: pingFangM(10, color: Color(0xFF666666))),
              //       Container(
              //         child: Image.asset(
              //           ImgAssets.icon_toward_light,
              //           scale: 2.5,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              //
              // Text("sdfds")
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Image.asset(
                  'images/main_page_banner1.jpeg',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              ClipOval(//裁剪为圆形（宽和长相等）
                child: Image.asset(
                  'images/main_page_banner1.jpeg',
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              PhysicalModel(
                //PhysicalModel和ClipRRect的区别：ClipRRect不能设置z轴和阴影，其他效果跟PhysicalModel 基本一致
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'images/main_page_banner1.jpeg',
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )),
    );
  }
  // PartialCourseData partialCourseData = PartialCourseData.fromCourseData(courseData)
}
// class PartialCourseData {
//   final String name;
//   final String description;
//
//   PartialCourseData(this.name, this.description);
//
//   PartialCourseData.fromCourseData(CourseData courseData)
//       : name = courseData.name,
//         description = courseData.description;
// }