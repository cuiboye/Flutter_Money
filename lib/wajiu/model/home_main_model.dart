import 'package:json_annotation/json_annotation.dart';

part 'home_main_model.g.dart';

@JsonSerializable()
class HomeMainModel {
  @JsonKey(name: 'states')
  int states;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result? result;

  HomeMainModel(
    this.states,
    this.msg,
    this.result,
  );

  factory HomeMainModel.fromJson(Map<String, dynamic> srcJson) =>
      _$HomeMainModelFromJson(srcJson);
}

@JsonSerializable()
class Result {
  @JsonKey(name: 'indexList')
  IndexList? indexList;

  @JsonKey(name: 'advertising')
  Advertising? advertising;

  @JsonKey(name: 'banner_international')
  List<BannerInternational?>? banner_international;

  @JsonKey(name: 'brandHall')
  List<BrandHall?>? brandHall;

  @JsonKey(name: 'newProduct_priorities')
  List<NewProductPriorities?>? newProduct_priorities;

  @JsonKey(name: 'worldHotProducts')
  List<WorldHotProducts?>? worldHotProducts;

  @JsonKey(name: 'kindSet')
  List<KindSetList?>? kindSet;

  @JsonKey(name: 'wsetIcon')
  String? wsetIcon;

  Result(this.indexList, this.advertising, this.banner_international,this.newProduct_priorities,this.wsetIcon);

  factory Result.fromJson(Map<String, dynamic> srcJson) =>
      _$ResultFromJson(srcJson);
}

@JsonSerializable()
class KindSetList {
  @JsonKey(name: 'kindName')
  String? kindName;

  @JsonKey(name: 'productInfoList')
  List<ProductInfoList?>? productInfoList;

  KindSetList(this.kindName, this.productInfoList,);

  factory KindSetList.fromJson(Map<String, dynamic> srcJson) =>
      _$KindSetListFromJson(srcJson);
}

@JsonSerializable()
class ProductInfoList {
  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'cname')
  String? cname;

  @JsonKey(name: 'picture')
  String? picture;

  @JsonKey(name: 'jnPrice')
  String? jnPrice;

  @JsonKey(name: 'parameter')
  String? parameter;

  ProductInfoList(
      this.productId,
      this.cname,
      this.picture,
      this.jnPrice,
      this.parameter);

  factory ProductInfoList.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductInfoListFromJson(srcJson);
}


@JsonSerializable()
class WorldHotProducts {
  @JsonKey(name: 'cname')
  String? cname;

  @JsonKey(name: 'ename')
  String? ename;

  @JsonKey(name: 'picture')
  String? picture;

  @JsonKey(name: 'jnPrice')
  double jnPrice;

  @JsonKey(name: 'countryName')
  String? countryName;

  @JsonKey(name: 'grade')
  String? grade;

  WorldHotProducts(
      this.cname,
      this.ename,
      this.picture,
      this.jnPrice,
      this.countryName,
      this.grade,
      );
  Map toJson() {
    Map map = {};
    map["cname"] = this.cname;
    map["ename"] = this.ename;
    map["picture"] = this.picture;
    map["jnPrice"] = this.jnPrice;
    map["countryName"] = this.countryName;
    map["grade"] = this.grade;
    return map;
  }
  factory WorldHotProducts.fromJson(Map<String, dynamic> srcJson) =>
      _$WorldHotProductsFromJson(srcJson);
}

@JsonSerializable()
class NewProductPriorities {
  @JsonKey(name: 'flag')
  String? flag;

  @JsonKey(name: 'productPic')
  String? productPic;

  @JsonKey(name: 'productName')
  String? productName;

  @JsonKey(name: 'startPrice')
  String startPrice;

  @JsonKey(name: 'endPrice')
  String endPrice;

  @JsonKey(name: 'maturityDate')
  String? maturityDate;

  NewProductPriorities(
    this.flag,
    this.productPic,
    this.productName,
    this.startPrice,
    this.endPrice,
    this.maturityDate,
  );

  factory NewProductPriorities.fromJson(Map<String, dynamic> srcJson) =>
      _$NewProductPrioritiesFromJson(srcJson);
}

@JsonSerializable()
class BrandHall {
  @JsonKey(name: 'appPictrueAddress')
  String? appPictrueAddress;

  BrandHall(this.appPictrueAddress,);

  factory BrandHall.fromJson(Map<String, dynamic> srcJson) =>
      _$BrandHallFromJson(srcJson);
}

@JsonSerializable()
class BannerInternational {
  @JsonKey(name: 'picture')
  String? picture;

  @JsonKey(name: 'indexName')
  String? indexName;

  BannerInternational(
    this.picture,
    this.indexName,
  );

  factory BannerInternational.fromJson(Map<String, dynamic> srcJson) =>
      _$BannerInternationalFromJson(srcJson);
}

@JsonSerializable()
class IndexList {
  @JsonKey(name: 'focus_picture')
  Focus_picture? focusPicture;

  @JsonKey(name: 'home_button')
  Home_button homeButton;

  @JsonKey(name: 'announcement')
  Announcement announcement;

  IndexList(
    this.focusPicture,
    this.homeButton,
    this.announcement,
  );

  factory IndexList.fromJson(Map<String, dynamic> srcJson) =>
      _$IndexListFromJson(srcJson);
}

@JsonSerializable()
class Advertising {
  @JsonKey(name: 'ranking')
  Ranking? ranking;

  @JsonKey(name: 'advertising_0')
  Advertising0? advertising_0;

  @JsonKey(name: 'advertising_1')
  Advertising0? advertising_1;


  @JsonKey(name: 'hotSellingRecommendation')
  String? hotSellingRecommendation;

  Advertising(this.ranking, this.advertising_0,this.advertising_1, this.hotSellingRecommendation);

  factory Advertising.fromJson(Map<String, dynamic> srcJson) =>
      _$AdvertisingFromJson(srcJson);
}

@JsonSerializable()
class Advertising0 {
  @JsonKey(name: 'parameter')
  String? parameter;

  @JsonKey(name: 'picture')
  String? picture;

  Advertising0(
    this.parameter,
    this.picture,
  );

  factory Advertising0.fromJson(Map<String, dynamic> srcJson) =>
      _$Advertising0FromJson(srcJson);
}

@JsonSerializable()
class Ranking {
  @JsonKey(name: 'parameter')
  String? parameter;

  @JsonKey(name: 'picture')
  String? picture;

  Ranking(
    this.parameter,
  );

  factory Ranking.fromJson(Map<String, dynamic> srcJson) =>
      _$RankingFromJson(srcJson);
}

@JsonSerializable()
class Focus_picture {
  @JsonKey(name: 'appNewIndexCategories')
  List<AppNewIndexCategories?> appNewIndexCategories;

  Focus_picture(
    this.appNewIndexCategories,
  );

  factory Focus_picture.fromJson(Map<String, dynamic> srcJson) =>
      _$Focus_pictureFromJson(srcJson);
}

@JsonSerializable()
class AppNewIndexCategories {
  @JsonKey(name: 'indexName')
  String? indexName;

  @JsonKey(name: 'picture')
  String? picture;

  @JsonKey(name: 'parameter')
  String? parameter;

  @JsonKey(name: 'urlType')
  int urlType;

  @JsonKey(name: 'appIndex')
  AppIndex? appIndex;

  AppNewIndexCategories(
    this.indexName,
    this.picture,
    this.parameter,
    this.urlType,
    this.appIndex,
  );

  factory AppNewIndexCategories.fromJson(Map<String, dynamic> srcJson) =>
      _$AppNewIndexCategoriesFromJson(srcJson);
}

@JsonSerializable()
class AppIndex {
  @JsonKey(name: 'cName')
  String? cName;

  AppIndex(
    this.cName,
  );

  factory AppIndex.fromJson(Map<String, dynamic> srcJson) =>
      _$AppIndexFromJson(srcJson);
}

@JsonSerializable()
class Home_button {
  @JsonKey(name: 'appNewIndexCategories')
  List<AppNewIndexCategories> appNewIndexCategories;

  Home_button(
    this.appNewIndexCategories,
  );

  factory Home_button.fromJson(Map<String, dynamic> srcJson) =>
      _$Home_buttonFromJson(srcJson);
}

@JsonSerializable()
class Announcement {
  @JsonKey(name: 'appNewIndexCategories')
  List<AppNewIndexCategories> appNewIndexCategories;

  Announcement(
    this.appNewIndexCategories,
  );

  factory Announcement.fromJson(Map<String, dynamic> srcJson) =>
      _$AnnouncementFromJson(srcJson);
}
