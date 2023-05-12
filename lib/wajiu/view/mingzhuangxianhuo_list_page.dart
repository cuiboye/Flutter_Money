import 'package:flutter/material.dart';
import 'package:flutter_money/provide/provider_mvvm_example/provider_mvvm_example.dart';
import 'package:flutter_money/provide/provider_mvvm_example/view_model/joke_view_model.dart';
import 'package:flutter_money/wajiu/page_mingzhuangxianhuo.dart';
import 'package:flutter_money/wajiu/view/mingzhuangxianhuo_list_model.dart';
import 'package:provider/provider.dart';

/**
 * Selector
 */
class MingzhuangxianhuoPage extends StatefulWidget {
  @override
  _MingzhuangxianhuoPageState createState() => _MingzhuangxianhuoPageState();
}

class _MingzhuangxianhuoPageState extends State<MingzhuangxianhuoPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MingzhuangxianhuoViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MingzhuangxianhuoView(),
      ),
    );
  }
}
