import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/mingzhuangxianhuo_product_list_model.dart';
import 'package:json_annotation/json_annotation.dart';


MingzhuangxianhuoProductListModel $MingzhuangxianhuoProductListModelFromJson(Map<String, dynamic> json) {
	final MingzhuangxianhuoProductListModel mingzhuangxianhuoProductListModel = MingzhuangxianhuoProductListModel();
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		mingzhuangxianhuoProductListModel.states = states;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		mingzhuangxianhuoProductListModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		mingzhuangxianhuoProductListModel.result = result;
	}
	return mingzhuangxianhuoProductListModel;
}

Map<String, dynamic> $MingzhuangxianhuoProductListModelToJson(MingzhuangxianhuoProductListModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['states'] = entity.states;
	data['msg'] = entity.msg;
	data['result'] = entity.result.toJson();
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final int? isLogin = jsonConvert.convert<int>(json['isLogin']);
	if (isLogin != null) {
		result.isLogin = isLogin;
	}
	final List<Noticelist?>? noticelist = jsonConvert.convertList<Noticelist>(json['noticelist']);
	if (noticelist != null) {
		result.noticelist = noticelist;
	}
	final List<Productlist?>? productlist = jsonConvert.convertList<Productlist>(json['productlist']);
	if (productlist != null) {
		result.productlist = productlist;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['isLogin'] = entity.isLogin;
	data['noticelist'] =  entity.noticelist?.map((v) => v?.toJson()).toList();
	data['productlist'] =  entity.productlist?.map((v) => v?.toJson()).toList();
	return data;
}

Noticelist $NoticelistFromJson(Map<String, dynamic> json) {
	final Noticelist noticelist = Noticelist();
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		noticelist.picture = picture;
	}
	final String? parameter = jsonConvert.convert<String>(json['parameter']);
	if (parameter != null) {
		noticelist.parameter = parameter;
	}
	return noticelist;
}

Map<String, dynamic> $NoticelistToJson(Noticelist entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['picture'] = entity.picture;
	data['parameter'] = entity.parameter;
	return data;
}

Productlist $ProductlistFromJson(Map<String, dynamic> json) {
	final Productlist productlist = Productlist();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		productlist.id = id;
	}
	final String? cname = jsonConvert.convert<String>(json['cname']);
	if (cname != null) {
		productlist.cname = cname;
	}
	final String? ename = jsonConvert.convert<String>(json['ename']);
	if (ename != null) {
		productlist.ename = ename;
	}
	final String? description1 = jsonConvert.convert<String>(json['description1']);
	if (description1 != null) {
		productlist.description1 = description1;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		productlist.picture = picture;
	}
	final String? jnPrice = jsonConvert.convert<String>(json['jnPrice']);
	if (jnPrice != null) {
		productlist.jnPrice = jnPrice;
	}
	final int? replenishMent = jsonConvert.convert<int>(json['replenishMent']);
	if (replenishMent != null) {
		productlist.replenishMent = replenishMent;
	}
	final Operate? operate = jsonConvert.convert<Operate>(json['operate']);
	if (operate != null) {
		productlist.operate = operate;
	}
	return productlist;
}

Map<String, dynamic> $ProductlistToJson(Productlist entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['cname'] = entity.cname;
	data['ename'] = entity.ename;
	data['description1'] = entity.description1;
	data['picture'] = entity.picture;
	data['jnPrice'] = entity.jnPrice;
	data['replenishMent'] = entity.replenishMent;
	data['operate'] = entity.operate.toJson();
	return data;
}

Operate $OperateFromJson(Map<String, dynamic> json) {
	final Operate operate = Operate();
	final int? jnJudgeStock = jsonConvert.convert<int>(json['jnJudgeStock']);
	if (jnJudgeStock != null) {
		operate.jnJudgeStock = jnJudgeStock;
	}
	final double? jnPrice = jsonConvert.convert<double>(json['jnPrice']);
	if (jnPrice != null) {
		operate.jnPrice = jnPrice;
	}
	final ProductStorage? productStorage = jsonConvert.convert<ProductStorage>(json['productStorage']);
	if (productStorage != null) {
		operate.productStorage = productStorage;
	}
	return operate;
}

Map<String, dynamic> $OperateToJson(Operate entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['jnJudgeStock'] = entity.jnJudgeStock;
	data['jnPrice'] = entity.jnPrice;
	data['productStorage'] = entity.productStorage.toJson();
	return data;
}

ProductStorage $ProductStorageFromJson(Map<String, dynamic> json) {
	final ProductStorage productStorage = ProductStorage();
	final int? jnStock = jsonConvert.convert<int>(json['jnStock']);
	if (jnStock != null) {
		productStorage.jnStock = jnStock;
	}
	return productStorage;
}

Map<String, dynamic> $ProductStorageToJson(ProductStorage entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['jnStock'] = entity.jnStock;
	return data;
}