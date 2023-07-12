import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/home_productlist_model.dart';
import 'package:json_annotation/json_annotation.dart';


HomeProductListModel $HomeProductListModelFromJson(Map<String, dynamic> json) {
	final HomeProductListModel homeProductListModel = HomeProductListModel();
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		homeProductListModel.states = states;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		homeProductListModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		homeProductListModel.result = result;
	}
	return homeProductListModel;
}

Map<String, dynamic> $HomeProductListModelToJson(HomeProductListModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['states'] = entity.states;
	data['msg'] = entity.msg;
	data['result'] = entity.result?.toJson();
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final int? isLogin = jsonConvert.convert<int>(json['isLogin']);
	if (isLogin != null) {
		result.isLogin = isLogin;
	}
	final List<HotWorldProductList?>? productList = jsonConvert.convertList<HotWorldProductList>(json['productList']);
	if (productList != null) {
		result.productList = productList;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['isLogin'] = entity.isLogin;
	data['productList'] =  entity.productList?.map((v) => v?.toJson()).toList();
	return data;
}

HotWorldProductList $HotWorldProductListFromJson(Map<String, dynamic> json) {
	final HotWorldProductList hotWorldProductList = HotWorldProductList();
	final int? productId = jsonConvert.convert<int>(json['productId']);
	if (productId != null) {
		hotWorldProductList.productId = productId;
	}
	final String? cname = jsonConvert.convert<String>(json['cname']);
	if (cname != null) {
		hotWorldProductList.cname = cname;
	}
	final String? ename = jsonConvert.convert<String>(json['ename']);
	if (ename != null) {
		hotWorldProductList.ename = ename;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		hotWorldProductList.picture = picture;
	}
	final double? jnPrice = jsonConvert.convert<double>(json['jnPrice']);
	if (jnPrice != null) {
		hotWorldProductList.jnPrice = jnPrice;
	}
	final String? countryName = jsonConvert.convert<String>(json['countryName']);
	if (countryName != null) {
		hotWorldProductList.countryName = countryName;
	}
	final String? grade = jsonConvert.convert<String>(json['grade']);
	if (grade != null) {
		hotWorldProductList.grade = grade;
	}
	final String? parameter = jsonConvert.convert<String>(json['parameter']);
	if (parameter != null) {
		hotWorldProductList.parameter = parameter;
	}
	return hotWorldProductList;
}

Map<String, dynamic> $HotWorldProductListToJson(HotWorldProductList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['productId'] = entity.productId;
	data['cname'] = entity.cname;
	data['ename'] = entity.ename;
	data['picture'] = entity.picture;
	data['jnPrice'] = entity.jnPrice;
	data['countryName'] = entity.countryName;
	data['grade'] = entity.grade;
	data['parameter'] = entity.parameter;
	return data;
}