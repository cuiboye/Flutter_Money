import 'package:flutter/material.dart';
import 'package:flutter_money/provide/Inherited_context_example/count_notifier2.dart';
import 'package:flutter_money/provide/Inherited_context_example/inherited_context_example.dart';
import 'package:flutter_money/provide/provider_count_example/count_notifier.dart';
import 'package:flutter_money/provide/provider_count_example/provider_count_example.dart';
import 'package:provider/provider.dart';

/**
 * InheritedContext
 */
class ProvideDemo5 extends StatefulWidget {
  @override
  _ProvideDemo5State createState() => _ProvideDemo5State();
}

class _ProvideDemo5State extends State<ProvideDemo5> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //create为监听的模型
      create: (_) => CountNotifier2(),
      child: InheritedContextExample()
    );
  }
}
