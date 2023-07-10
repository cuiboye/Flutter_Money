import 'package:flutter/material.dart';
import 'package:flutter_money/view/keep_alive.dart';

/**
 *包括可滚动组件的子组件后，该子组件将会被缓存，意味着即使滑出屏幕也不会被销毁。
 */
class KeepAliveWrapperDemo extends StatefulWidget {
  const KeepAliveWrapperDemo({super.key});
  @override
  State<KeepAliveWrapperDemo> createState() => _KeepAliveWrapperDemoState();
}

class _KeepAliveWrapperDemoState extends State<KeepAliveWrapperDemo> {
  bool _keepAlive = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (_, index) {
      return KeepAliveWrapper(
        // 为 true 后会缓存所有的列表项，列表项将不会销毁。
        // 为 false 时，列表项滑出预加载区域后将会别销毁。
        // 使用时一定要注意是否必要，因为对所有列表项都缓存的会导致更多的内存消耗
        keepAlive: _keepAlive,
        child: wItem(index),
      );
    });
  }

  Widget wItem(index) {
    if (index == 0) {
      return CheckboxListTile(
        title: const Text('缓存列表项'),
        subtitle: const Text('勾选后将缓存每一个列表项'),
        value: _keepAlive,
        onChanged: (v) {
          setState(() {
            _keepAlive = v!;
          });
        },
      );
    } else {
      return ListItem(index: index);
    }
  }
}

class ListItem extends StatefulWidget {
  const ListItem({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('${widget.index}'));
  }

  @override
  void dispose() {
    debugPrint('dispose ${widget.index}');
    super.dispose();
  }
}
