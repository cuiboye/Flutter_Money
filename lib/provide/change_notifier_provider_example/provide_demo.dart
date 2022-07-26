import 'package:flutter/material.dart';
import 'package:flutter_money/provide/change_notifier_provider_example/change_notifier_provider_example.dart';
import 'package:flutter_money/provide/change_notifier_provider_example/user_model1.dart';
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
 *
 * 更加详细的可以参考：https://space.bilibili.com/410068229
 */
class ProvideDemo3 extends StatefulWidget {
  @override
  _ProvideDemo3State createState() => _ProvideDemo3State();
}

class _ProvideDemo3State extends State<ProvideDemo3> {
  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProvider需要注册到整个应用
    return ChangeNotifierProvider<UserModel1>(
      create: (_) => UserModel1(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProviderExample(),
      ),
    );
  }
}
