import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * Timer计时器
 */
class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer? timer1;
  late Timer? timer2;
  String currentStr= "start";
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(context: context,title: "Timer计时器"),
        body: Column(
          children: [
            Text("1)演示Timer倒计时结束"),
            ElevatedButton(onPressed: ()=>startTimer1(), child: const Text("开始计时")),
            Text("2)循环计时"),
            ElevatedButton(onPressed: ()=>startTimer2(), child: Text("$currentStr")),//onPressed中不能使用(){}方式来执行方法，否则一进页面就会执行倒计时的逻辑
            Text("3)使用Timer完成异步回调"),
            ElevatedButton(onPressed: ()=>startTimer3(), child: const Text("start")),
            Text("4)Timer.run"),
            ElevatedButton(onPressed: ()=>startTimer4(), child: const Text("start")),
          ],
        ),
      ),
    );
  }

  void startTimer1(){
    timer1 = Timer(Duration(seconds: 3), () {
      debugPrint("3秒后倒计时结束了！");
    });
  }

  void startTimer2(){
    timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      debugPrint("每隔一秒输出一次日志 ${timer.tick}");
      setState(() {
        currentStr = timer.tick.toString();
      });
    });
  }

  void startTimer3(){
    debugPrint("start");
    timer1 = Timer(Duration.zero, () {
      debugPrint("zeroDurationTimer callback");//因为一切的异步函数都被放到一个行列里进行调度，所以其回调的履行需要一点时刻。
    });
    debugPrint("end");
    // 输出结果：
    // start
    // end
    // zeroDurationTimer callback

    //上面这个写法可以简化为 startTime4
  }

  void startTimer4() {
    debugPrint("start");
    Timer.run(() {//run中实际上是在队列中存储了多个异步方法
      debugPrint("zeroDurationTimer callback");
    });
    debugPrint("end");
  }

  @override
  void dispose() {
    if(null!=timer1 && timer1?.isActive==true){
      timer1?.cancel();
    }
    if(null!=timer2 && timer2?.isActive==true){
      timer2?.cancel();
    }

    super.dispose();
  }
}
