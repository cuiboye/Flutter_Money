import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:flutter_money/extension.dart';
import 'package:flutter_money/mixin/contact_data_mixin.dart';

///通话记录
class CallLogPage extends StatefulWidget{
  const CallLogPage({super.key});

  @override
  State<CallLogPage> createState() => _CallLogPageState();
}

class _CallLogPageState extends State<CallLogPage> with ContactDataMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        context: context,
        title: '通话记录',
      ),
      body: ElevatedButton(
        onPressed: (){
          // callLog();
          'sdf'.toColor();
        },
        child: const Text('获取通话记录'),
      ),
    );
  }
}
