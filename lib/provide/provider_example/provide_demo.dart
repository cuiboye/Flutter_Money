import 'package:flutter/material.dart';
import 'package:flutter_money/provide/provider_count_example/count_notifier.dart';
import 'package:flutter_money/provide/provider_count_example/provider_count_example.dart';
import 'package:flutter_money/provide/provider_example/provider_example.dart';
import 'package:flutter_money/provide/provider_example/user_model.dart';
import 'package:provider/provider.dart';

/**
 * Provide:8种提供者之一，是最基本的Provider组件，可以使用它为组件中的任何位置提供值，使用Provider不会更新UI
 */
class ProvideDemo2 extends StatefulWidget {
  @override
  _ProvideDemo2State createState() => _ProvideDemo2State();
}

class _ProvideDemo2State extends State<ProvideDemo2> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      //create为监听的模型
      create: (_) => UserModel(),
      child: ProviderExample()
    );
  }
}
