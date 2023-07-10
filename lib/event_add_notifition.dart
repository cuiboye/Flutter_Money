import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

class EventAddNotifitonWidget extends StatefulWidget {
  const EventAddNotifitonWidget({super.key});

  @override
  State<EventAddNotifitonWidget> createState() =>
      _EventAddNotifitonWidgetState();
}

class _EventAddNotifitonWidgetState extends State<EventAddNotifitonWidget> {
  PointerEvent? _event;
  String _operation = "No Gesture";
  double _width = 200.00;
  bool _toggle = false; //变色开关
  String _msg = "";
  final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer();

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
          appBar: CustomAppbar(
            context: context,
            title: "事件处理与通知",
          ),
          // NotificationListener可以监听滚动
          // body: NotificationListener(
          //   child: SingleChildScrollView(
          //     child:contentWidget(),
          //   ),
          //   onNotification: (Notification notification) {
          //     switch (notification.runtimeType) {
          //       case ScrollStartNotification:
          //         print("开始滚动");
          //         break;
          //       case ScrollUpdateNotification:
          //         print("正在滚动");
          //         break;
          //       case ScrollEndNotification:
          //         print("停止滚动");
          //         break;
          //       case OverscrollNotification:
          //         if (kDebugMode) {
          //           print("滚动到边界");
          //         }
          //         break;
          //     }
          //     //它的返回值类型为布尔值，当返回值为true时，阻止冒泡，其父级Widget将再也收不到该通知；
          //     //当返回值为false 时继续向上冒泡通知。
          //     return false;
          //   },
          // )

        //NotificationListener 可以指定一个模板参数，该模板参数类型必须是继承自Notification；当显式指定模板参数时，NotificationListener 便只会接收该参数类型的通知。
        //指定监听通知的类型为滚动结束通知(ScrollEndNotification)
        // body: NotificationListener<ScrollEndNotification>(
        //   child: SingleChildScrollView(
        //     child: contentWidget(),
        //   ),
        //   onNotification: (notification){
        //     //只会在滚动结束时才会触发此回调
        //     print("滚动停止");
        //     return false;
        //   },
        // ),
        //根Context和当前节点的Context，通过Builder来构建ElevatedButton，来获得按钮位置的context
        // body: NotificationListener<MyNotification>(
        //   onNotification: (notification){
        //     setState(() {
        //       _msg += notification.msg+" ";
        //     });
        //     return true;
        //   },
        //   child: Center(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         //下面注释的代码是不能正常工作的，因为这个context是根Context，而NotificationListener是监听的子树，所以我们通过Builder来构建ElevatedButton，来获得按钮位置的context。
        //         // ElevatedButton(
        //         //     onPressed: ()=>MyNotification("HI").dispatch(context),
        //         //     child: const Text("Send Notification")
        //         // ),
        //         Builder(builder: (BuildContext context){
        //           return ElevatedButton(
        //               onPressed: ()=>MyNotification("HI").dispatch(context),
        //               child: const Text("Send Notification")
        //           );
        //         }),
        //         Text(_msg)
        //       ],
        //     ),
        //   ),
        // ),
        body: NotificationListener<MyNotification>(
          onNotification: (notification){
            print(notification.msg); //打印通知
            return false;
          },
          child: NotificationListener<MyNotification>(
              onNotification: (notification) {
                setState(() {
                  _msg+=notification.msg+"  ";
                });
                return true;//这里如果返回true的话，父组件的NotificationListener将不会接收到通知了
              },
              child: Builder(builder: (BuildContext context){
                          return ElevatedButton(
                              onPressed: ()=>MyNotification("HI").dispatch(context),
                              child: const Text("Send Notification")
                          );
                        }),)
        ),
      ),
    );
  }


  Widget contentWidget(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "1）Listener组件",
          style: TextStyle(fontSize: 18),
        ),
        Listener(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 300.0,
            height: 150.0,
            child: Text(
              '${_event?.localPosition ?? ''}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          onPointerDown: (PointerDownEvent event) =>
              setState(() => _event = event),
          onPointerMove: (PointerMoveEvent event) =>
              setState(() => _event = event),
          onPointerUp: (PointerUpEvent event) =>
              setState(() => _event = event),
        ),
        const Text(
          "2）指针事件-向上冒泡",
          style: TextStyle(fontSize: 18),
        ),
        //点击后，先是输出inner，然后输出outter
        Listener(
          child: Listener(
            child: Container(
              height: 100,
              width: 200,
              color: Colors.red,
            ),
            onPointerDown: (PointerDownEvent event) => print("inner"),
          ),
          onPointerDown: (PointerDownEvent event) => print("outter"),
        ),
        const Text(
          "3）忽略指针事件-AbsorbPointer,AbsorbPointer本身会参与命中测试，但其子树不行",
          style: TextStyle(fontSize: 18),
        ),
        //点击后，先是输出inner，然后输出outter
        Listener(
          child: AbsorbPointer(
            child: Listener(
              child: Container(
                height: 100,
                width: 200,
                color: Colors.red,
              ),
              onPointerDown: (PointerDownEvent event) =>
                  print("inner"),
            ),
          ),
          onPointerDown: (PointerDownEvent event) => print("outter"),
        ),
        const Text(
          "4）忽略指针事件-IgnorePointer,IgnorePointer本身和子Widget都不会参与命中测试",
          style: TextStyle(fontSize: 18),
        ),
        //点击后，先是输出inner，然后输出outter
        Listener(
          child: IgnorePointer(
            child: Listener(
              child: Container(
                height: 100,
                width: 200,
                color: Colors.red,
              ),
              onPointerDown: (PointerDownEvent event) =>
                  print("inner"),
            ),
          ),
          onPointerDown: (PointerDownEvent event) => print("outter"),
        ),
        const Text(
          "5）GestureDetector是一个用于手势识别的功能性组件，我们通过它可以来识别各种手势。GestureDetector 内部封装了 Listener",
          style: TextStyle(fontSize: 18),
        ),
        GestureDetector(
          child: Container(
            width: 200,
            height: 100,
            color: Colors.red,
            child: Text("$_operation"),
          ),
          onTap: () => updateGestureState("点击"),
          onDoubleTap: () => updateGestureState("双击"),
          onLongPress: () => updateGestureState("长按"),
        ),
        const Text(
            "注意：当同时监听onTap和onDoubleTap事件时，当用户触发tap事件时，会有200毫秒左右的延时，这是因为当用户点击完之后很可能会再次点击以触发双击事件，所以GestureDetector会等一段时间来确定是否为双击事件。如果用户只监听了onTap（没有监听onDoubleTap）事件时，则没有延时。"),

        const Text(
          "5）GestureDetector图片缩放功能",
          style: TextStyle(fontSize: 18),
        ),
        GestureDetector(
          child: Image.network(
            "https://lmg.jj20.com/up/allimg/4k/s/02/2109250006343S5-0-lp.jpg",
            width: _width,
          ),
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              //缩放倍数在0.8到10倍之间
              _width = 200 * details.scale.clamp(.8, 10.0);
            });
          },
          onTap: () => updateGestureState("点击"),
          onDoubleTap: () => updateGestureState("双击"),
          onLongPress: () => updateGestureState("长按"),
        ),
        const Text(
          "5）富文本+GestureRecognizer实现部分文字点击效果",
          style: TextStyle(fontSize: 18),
        ),
        Text.rich(TextSpan(children: [
          const TextSpan(text: "你好世界"),
          TextSpan(
              text: "你好世界",
              style: TextStyle(
                // color: _toggle ? Colors.blue : Colors.red),
                  color: _toggle ? Colors.blue : Colors.red),
              recognizer: _gestureRecognizer
                ..onTap = () {
                  setState(() {
                    _toggle = !_toggle ?? false;
                  });
                }),
          const TextSpan(text: "你好世界"),
        ]))
      ],
    );
  }

  void updateGestureState(String gesture) {
    setState(() {});
    _operation = gesture;
  }

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _gestureRecognizer.dispose();
    super.dispose();
  }
}

class MyNotification extends Notification{
  final String msg;
  MyNotification(this.msg);
}