import 'package:flutter/cupertino.dart';

class ShareDataWidget extends InheritedWidget {
  final int? data; //需要在子树中共享的数据，保存点击次数
  ShareDataWidget({Key? key, this.data, required Widget child}): super(key: key, child: child);


  //可以看到dependOnInheritedElement方法中主要是注册了依赖关系！看到这里也就清晰了，调用dependOnInheritedWidgetOfExactType()
  //和 getElementForInheritedWidgetOfExactType()的区别就是前者会注册依赖关系，而后者不会，所以在调用dependOnInheritedWidgetOfExactType()时，
  //InheritedWidget和依赖它的子孙组件关系便完成了注册，之后当InheritedWidget发生变化时，就会更新依赖它的子孙组件，也就是会调这些子孙组
  //件的didChangeDependencies()方法和build()方法。而当调用的是 getElementForInheritedWidgetOfExactType()时，由于没有注册依
  //赖关系，所以之后当InheritedWidget发生变化时，就不会更新相应的子孙Widget。

  //注意，如果将ShareDataWidget.of()方法实现改成调用getElementForInheritedWidgetOfExactType()，运行示例后，点
  //击"Increment"按钮，会发现TestWidgetState的didChangeDependencies()方法确实不会再被调用，但是其build()仍然会被
  //调用！造成这个的原因其实是，点击"Increment"按钮后，会调用_InheritedWidgetTestRouteState的setState()方法，此时会重新
  //构建整个页面，由于示例中，TestWidget 并没有任何缓存，所以它也都会被重新构建，所以也会调用build()方法。要想解决这个问题，就需要
  //使用缓存来实现

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget? of(BuildContext context) {
    //dependOnInheritedWidgetOfExactType会注册依赖关系，它会将 InheritedWidget 存储到 Map 中
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();

    //使用下面这句，将不会再回调didChangeDependencies
    //getElementForInheritedWidgetOfExactType不会注册依赖关系
    // return context.getElementForInheritedWidgetOfExactType<ShareDataWidget>()?.widget as ShareDataWidget;
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}