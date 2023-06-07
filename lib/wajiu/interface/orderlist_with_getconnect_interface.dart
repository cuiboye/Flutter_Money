import 'package:flutter_money/wajiu/model/order_list_item_data_model.dart';
import 'package:flutter_money/wajiu/model/order_list_item_model.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';

// ignore: one_member_abstracts
abstract class IOrderListWithConnectRepository {
  Future<WajiuProductListNewModel> getOrderListData();
}
