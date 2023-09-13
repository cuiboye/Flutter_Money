import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///淡入淡出动画
class AnimatedOpacityPage extends StatefulWidget {
  const AnimatedOpacityPage({super.key});

  @override
  State<AnimatedOpacityPage> createState() => _AnimatedOpacityPageState();
}

class _AnimatedOpacityPageState extends State<AnimatedOpacityPage> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        context: context,
        title: '动画',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Call setState. This tells Flutter to rebuild the
                // UI with the changes.
                setState(() {
                  _visible = !_visible;
                });
              },
              child: const Icon(Icons.flip),
            ),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
