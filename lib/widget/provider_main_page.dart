
import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:flutter_money/animation_main.dart';
import 'package:flutter_money/provide/Inherited_context_example/provide_demo5.dart';
import 'package:flutter_money/provide/change_notifier_provider_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_count_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_example/provide_demo.dart';
import 'package:flutter_money/provide/provider_mvvm_example/provide_demo.dart';
import 'package:flutter_money/provide/selector_example/provide_demo.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';

///provider
class ProviderMainPage extends StatefulWidget {
  const ProviderMainPage({super.key});

  @override
  State<ProviderMainPage> createState() => _ProviderMainPageState();
}

class _ProviderMainPageState extends State<ProviderMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context: context,title: '动画',),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(ProvideDemo()), child: Text('Provider的例子')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(ProvideDemo2()), child: Text('Provider计数器')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(ProvideDemo3()), child: Text('ChangeNotifierProvider')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(ProvideDemo4()), child: Text('Provider_Selector相关')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(ProvideDemo5()), child: Text('inderited_provider_example')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(ProvideDemo6()), child: Text('Provider+MVVM'))
        ],
      ),
    );
  }
}
