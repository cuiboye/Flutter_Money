import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/common_request_model.dart';
import 'package:json_annotation/json_annotation.dart';


CommonRequestModel $CommonRequestModelFromJson(Map<String, dynamic> json) {
	final CommonRequestModel commonRequestModel = CommonRequestModel();
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		commonRequestModel.msg = msg;
	}
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		commonRequestModel.states = states;
	}
	return commonRequestModel;
}

Map<String, dynamic> $CommonRequestModelToJson(CommonRequestModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['msg'] = entity.msg;
	data['states'] = entity.states;
	return data;
}