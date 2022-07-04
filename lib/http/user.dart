import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User{

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'statusBarColor')
  String statusBarColor;

  @JsonKey(name: 'hideAppBar')
  bool hideAppBar;
  
  User(this.icon,this.title,this.url,this.statusBarColor,this.hideAppBar,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);
}