import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';


@JsonSerializable()
class LoginModel{

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'states')
  int states;

  LoginModel(this.msg,this.states,);

  factory LoginModel.fromJson(Map<String, dynamic> srcJson) => _$LoginModelFromJson(srcJson);

}

