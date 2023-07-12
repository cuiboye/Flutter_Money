import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/orderlist.dart';
import 'package:json_annotation/json_annotation.dart';


OrdertListModel $OrdertListModelFromJson(Map<String, dynamic> json) {
	final OrdertListModel ordertListModel = OrdertListModel();
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		ordertListModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		ordertListModel.result = result;
	}
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		ordertListModel.states = states;
	}
	return ordertListModel;
}

Map<String, dynamic> $OrdertListModelToJson(OrdertListModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['msg'] = entity.msg;
	data['result'] = entity.result.toJson();
	data['states'] = entity.states;
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final List<ListBean>? list = jsonConvert.convertListNotNull<ListBean>(json['list']);
	if (list != null) {
		result.list = list;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['list'] =  entity.list.map((v) => v.toJson()).toList();
	return data;
}

ListBean $ListBeanFromJson(Map<String, dynamic> json) {
	final ListBean listBean = ListBean();
	final List<GoodsLists>? goodsLists = jsonConvert.convertListNotNull<GoodsLists>(json['goodsLists']);
	if (goodsLists != null) {
		listBean.goodsLists = goodsLists;
	}
	final String? totalPrice = jsonConvert.convert<String>(json['totalPrice']);
	if (totalPrice != null) {
		listBean.totalPrice = totalPrice;
	}
	return listBean;
}

Map<String, dynamic> $ListBeanToJson(ListBean entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['goodsLists'] =  entity.goodsLists.map((v) => v.toJson()).toList();
	data['totalPrice'] = entity.totalPrice;
	return data;
}

GoodsLists $GoodsListsFromJson(Map<String, dynamic> json) {
	final GoodsLists goodsLists = GoodsLists();
	final String? beforePrice = jsonConvert.convert<String>(json['beforePrice']);
	if (beforePrice != null) {
		goodsLists.beforePrice = beforePrice;
	}
	final String? currentPrice = jsonConvert.convert<String>(json['currentPrice']);
	if (currentPrice != null) {
		goodsLists.currentPrice = currentPrice;
	}
	final String? goodsName = jsonConvert.convert<String>(json['goodsName']);
	if (goodsName != null) {
		goodsLists.goodsName = goodsName;
	}
	final String? imagePath = jsonConvert.convert<String>(json['imagePath']);
	if (imagePath != null) {
		goodsLists.imagePath = imagePath;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		goodsLists.type = type;
	}
	return goodsLists;
}

Map<String, dynamic> $GoodsListsToJson(GoodsLists entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['beforePrice'] = entity.beforePrice;
	data['currentPrice'] = entity.currentPrice;
	data['goodsName'] = entity.goodsName;
	data['imagePath'] = entity.imagePath;
	data['type'] = entity.type;
	return data;
}