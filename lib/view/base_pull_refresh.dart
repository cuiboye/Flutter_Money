import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * 上拉加载下拉刷新基类
 */
class BasePullRefreshView extends StatefulWidget {
  final VoidCallback? _onRefresh;
  final VoidCallback? _onLoading;
  final Widget _listContentWidget;
  final bool _hasData;
  final RefreshController _refreshController;
  final Widget _headWidget;
  final Widget _footerWidget;

  void enableFlags({bool? bold, bool? hidden}) {}

  BasePullRefreshView(Widget listContentWidget,
      {Key? key,
      VoidCallback? onRefresh,
      VoidCallback? onLoading,
      required bool hasData,
      required RefreshController refreshController,
      Widget headWidget = const SizedBox(
        height: 0,
        width: 0,
      ),
      Widget footerWidget = const SizedBox(
        height: 0,
        width: 0,
      )})
      : _onRefresh = onRefresh,
        _onLoading = onLoading,
        _listContentWidget = listContentWidget,
        _refreshController = refreshController,
        _headWidget = headWidget,
        _footerWidget = footerWidget,
        _hasData = hasData,
        super(key: key);


  @override
  _BasePullRefreshViewState createState() => _BasePullRefreshViewState();
}

class _BasePullRefreshViewState extends State<BasePullRefreshView> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (widget._hasData) {
              if (mode == LoadStatus.idle) {
                body = const Text("上拉加载");
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("加载失败！点击重试！");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("松手,加载更多!");
              } else {
                body = const Text("没有更多数据了!");
              }
            } else {
              body = const Text("没有更多数据了!");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: widget._refreshController,
        onRefresh: widget._onRefresh,
        onLoading: widget._onLoading,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Column(
              children: [
                widget._headWidget,//ListView的header
                widget._listContentWidget,//ListView
                widget._footerWidget,//ListView的footer
              ],
            ))
          ],
        ));
  }
}
