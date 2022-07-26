import 'package:flutter/material.dart';
import 'package:flutter_money/provide/selector_example/selector_example.dart';
import 'package:flutter_money/provide/selector_example/user_model6.dart';
import 'package:provider/provider.dart';

/**
 * Selector
 */
class ProvideDemo4 extends StatefulWidget {
  @override
  _ProvideDemo4State createState() => _ProvideDemo4State();
}

class _ProvideDemo4State extends State<ProvideDemo4> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserModel6>(
      //create为监听的模型
      create: (_) => UserModel6(),
      child: SelectorExample()
    );
  }
}
