import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/shop_car_model.dart';
import 'package:json_annotation/json_annotation.dart';


ShopCarModel $ShopCarModelFromJson(Map<String, dynamic> json) {
	final ShopCarModel shopCarModel = ShopCarModel();
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		shopCarModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		shopCarModel.result = result;
	}
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		shopCarModel.states = states;
	}
	return shopCarModel;
}

Map<String, dynamic> $ShopCarModelToJson(ShopCarModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['msg'] = entity.msg;
	data['result'] = entity.result.toJson();
	data['states'] = entity.states;
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final List<ShopCarList>? shopCarList = jsonConvert.convertListNotNull<ShopCarList>(json['shopCarList']);
	if (shopCarList != null) {
		result.shopCarList = shopCarList;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['shopCarList'] =  entity.shopCarList.map((v) => v.toJson()).toList();
	return data;
}

ShopCarList $ShopCarListFromJson(Map<String, dynamic> json) {
	final ShopCarList shopCarList = ShopCarList();
	final String? fathername = jsonConvert.convert<String>(json['fathername']);
	if (fathername != null) {
		shopCarList.fathername = fathername;
	}
	return shopCarList;
}

Map<String, dynamic> $ShopCarListToJson(ShopCarList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['fathername'] = entity.fathername;
	return data;
}