import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/category_second_type_list_model.dart';
import 'package:flutter_money/wajiu/model/orderlist.dart';

import 'package:json_annotation/json_annotation.dart';


CategorySecondTypeListModel $CategorySecondTypeListModelFromJson(Map<String, dynamic> json) {
	final CategorySecondTypeListModel categorySecondTypeListModel = CategorySecondTypeListModel();
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		categorySecondTypeListModel.states = states;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		categorySecondTypeListModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		categorySecondTypeListModel.result = result;
	}
	return categorySecondTypeListModel;
}

Map<String, dynamic> $CategorySecondTypeListModelToJson(CategorySecondTypeListModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['states'] = entity.states;
	data['msg'] = entity.msg;
	data['result'] = entity.result?.toJson();
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final List<BannerList>? bannerList = jsonConvert.convertListNotNull<BannerList>(json['bannerList']);
	if (bannerList != null) {
		result.bannerList = bannerList;
	}
	final List<ParameterList?>? parameterList = jsonConvert.convertList<ParameterList>(json['parameterList']);
	if (parameterList != null) {
		result.parameterList = parameterList;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['bannerList'] =  entity.bannerList?.map((v) => v.toJson()).toList();
	data['parameterList'] =  entity.parameterList?.map((v) => v?.toJson()).toList();
	return data;
}

BannerList $BannerListFromJson(Map<String, dynamic> json) {
	final BannerList bannerList = BannerList();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		bannerList.name = name;
	}
	final String? value = jsonConvert.convert<String>(json['value']);
	if (value != null) {
		bannerList.value = value;
	}
	return bannerList;
}

Map<String, dynamic> $BannerListToJson(BannerList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['value'] = entity.value;
	return data;
}

ParameterList $ParameterListFromJson(Map<String, dynamic> json) {
	final ParameterList parameterList = ParameterList();
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		parameterList.title = title;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		parameterList.name = name;
	}
	final List<ListBean?>? list = jsonConvert.convertList<ListBean>(json['list']);
	if (list != null) {
		parameterList.list = list;
	}
	final String? reqName = jsonConvert.convert<String>(json['reqName']);
	if (reqName != null) {
		parameterList.reqName = reqName;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		parameterList.type = type;
	}
	return parameterList;
}

Map<String, dynamic> $ParameterListToJson(ParameterList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['title'] = entity.title;
	data['name'] = entity.name;
	data['list'] =  entity.list?.map((v) => v?.toJson()).toList();
	data['reqName'] = entity.reqName;
	data['type'] = entity.type;
	return data;
}

ListBean $ListBeanFromJson(Map<String, dynamic> json) {
	final ListBean listBean = ListBean();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		listBean.name = name;
	}
	final dynamic value = jsonConvert.convert<dynamic>(json['value']);
	if (value != null) {
		listBean.value = value;
	}
	final int? hotFlag = jsonConvert.convert<int>(json['hotFlag']);
	if (hotFlag != null) {
		listBean.hotFlag = hotFlag;
	}
	return listBean;
}

Map<String, dynamic> $ListBeanToJson(ListBean entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['value'] = entity.value;
	data['hotFlag'] = entity.hotFlag;
	return data;
}