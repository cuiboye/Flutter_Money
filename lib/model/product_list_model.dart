import 'package:json_annotation/json_annotation.dart';

part 'product_list_model.g.dart';

@JsonSerializable()
class ProductListModel{

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result result;

  @JsonKey(name: 'states')
  int states;

  ProductListModel(this.msg,this.result,this.states,);

  factory ProductListModel.fromJson(Map<String, dynamic> srcJson) => _$ProductListModelFromJson(srcJson);

}


@JsonSerializable()
class Result{

  @JsonKey(name: 'list')
  List<ListData> list;

  @JsonKey(name: 'startTime')
  String startTime;

  Result(this.list,this.startTime,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

}


@JsonSerializable()
class ListData{
  factory ListData.fromJson(Map<String, dynamic> srcJson) => _$ListDataFromJson(srcJson);

  @JsonKey(name: 'beforePrice')
  String beforePrice;

  @JsonKey(name: 'currentPrice')
  String currentPrice;

  @JsonKey(name: 'descript')
  String descript;

  @JsonKey(name: 'imageUrl')
  String imageUrl;

  @JsonKey(name: 'productName')
  String productName;

  @JsonKey(name: 'tags')
  List<String> tags;

  @JsonKey(name: 'type')
  int type;

  ListData(this.beforePrice,this.currentPrice,this.descript,this.imageUrl,this.productName,this.tags,this.type,);
}


