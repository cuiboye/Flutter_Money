import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/joined_product_list_model.dart';
import 'package:json_annotation/json_annotation.dart';


JoinedProductListModel $JoinedProductListModelFromJson(Map<String, dynamic> json) {
	final JoinedProductListModel joinedProductListModel = JoinedProductListModel();
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		joinedProductListModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		joinedProductListModel.result = result;
	}
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		joinedProductListModel.states = states;
	}
	return joinedProductListModel;
}

Map<String, dynamic> $JoinedProductListModelToJson(JoinedProductListModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['msg'] = entity.msg;
	data['result'] = entity.result.toJson();
	data['states'] = entity.states;
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final List<ShopcarList>? shopcarList = jsonConvert.convertListNotNull<ShopcarList>(json['shopcarList']);
	if (shopcarList != null) {
		result.shopcarList = shopcarList;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['shopcarList'] =  entity.shopcarList.map((v) => v.toJson()).toList();
	return data;
}

ShopcarList $ShopcarListFromJson(Map<String, dynamic> json) {
	final ShopcarList shopcarList = ShopcarList();
	final int? cangkuid = jsonConvert.convert<int>(json['cangkuid']);
	if (cangkuid != null) {
		shopcarList.cangkuid = cangkuid;
	}
	final String? fathername = jsonConvert.convert<String>(json['fathername']);
	if (fathername != null) {
		shopcarList.fathername = fathername;
	}
	final List<ProductList?>? productList = jsonConvert.convertList<ProductList>(json['productList']);
	if (productList != null) {
		shopcarList.productList = productList;
	}
	final bool? totalSelected = jsonConvert.convert<bool>(json['totalSelected']);
	if (totalSelected != null) {
		shopcarList.totalSelected = totalSelected;
	}
	return shopcarList;
}

Map<String, dynamic> $ShopcarListToJson(ShopcarList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cangkuid'] = entity.cangkuid;
	data['fathername'] = entity.fathername;
	data['productList'] =  entity.productList?.map((v) => v?.toJson()).toList();
	data['totalSelected'] = entity.totalSelected;
	return data;
}

ProductList $ProductListFromJson(Map<String, dynamic> json) {
	final ProductList productList = ProductList();
	final int? cangkuid = jsonConvert.convert<int>(json['cangkuid']);
	if (cangkuid != null) {
		productList.cangkuid = cangkuid;
	}
	final int? joinshoapcar = jsonConvert.convert<int>(json['joinshoapcar']);
	if (joinshoapcar != null) {
		productList.joinshoapcar = joinshoapcar;
	}
	final int? productid = jsonConvert.convert<int>(json['productid']);
	if (productid != null) {
		productList.productid = productid;
	}
	final int? selected = jsonConvert.convert<int>(json['selected']);
	if (selected != null) {
		productList.selected = selected;
	}
	final String? productname = jsonConvert.convert<String>(json['productname']);
	if (productname != null) {
		productList.productname = productname;
	}
	return productList;
}

Map<String, dynamic> $ProductListToJson(ProductList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cangkuid'] = entity.cangkuid;
	data['joinshoapcar'] = entity.joinshoapcar;
	data['productid'] = entity.productid;
	data['selected'] = entity.selected;
	data['productname'] = entity.productname;
	return data;
}