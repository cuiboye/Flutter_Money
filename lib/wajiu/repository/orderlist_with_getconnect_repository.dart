import 'package:flutter_money/wajiu/constant/apiservice.dart';
import 'package:flutter_money/wajiu/interface/orderlist_with_getconnect_interface.dart';
import 'package:flutter_money/wajiu/model/order_list_item_new_model.dart';
import 'package:flutter_money/wajiu/provider/orderlist_with_getconnect_provider.dart';

class OrderListWithConnectRepository implements IOrderListWithConnectRepository {
  OrderListWithConnectRepository({required this.provider});
  final IOrderListWithConnectProvider provider;

  @override
  Future<WajiuProductListNewModel> getOrderListData() async {
    final response = await provider.getOrderListData(ApiService.getMyDelivery);
    print("11111");
    print("response.status ${response.status}");
    if (response.status.hasError) {//请求失败，http的响应code码不在200-299之间
    // if (response.status == 401) {
      return Future.error("用户未登录");
      // return Future.error(response.statusText!);
    } else {
      return response.body!;
    }
  }
}
