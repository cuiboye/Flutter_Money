import 'package:flutter/material.dart';
import 'package:flutter_money/provide/provider_mvvm_example/provider_mvvm_example.dart';
import 'package:flutter_money/provide/provider_mvvm_example/view_model/joke_view_model.dart';
import 'package:flutter_money/wajiu/view_model/orderlist_view_model.dart';
import 'package:provider/provider.dart';

import 'order_list_item.dart';

/**
 * Selector
 */
class OrderListItemMain extends StatefulWidget {
  @override
  _OrderListItemMain6State createState() => _OrderListItemMain6State();
}

class _OrderListItemMain6State extends State<OrderListItemMain> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderListViewModel(),
      child: OrderListItem(),
    );
  }
}
