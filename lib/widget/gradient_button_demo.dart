import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/view/gradient_button.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 渐变按钮
 */
class GradientButtonDemo extends StatefulWidget {
  const GradientButtonDemo({super.key});

  @override
  State<GradientButtonDemo> createState() => _GradientButtonDemoState();
}

class _GradientButtonDemoState extends State<GradientButtonDemo> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(
          context: context,
          title: "渐变按钮",
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              GradientButton(
                colors: const [Colors.orange, Colors.red],
                child: const Text("Submit"),
                onPressed: onTap,
              ),
              ElevatedGradientButton(
                colors: const [Colors.orange, Colors.red],
                child: const Text("Submit"),
                onPressed: onTap,
              ),
              GradientButton(
                child: const Text("Submit"),
                onPressed: onTap,
                borderRadius: BorderRadius.circular(30),
              ),
              ElevatedGradientButton(
                child: const Text("Submit"),
                onPressed: onTap,
                borderRadius: BorderRadius.circular(30),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: GradientButton(
                  colors: [Colors.lightGreen, Colors.green.shade700],
                  onPressed: onTap,
                  child: const Text("Submit"),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedGradientButton(
                  colors: [Colors.lightGreen, Colors.green.shade700],
                  onPressed: onTap,
                  child: const Text("Submit"),
                ),
              ),
              const ElevatedGradientButton(
                child: Text("Submit"),
                //onPressed: onTap,
              ),
            ].map((child) {
              return Padding(padding: EdgeInsets.all(8.w),child: child,);
            }).toList(),
          ),
        ),
      ),
    );
  }

  onTap() {
    debugPrint('button click');
  }
}
