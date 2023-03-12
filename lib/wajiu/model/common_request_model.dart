import 'package:json_annotation/json_annotation.dart';

part 'common_request_model.g.dart';

/**
 * 这个模型只有msg和states
 */

@JsonSerializable()
class CommonRequestModel{

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'states')
  int states;

  CommonRequestModel(this.msg,this.states,);

  factory CommonRequestModel.fromJson(Map<String, dynamic> srcJson) => _$CommonRequestModelFromJson(srcJson);

}


