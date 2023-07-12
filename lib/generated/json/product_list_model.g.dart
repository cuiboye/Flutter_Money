import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/product_list_model.dart';
import 'package:json_annotation/json_annotation.dart';


ProductListModel $ProductListModelFromJson(Map<String, dynamic> json) {
	final ProductListModel productListModel = ProductListModel();
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		productListModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		productListModel.result = result;
	}
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		productListModel.states = states;
	}
	return productListModel;
}

Map<String, dynamic> $ProductListModelToJson(ProductListModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['msg'] = entity.msg;
	data['result'] = entity.result.toJson();
	data['states'] = entity.states;
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final List<ProductList>? productList = jsonConvert.convertListNotNull<ProductList>(json['productList']);
	if (productList != null) {
		result.productList = productList;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['productList'] =  entity.productList.map((v) => v.toJson()).toList();
	return data;
}

ProductList $ProductListFromJson(Map<String, dynamic> json) {
	final ProductList productList = ProductList();
	final int? productid = jsonConvert.convert<int>(json['productid']);
	if (productid != null) {
		productList.productid = productid;
	}
	final int? joinshoapcar = jsonConvert.convert<int>(json['joinshoapcar']);
	if (joinshoapcar != null) {
		productList.joinshoapcar = joinshoapcar;
	}
	final int? cangkuId = jsonConvert.convert<int>(json['cangkuId']);
	if (cangkuId != null) {
		productList.cangkuId = cangkuId;
	}
	final String? productName = jsonConvert.convert<String>(json['productName']);
	if (productName != null) {
		productList.productName = productName;
	}
	return productList;
}

Map<String, dynamic> $ProductListToJson(ProductList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['productid'] = entity.productid;
	data['joinshoapcar'] = entity.joinshoapcar;
	data['cangkuId'] = entity.cangkuId;
	data['productName'] = entity.productName;
	return data;
}