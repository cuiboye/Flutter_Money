import 'package:flutter/material.dart';
import 'package:flutter_money/wajiu/view/wajiu_my_balance.dart';
import 'package:flutter_money/wajiu/view_model/balance_view_model.dart';
import 'package:provider/provider.dart';

class MyBalance extends StatefulWidget {
  @override
  _MyBalanceState createState() => _MyBalanceState();
}

class _MyBalanceState extends State<MyBalance> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BalanceViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyBalanceView(),
      ),
    );
  }
}
