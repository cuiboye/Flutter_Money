import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/category_type_list_model.dart';
import 'package:json_annotation/json_annotation.dart';


CategoryTypeListModel $CategoryTypeListModelFromJson(Map<String, dynamic> json) {
	final CategoryTypeListModel categoryTypeListModel = CategoryTypeListModel();
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		categoryTypeListModel.states = states;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		categoryTypeListModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		categoryTypeListModel.result = result;
	}
	return categoryTypeListModel;
}

Map<String, dynamic> $CategoryTypeListModelToJson(CategoryTypeListModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['states'] = entity.states;
	data['msg'] = entity.msg;
	data['result'] = entity.result?.toJson();
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final List<TypeList?>? typeList = jsonConvert.convertList<TypeList>(json['typeList']);
	if (typeList != null) {
		result.typeList = typeList;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['typeList'] =  entity.typeList?.map((v) => v?.toJson()).toList();
	return data;
}

TypeList $TypeListFromJson(Map<String, dynamic> json) {
	final TypeList typeList = TypeList();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		typeList.name = name;
	}
	final String? value = jsonConvert.convert<String>(json['value']);
	if (value != null) {
		typeList.value = value;
	}
	final String? key = jsonConvert.convert<String>(json['key']);
	if (key != null) {
		typeList.key = key;
	}
	return typeList;
}

Map<String, dynamic> $TypeListToJson(TypeList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['value'] = entity.value;
	data['key'] = entity.key;
	return data;
}