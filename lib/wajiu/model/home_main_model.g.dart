// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_main_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeMainModel _$HomeMainModelFromJson(Map<String, dynamic> json) =>
    HomeMainModel(
      json['states'] as int?,
      json['msg'] as String?,
      json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeMainModelToJson(HomeMainModel instance) =>
    <String, dynamic>{
      'states': instance.states,
      'msg': instance.msg,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      json['indexList'] == null
          ? null
          : IndexList.fromJson(json['indexList'] as Map<String, dynamic>),
      json['advertising'] == null
          ? null
          : Advertising.fromJson(json['advertising'] as Map<String, dynamic>),
      (json['banner_international'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BannerInternational.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['newProduct_priorities'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : NewProductPriorities.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['wsetIcon'] as String?,
    )
      ..brandHall = (json['brandHall'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : BrandHall.fromJson(e as Map<String, dynamic>))
          .toList()
      ..worldHotProducts = (json['worldHotProducts'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : WorldHotProducts.fromJson(e as Map<String, dynamic>))
          .toList()
      ..kindSet = (json['kindSet'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : KindSetList.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'indexList': instance.indexList,
      'advertising': instance.advertising,
      'banner_international': instance.banner_international,
      'brandHall': instance.brandHall,
      'newProduct_priorities': instance.newProduct_priorities,
      'worldHotProducts': instance.worldHotProducts,
      'kindSet': instance.kindSet,
      'wsetIcon': instance.wsetIcon,
    };

KindSetList _$KindSetListFromJson(Map<String, dynamic> json) => KindSetList(
      json['kindName'] as String?,
      (json['productInfoList'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ProductInfoList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KindSetListToJson(KindSetList instance) =>
    <String, dynamic>{
      'kindName': instance.kindName,
      'productInfoList': instance.productInfoList,
    };

ProductInfoList _$ProductInfoListFromJson(Map<String, dynamic> json) =>
    ProductInfoList(
      json['productId'] as int?,
      json['cname'] as String?,
      json['picture'] as String?,
      json['jnPrice'] as String?,
      json['parameter'] as String?,
    );

Map<String, dynamic> _$ProductInfoListToJson(ProductInfoList instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'cname': instance.cname,
      'picture': instance.picture,
      'jnPrice': instance.jnPrice,
      'parameter': instance.parameter,
    };

WorldHotProducts _$WorldHotProductsFromJson(Map<String, dynamic> json) =>
    WorldHotProducts(
      json['cname'] as String?,
      json['ename'] as String?,
      json['picture'] as String?,
      (json['jnPrice'] as num?)?.toDouble(),
      json['countryName'] as String?,
      json['grade'] as String?,
    );

Map<String, dynamic> _$WorldHotProductsToJson(WorldHotProducts instance) =>
    <String, dynamic>{
      'cname': instance.cname,
      'ename': instance.ename,
      'picture': instance.picture,
      'jnPrice': instance.jnPrice,
      'countryName': instance.countryName,
      'grade': instance.grade,
    };

NewProductPriorities _$NewProductPrioritiesFromJson(
        Map<String, dynamic> json) =>
    NewProductPriorities(
      json['flag'] as String?,
      json['productPic'] as String?,
      json['productName'] as String?,
      json['startPrice'] as String?,
      json['endPrice'] as String?,
      json['maturityDate'] as String?,
    );

Map<String, dynamic> _$NewProductPrioritiesToJson(
        NewProductPriorities instance) =>
    <String, dynamic>{
      'flag': instance.flag,
      'productPic': instance.productPic,
      'productName': instance.productName,
      'startPrice': instance.startPrice,
      'endPrice': instance.endPrice,
      'maturityDate': instance.maturityDate,
    };

BrandHall _$BrandHallFromJson(Map<String, dynamic> json) => BrandHall(
      json['appPictrueAddress'] as String?,
    );

Map<String, dynamic> _$BrandHallToJson(BrandHall instance) => <String, dynamic>{
      'appPictrueAddress': instance.appPictrueAddress,
    };

BannerInternational _$BannerInternationalFromJson(Map<String, dynamic> json) =>
    BannerInternational(
      json['picture'] as String?,
      json['indexName'] as String?,
    );

Map<String, dynamic> _$BannerInternationalToJson(
        BannerInternational instance) =>
    <String, dynamic>{
      'picture': instance.picture,
      'indexName': instance.indexName,
    };

IndexList _$IndexListFromJson(Map<String, dynamic> json) => IndexList(
      json['focus_picture'] == null
          ? null
          : Focus_picture.fromJson(
              json['focus_picture'] as Map<String, dynamic>),
      json['home_button'] == null
          ? null
          : Home_button.fromJson(json['home_button'] as Map<String, dynamic>),
      json['announcement'] == null
          ? null
          : Announcement.fromJson(json['announcement'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndexListToJson(IndexList instance) => <String, dynamic>{
      'focus_picture': instance.focusPicture,
      'home_button': instance.homeButton,
      'announcement': instance.announcement,
    };

Advertising _$AdvertisingFromJson(Map<String, dynamic> json) => Advertising(
      json['ranking'] == null
          ? null
          : Ranking.fromJson(json['ranking'] as Map<String, dynamic>),
      json['advertising_0'] == null
          ? null
          : Advertising0.fromJson(
              json['advertising_0'] as Map<String, dynamic>),
      json['advertising_1'] == null
          ? null
          : Advertising0.fromJson(
              json['advertising_1'] as Map<String, dynamic>),
      json['hotSellingRecommendation'] as String?,
    );

Map<String, dynamic> _$AdvertisingToJson(Advertising instance) =>
    <String, dynamic>{
      'ranking': instance.ranking,
      'advertising_0': instance.advertising_0,
      'advertising_1': instance.advertising_1,
      'hotSellingRecommendation': instance.hotSellingRecommendation,
    };

Advertising0 _$Advertising0FromJson(Map<String, dynamic> json) => Advertising0(
      json['parameter'] as String?,
      json['picture'] as String?,
    );

Map<String, dynamic> _$Advertising0ToJson(Advertising0 instance) =>
    <String, dynamic>{
      'parameter': instance.parameter,
      'picture': instance.picture,
    };

Ranking _$RankingFromJson(Map<String, dynamic> json) => Ranking(
      json['parameter'] as String?,
    )..picture = json['picture'] as String?;

Map<String, dynamic> _$RankingToJson(Ranking instance) => <String, dynamic>{
      'parameter': instance.parameter,
      'picture': instance.picture,
    };

Focus_picture _$Focus_pictureFromJson(Map<String, dynamic> json) =>
    Focus_picture(
      (json['appNewIndexCategories'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : AppNewIndexCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$Focus_pictureToJson(Focus_picture instance) =>
    <String, dynamic>{
      'appNewIndexCategories': instance.appNewIndexCategories,
    };

AppNewIndexCategories _$AppNewIndexCategoriesFromJson(
        Map<String, dynamic> json) =>
    AppNewIndexCategories(
      json['indexName'] as String?,
      json['picture'] as String?,
      json['parameter'] as String?,
      json['urlType'] as int?,
      json['appIndex'] == null
          ? null
          : AppIndex.fromJson(json['appIndex'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppNewIndexCategoriesToJson(
        AppNewIndexCategories instance) =>
    <String, dynamic>{
      'indexName': instance.indexName,
      'picture': instance.picture,
      'parameter': instance.parameter,
      'urlType': instance.urlType,
      'appIndex': instance.appIndex,
    };

AppIndex _$AppIndexFromJson(Map<String, dynamic> json) => AppIndex(
      json['cName'] as String?,
    );

Map<String, dynamic> _$AppIndexToJson(AppIndex instance) => <String, dynamic>{
      'cName': instance.cName,
    };

Home_button _$Home_buttonFromJson(Map<String, dynamic> json) => Home_button(
      (json['appNewIndexCategories'] as List<dynamic>?)
          ?.map(
              (e) => AppNewIndexCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$Home_buttonToJson(Home_button instance) =>
    <String, dynamic>{
      'appNewIndexCategories': instance.appNewIndexCategories,
    };

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
      (json['appNewIndexCategories'] as List<dynamic>?)
          ?.map(
              (e) => AppNewIndexCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'appNewIndexCategories': instance.appNewIndexCategories,
    };
