import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/order_list_item_data_model.dart';
import 'package:json_annotation/json_annotation.dart';


OrderListItemDataModel $OrderListItemDataModelFromJson(Map<String, dynamic> json) {
	final OrderListItemDataModel orderListItemDataModel = OrderListItemDataModel();
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		orderListItemDataModel.states = states;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		orderListItemDataModel.result = result;
	}
	return orderListItemDataModel;
}

Map<String, dynamic> $OrderListItemDataModelToJson(OrderListItemDataModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['states'] = entity.states;
	data['result'] = entity.result?.toJson();
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final List<Delivery>? delivery = jsonConvert.convertListNotNull<Delivery>(json['delivery']);
	if (delivery != null) {
		result.delivery = delivery;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['delivery'] =  entity.delivery.map((v) => v.toJson()).toList();
	return data;
}

Delivery $DeliveryFromJson(Map<String, dynamic> json) {
	final Delivery delivery = Delivery();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		delivery.id = id;
	}
	final String? unionOrderNumber = jsonConvert.convert<String>(json['unionOrderNumber']);
	if (unionOrderNumber != null) {
		delivery.unionOrderNumber = unionOrderNumber;
	}
	return delivery;
}

Map<String, dynamic> $DeliveryToJson(Delivery entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['unionOrderNumber'] = entity.unionOrderNumber;
	return data;
}