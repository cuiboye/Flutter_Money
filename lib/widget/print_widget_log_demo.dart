import 'package:flutter/material.dart';
import 'package:flutter_money/utils/layout_log_print.dart';

/**
 * 打印组件的约束
 */
class PrintWidgetLogDemo extends StatefulWidget {
  const PrintWidgetLogDemo({super.key});

  @override
  State<PrintWidgetLogDemo> createState() => _PrintWidgetLogDemoState();
}

class _PrintWidgetLogDemoState extends State<PrintWidgetLogDemo> {
  @override
  Widget build(BuildContext context) {
    return LayoutLogPrint(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LayoutLogPrint(
            child: Row(
              children: [
                LayoutLogPrint(child: const Text('flukit@wendux')),
                LayoutLogPrint(child: const Text('flukit@wendux')),
              ],
            ),
          ),
          GestureDetector(
            onTap: ()=>debugPrint('tap'),
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              color: Colors.red,
              child: LayoutLogPrint(
                child: const Text('A', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
