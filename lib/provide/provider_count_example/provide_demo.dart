import 'package:flutter/material.dart';
import 'package:flutter_money/provide/provider_count_example/count_notifier.dart';
import 'package:flutter_money/provide/provider_count_example/provider_count_example.dart';
import 'package:provider/provider.dart';

/**
 * ChangeNotifierProvider：它跟Provider不同，ChangeNotifierProvider会监听模型对象的变化，而且当数据改变时，
 * 它也会重建Consumer(消费者)
 * 第一步：创建模型
 * 1）混入了ChangeNotifier
 * 2）调用了notifyListeners()
 * 因为模型使用了ChangeNotifier，那么我们就可以访问notifyListeners()，并且在带哦用它的任何时候，ChangeNotifierProvider
 * 都会收到通知并且消费者将重建UI
 */
class ProvideDemo extends StatefulWidget {
  @override
  _ProvideDemoState createState() => _ProvideDemoState();
}

class _ProvideDemoState extends State<ProvideDemo> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //create为监听的模型
      create: (_) => CountNotifier(),
      child: ProviderCountExample()
    );
  }
}
