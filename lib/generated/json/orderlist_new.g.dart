import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/orderlist_new.dart';
import 'package:json_annotation/json_annotation.dart';


OrdertListNewModel $OrdertListNewModelFromJson(Map<String, dynamic> json) {
	final OrdertListNewModel ordertListNewModel = OrdertListNewModel();
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		ordertListNewModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		ordertListNewModel.result = result;
	}
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		ordertListNewModel.states = states;
	}
	return ordertListNewModel;
}

Map<String, dynamic> $OrdertListNewModelToJson(OrdertListNewModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['msg'] = entity.msg;
	data['result'] = entity.result?.toJson();
	data['states'] = entity.states;
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final List<ListBean?>? delivery = jsonConvert.convertList<ListBean>(json['delivery']);
	if (delivery != null) {
		result.delivery = delivery;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['delivery'] =  entity.delivery?.map((v) => v?.toJson()).toList();
	return data;
}

ListBean $ListBeanFromJson(Map<String, dynamic> json) {
	final ListBean listBean = ListBean();
	final String? unionOrderNumber = jsonConvert.convert<String>(json['unionOrderNumber']);
	if (unionOrderNumber != null) {
		listBean.unionOrderNumber = unionOrderNumber;
	}
	final String? orderStatusStr = jsonConvert.convert<String>(json['orderStatusStr']);
	if (orderStatusStr != null) {
		listBean.orderStatusStr = orderStatusStr;
	}
	final List<OrdersBean?>? orders = jsonConvert.convertList<OrdersBean>(json['orders']);
	if (orders != null) {
		listBean.orders = orders;
	}
	return listBean;
}

Map<String, dynamic> $ListBeanToJson(ListBean entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['unionOrderNumber'] = entity.unionOrderNumber;
	data['orderStatusStr'] = entity.orderStatusStr;
	data['orders'] =  entity.orders?.map((v) => v?.toJson()).toList();
	return data;
}

OrdersBean $OrdersBeanFromJson(Map<String, dynamic> json) {
	final OrdersBean ordersBean = OrdersBean();
	final List<OrderListProductBean?>? orderProduct = jsonConvert.convertList<OrderListProductBean>(json['orderProduct']);
	if (orderProduct != null) {
		ordersBean.orderProduct = orderProduct;
	}
	final String? orderStatusStr = jsonConvert.convert<String>(json['orderStatusStr']);
	if (orderStatusStr != null) {
		ordersBean.orderStatusStr = orderStatusStr;
	}
	final String? orderTotalPriceStr = jsonConvert.convert<String>(json['orderTotalPriceStr']);
	if (orderTotalPriceStr != null) {
		ordersBean.orderTotalPriceStr = orderTotalPriceStr;
	}
	return ordersBean;
}

Map<String, dynamic> $OrdersBeanToJson(OrdersBean entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['orderProduct'] =  entity.orderProduct?.map((v) => v?.toJson()).toList();
	data['orderStatusStr'] = entity.orderStatusStr;
	data['orderTotalPriceStr'] = entity.orderTotalPriceStr;
	return data;
}

OrderListProductBean $OrderListProductBeanFromJson(Map<String, dynamic> json) {
	final OrderListProductBean orderListProductBean = OrderListProductBean();
	final String? cname = jsonConvert.convert<String>(json['cname']);
	if (cname != null) {
		orderListProductBean.cname = cname;
	}
	final String? stringOnePrice = jsonConvert.convert<String>(json['stringOnePrice']);
	if (stringOnePrice != null) {
		orderListProductBean.stringOnePrice = stringOnePrice;
	}
	final String? orderTypeStr = jsonConvert.convert<String>(json['orderTypeStr']);
	if (orderTypeStr != null) {
		orderListProductBean.orderTypeStr = orderTypeStr;
	}
	final String? isJiuZhouBianName = jsonConvert.convert<String>(json['isJiuZhouBianName']);
	if (isJiuZhouBianName != null) {
		orderListProductBean.isJiuZhouBianName = isJiuZhouBianName;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		orderListProductBean.picture = picture;
	}
	return orderListProductBean;
}

Map<String, dynamic> $OrderListProductBeanToJson(OrderListProductBean entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cname'] = entity.cname;
	data['stringOnePrice'] = entity.stringOnePrice;
	data['orderTypeStr'] = entity.orderTypeStr;
	data['isJiuZhouBianName'] = entity.isJiuZhouBianName;
	data['picture'] = entity.picture;
	return data;
}