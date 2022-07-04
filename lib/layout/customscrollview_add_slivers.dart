import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/custom_appbar.dart';
import '../view/custom_materialapp.dart';

/**
 * CustomScrollView 和 Slivers
 * 1)CustomScrollView 的主要功能是提供一个公共的的 Scrollable 和 Viewport，来组合多个 Sliver
 * 2)SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。再次提醒，如果列表项高度相同，我们应该优
 * 先使用SliverFixedExtentList和 SliverPrototypeExtentList，如果不同，使用 SliverList.
 */
class CustomScrollViewAddSlivers extends StatefulWidget {
  @override
  _CustomScrollViewAddSliversState createState() =>
      _CustomScrollViewAddSliversState();
}

class _CustomScrollViewAddSliversState
    extends State<CustomScrollViewAddSlivers> {
  // SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。
  // 再次提醒，如果列表项高度相同，我们应该优先使用SliverFixedExtentList
  // 和 SliverPrototypeExtentList，如果不同，使用 SliverList.
  var listView = SliverFixedExtentList(
    itemExtent: 56, //列表项高度固定
    delegate: SliverChildBuilderDelegate(
      (_, index) => ListTile(title: Text('$index')),
      childCount: 10,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return CustomMaterialApp(
        home: Scaffold(
            appBar: CustomAppbar(
              title: 'PageView',
              context: context,
            ),
            // body: CustomScrollView(
            //   slivers: [listView, listView],
            // )
          //头部SliverAppBar：SliverAppBar对应AppBar，两者不同之处在于SliverAppBar可以集成到CustomScrollView。
          //SliverAppBar可以结合FlexibleSpaceBar实现Material Design中头部伸缩的模型，具体效果，读者可以运行该示例查看。
          //中间的SliverGrid：它用SliverPadding包裹以给SliverGrid添加补白。SliverGrid是一个两列，宽高比为4的网格，
          //它有20个子组件。
          //底部SliverFixedExtentList：它是一个所有子元素高度都为50像素的列表。

          //SliverToBoxAdapter
          //在实际布局中，我们通常需要往 CustomScrollView 中添加一些自定义的组件，而这些组件并非都有 Sliver 版本，为此 Flutter 提供
          //了一个SliverToBoxAdapter 组件，它是一个适配器：可以将 RenderBox 适配为 Sliver。比如我们想在列表顶部添加一个可以横向滑
          //动的 PageView，可以使用 SliverToBoxAdapter 来配置：
          body: Column(
            children: [
              Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      //下面的代码是可以正常运行的，但是如果将 PageView 换成一个滑动方向和 CustomScrollView 一致的 ListView 则不会
                      //正常工作！原因是：CustomScrollView 组合 Sliver 的原理是为所有子 Sliver 提供一个共享的 Scrollable，然后统
                      //一处理指定滑动方向的滑动事件，如果 Sliver 中引入了其它的 Scrollable，则滑动事件便会冲突。上例中 PageView 之
                      //所以能正常工作，是因为 PageView 的 Scrollable 只处理水平方向的滑动，而 CustomScrollView 是处理垂直方向的，
                      //两者并未冲突，所以不会有问题，但是换一个也是垂直方向的 ListView 时则不能正常工作，最终的效果是，在ListView内滑
                      //动时只会对ListView 起作用，原因是滑动事件被 ListView 的 Scrollable 优先消费，CustomScrollView 的
                      //Scrollable 便接收不到滑动事件了。

                      //如果 CustomScrollView 有孩子也是一个完整的可滚动组件且它们的滑动方向一致，则 CustomScrollView 不能正常工作。
                      //要解决这个问题，可以使用 NestedScrollView
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 300,
                          child: PageView(
                            children: [Text("1"), Text("2")],
                          ),
                        ),
                      ),
                      // AppBar，包含一个导航栏.
                      SliverAppBar(
                        pinned: true, // 滑动到顶端时会固定住
                        expandedHeight: 250.0,
                        flexibleSpace: FlexibleSpaceBar(
                          title: const Text('Demo'),
                          background: Image.asset(
                            "./images/image1.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        sliver: SliverGrid(
                          //Grid
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, //Grid按两列显示
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 4.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              //创建子widget
                              return Container(
                                alignment: Alignment.center,
                                color: Colors.cyan[100 * (index % 9)],
                                child: Text('grid item $index'),
                              );
                            },
                            childCount: 20,
                          ),
                        ),
                      ),
                      SliverFixedExtentList(
                        itemExtent: 50.0,
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            //创建列表项
                            return Container(
                              alignment: Alignment.center,
                              color: Colors.lightBlue[100 * (index % 9)],
                              child: Text('list item $index'),
                            );
                          },
                          childCount: 20,
                        ),
                      ),
                    ],
                  ),
              ),
            ],
          )
        ),
    );
  }
}
