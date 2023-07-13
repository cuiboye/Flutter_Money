import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:flutter_money/view/custom_materialapp.dart';

/**
 * Box布局-松约束和紧约束
 * Column和Row这样的布局方法，称之为Flex布局。
 */
class YushuPage extends StatefulWidget {
  const YushuPage({super.key});

  @override
  State<YushuPage> createState() => _YushuPageState();
}

class _YushuPageState extends State<YushuPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      debugPrint("Root Constraints is $constraints");//Root传递给子Widget的是紧约束
      return CustomMaterialApp(
        home: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              debugPrint(
                  "MaterialApp Constraints is $constraints"); //MaterialApp传递给子Widget的是紧约束
              //=========1===========
              // return Scaffold(
              //   appBar: CustomAppbar(context: context, title: "约束布局",),
              //   body: LayoutBuilder(builder: (BuildContext context,
              //       BoxConstraints constraints) {
              //     debugPrint("Scaffold Constraints is $constraints");//Scaffold传递给子Widget的是松约束
              //     return Container(
              //       color: Colors.blue,
              //       //Row对child的束缚会修改为松束缚，然后不会束缚child在主轴方向上的尺度，所以当Row内的Child宽度大于屏幕宽度时，就会发生内容溢出的正告。
              //       //Flex的主轴束缚不限制，Flex束缚在交叉轴上会设置为松束缚（如果crossAxisAlignment设置为stretch，那么会变成紧束缚）。
              //       //通常会在Flex组件中运用Expanded组件来避免内容的溢出。Expanded组件会将主轴方向上的Child施加紧束缚，然后避免溢出。

              //       child: Column(
              //         children: [
              //           LayoutBuilder(
              //               builder: (BuildContext context,
              //                   BoxConstraints constraints) {
              //                 // debugPrint("Root Constraints is $constraints");
              //                 return Container(//Container有child时，Container的将松约束传递给子Widget
              //                   color: Colors.red,
              //                   child: Text("hello"),
              //                 );
              //               })
              //         ],
              //       ),
              //     );
              //   }),
              // );
              // );
              //=========2===========
              // return Scaffold(
              //     body: SizedBox(height: 100,
              //       child: Row(
              //         children: [
              //           Container(
              //             width: 50,
              //             color: Colors.red,
              //           ),
              //           // Expanded其实便是Flexible�的封装，仅仅将fit设置为了FlexFit.tight�。所以，下面的代码是等价的。
              //           // Expanded(child: ColoredBox(color: Colors.yellow)),
              //           // Flexible(child: ColoredBox(color: Colors.cyan), fit: FlexFit.tight),
              //           Expanded(child: Container(color: Colors.yellow,)),
              //           //当Text的文字过长时，将会把第4个组件订到最右边
              //           Flexible(child: Container(color: Colors.orange,child: Text("橘色"),),fit: FlexFit.loose),//tight代表充满，loose表示包裹
              //           Container(width: 50,color: Colors.purple,)
              //
              //         ],
              //       ),
              //     )
              // );
              // Wrap束缚:
              // Wrap组件与Flex组件有些相似，但又有些不同，Row中的child组件如果超越了屏幕宽度，就会导致内容溢出，由于Flex组件其主轴上的束缚为unbound，而Wrap组件，其主轴
              // 上的束缚会被修改为松束缚，交叉轴上的束缚会被改为unbound，这样就能够完成流式的布局作用
              //=========3===========
              return Scaffold(
            body: IntrinsicWidth(//IntrinsicWidth和IntrinsicHeight的妙用
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.red,
                    child: Center(
                      child: Text("第三方的是"),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    child: Text("sdfdsfdsf粉丝地方第三方的"),
                  ),
                  Container(
                    color: Colors.orange,
                    child: Text("123"),
                  )
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
