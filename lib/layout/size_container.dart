import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/extension/text_extension.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../view/custom_appbar.dart';

/**
 * 尺寸限制类容器
 * 1）尺寸限制类容器用于限制容器大小，Flutter中提供了多种这样的容器，如ConstrainedBox、SizedBox、
 * UnconstrainedBox、AspectRatio 等等
 * 2）Flutter 中有两种布局模型：
 *
 *    基于 RenderBox 的盒模型布局。
 *    基于 Sliver ( RenderSliver ) 按需加载列表布局。
 *    两种布局方式在细节上略有差异，但大体流程相同，布局流程如下：
 *    上层组件向下层组件传递约束（constraints）条件。
 *    下层组件确定自己的大小，然后告诉上层组件。注意下层组件的大小必须符合父组件的约束。
 *    上层组件确定下层组件相对于自身的偏移和确定自身的大小（大多数情况下会根据子组件的大小来确定自身的大小）。
 *    比如，父组件传递给子组件的约束是“最大宽高不能超过100，最小宽高为0”，如果我们给子组件设置宽高都为200，则子组件最
 *    终的大小是100*100，因为任何时候子组件都必须先遵守父组件的约束，在此基础上再应用子组件约束（相当于父组件的约束和自身的大小求一个交集）。
 *   盒模型布局组件有两个特点：
 *   组件对应的渲染对象都继承自 RenderBox 类。在本书后面文章中如果提到某个组件是 RenderBox，则指它是基于盒模型布局
 *   的，而不是说组件是 RenderBox 类的实例。
 *   在布局过程中父级传递给子级的约束信息由 BoxConstraints 描述。
 *   3）BoxConstraints
 *   BoxConstraints 是盒模型布局过程中父渲染对象传递给子渲染对象的约束信息，包含最大宽高信息，子组件大小需要在约束的范
 *   围内。
 *   const BoxConstraints({
    this.minWidth = 0.0, //最小宽度
    this.maxWidth = double.infinity, //最大宽度
    this.minHeight = 0.0, //最小高度
    this.maxHeight = double.infinity //最大高度
    })
    BoxConstraints还定义了一些便捷的构造函数，用于快速生成特定限制规则的BoxConstraints，如BoxConstraints.tight(Size size)，
    它可以生成固定宽高的限制；BoxConstraints.expand()可以生成一个尽可能大的用以填充另一个容器的BoxConstraints。除此之外还有一些
    其它的便捷函数。
    4）ConstrainedBox用于对子组件添加额外的约束。例如，如果你想让子组件的最小高度是80像素，你可以使用
    const BoxConstraints(minHeight: 80.0)作为子组件的约束。
    ConstrainedBox也可以使用一些方便的方法：
    ConstrainedBox.
    5）SizedBox 用于给子元素指定固定的宽高
    6)ConstrainedBox和SizedBox都是通过RenderConstrainedBox来渲染的，我们可以看到ConstrainedBox和SizedBox的
    createRenderObject()方法都返回的是一个RenderConstrainedBox对象
    7）UnconstrainedBox
    需要注意，UnconstrainedBox 虽然在其子组件布局时可以取消约束（子组件可以为无限大），但是 UnconstrainedBox 自身是受其父组件约束
    的，所以当 UnconstrainedBox 随着其子组件变大后，如果UnconstrainedBox 的大小超过它父组件约束时，也会导致溢出报错
    8）AspectRatio可以指定自组件的长宽比
    9）LimitedBox可以限制自组件的最大宽高，前提是LimitedBox只有在自身不受约束时才能限制
    10)FractionallySizedBox可以填充剩余空间
 */
class SizeContainer extends StatefulWidget {
  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<SizeContainer> {
  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
      home: Scaffold(
          appBar:CustomAppbar(
            title: '尺寸限制类容器',
            context: context,
          ),
        body: Scrollbar(

          child: SingleChildScrollView(
          
            child: Column(
              children: [
                Text("1.ConstrainedBox(约束子View)"),
                ConstrainedBox(
                  //ConstrainedBox 约束大小的组件
                  constraints: BoxConstraints(
                      minWidth: double.infinity, //宽度无限大
                      minHeight: 50 //最小高度为50
                  ),
                  child: Container(
                    height: 5.0,
                    child: redBox,
                  ),
                ),
                Text("2.SizedBox用于给子元素指定固定的宽高"),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: redBox,
                ),
                Text("实际上SizedBox只是ConstrainedBox的一个定制，上面代码等价于：BoxConstraints.tightFor(width: 80, height: 80)：限制组件的大小"),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 80, height: 80),//BoxConstraints.tightFor限制组件的大小
                  child: redBox,
                ),
                Text("BoxConstraints的其他方法："),
                Text("BoxConstraints.tight(Size(80,80))：设置组件的宽高"),
                ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(80,80)),//BoxConstraints.tight设置组件的宽高
                  child: redBox,
                ),
                Text("BoxConstraints.expand():占据父组件的剩余空间"),
                Container(
                  width: 80,
                  height: 80,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(),//BoxConstraints.expand()占据父组件的剩余空间
                    child: redBox,
                  ),
                ),
                Text("3)ConstrainedBox的多重限制：有多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的。"),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: 90,//取到父View的最大值
                      minWidth: 10
                  ),
                  child:  ConstrainedBox(
                      child: redBox,
                      constraints: BoxConstraints(
                          minHeight: 60,
                          minWidth: 40////取到子View的最大值
                      )
                  ),
                ),
                Text("4)通过UnconstrainedBox去除父View的限制"),
                ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: 90,//取到父View的最大值
                        minWidth: 10
                    ),
                    child:  UnconstrainedBox(//UnconstrainedBox去除了父View minHeight: 90， minWidth: 10的约束，将使用自己的minHeight: 60,minWidth: 40
                      child: ConstrainedBox(
                          child: redBox,
                          constraints: BoxConstraints(
                            //需要注意：UnconstrainedBox对父组件限制的“去除”并非是真正的去除：虽然红色区域大小是10×40，
                            //但上方仍然有80的空白空间。也就是说父限制的minHeight(100.0)仍然是生效的，只不过它不影响最终子元素
                            //redBox的大小，但仍然还是占有相应的空间，可以认为此时的父ConstrainedBox是作用于子UnconstrainedBox上，
                            //而redBox只受子ConstrainedBox限制
                              minHeight: 10,
                              minWidth: 40////取到子View的最大值
                          )
                      ),
                    )
                ),
                Text("4)AspectRatio可以指定子组件的长宽比"),
                  AspectRatio( //AspectRatio可以指定自组件的长宽比
                    aspectRatio: 5.0 / 2.0, //设置宽高比为5:2
                    child: Image.network("http://www.devio.org/img/avatar.png",
                        fit: BoxFit.cover //需设置一下裁剪模式来查看效果
                        ),
                  ),
                  Text("5)LimitedBox限制子组件的长宽最大宽高"),
                  UnconstrainedBox(
                    child: LimitedBox(
                        maxHeight: 40,
                        maxWidth: 20,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.blue),
                        )),
                  ),
                  Text("5)FractionallySizedBox可以填充剩余空间(宽/高)"),
                  FractionallySizedBox(
                      //FractionallySizedBox可以填充剩余空间
                      widthFactor: 1,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.red),
                        child: Text("Hello"),
                      ))
                ],
              ),
            ),
        )
      ),
    );
  }

  Widget redBox = DecoratedBox(
      //DecoratedBox 装饰器
      decoration: BoxDecoration(color: Colors.red));
}
