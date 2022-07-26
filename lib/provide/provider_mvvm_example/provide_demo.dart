import 'package:flutter/material.dart';
import 'package:flutter_money/provide/provider_mvvm_example/provider_mvvm_example.dart';
import 'package:flutter_money/provide/provider_mvvm_example/view_model/joke_view_model.dart';
import 'package:provider/provider.dart';

/**
 * Selector
 */
class ProvideDemo6 extends StatefulWidget {
  @override
  _ProvideDemo6State createState() => _ProvideDemo6State();
}

class _ProvideDemo6State extends State<ProvideDemo6> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JokeViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProviderMvvmExample(),
      ),
    );
  }
}
