import 'package:flutter/widgets.dart';

/// KeepAliveWrapper can keep the item(s) of scrollview alive, **Not dispose**.
/**
 *包括可滚动组件的子组件后，该子组件将会被缓存，意味着即使滑出屏幕也不会被销毁。
 */
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child,
  }) : super(key: key);
  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    //print("KeepAliveWrapper dispose");
    super.dispose();
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
