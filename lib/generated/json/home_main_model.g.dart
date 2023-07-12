import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/home_main_model.dart';
import 'package:json_annotation/json_annotation.dart';


HomeMainModel $HomeMainModelFromJson(Map<String, dynamic> json) {
	final HomeMainModel homeMainModel = HomeMainModel();
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		homeMainModel.states = states;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		homeMainModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		homeMainModel.result = result;
	}
	return homeMainModel;
}

Map<String, dynamic> $HomeMainModelToJson(HomeMainModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['states'] = entity.states;
	data['msg'] = entity.msg;
	data['result'] = entity.result?.toJson();
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final IndexList? indexList = jsonConvert.convert<IndexList>(json['indexList']);
	if (indexList != null) {
		result.indexList = indexList;
	}
	final Advertising? advertising = jsonConvert.convert<Advertising>(json['advertising']);
	if (advertising != null) {
		result.advertising = advertising;
	}
	final List<BannerInternational?>? banner_international = jsonConvert.convertList<BannerInternational>(json['banner_international']);
	if (banner_international != null) {
		result.banner_international = banner_international;
	}
	final List<BrandHall?>? brandHall = jsonConvert.convertList<BrandHall>(json['brandHall']);
	if (brandHall != null) {
		result.brandHall = brandHall;
	}
	final List<NewProductPriorities?>? newProduct_priorities = jsonConvert.convertList<NewProductPriorities>(json['newProduct_priorities']);
	if (newProduct_priorities != null) {
		result.newProduct_priorities = newProduct_priorities;
	}
	final List<WorldHotProducts?>? worldHotProducts = jsonConvert.convertList<WorldHotProducts>(json['worldHotProducts']);
	if (worldHotProducts != null) {
		result.worldHotProducts = worldHotProducts;
	}
	final List<KindSetList?>? kindSet = jsonConvert.convertList<KindSetList>(json['kindSet']);
	if (kindSet != null) {
		result.kindSet = kindSet;
	}
	final String? wsetIcon = jsonConvert.convert<String>(json['wsetIcon']);
	if (wsetIcon != null) {
		result.wsetIcon = wsetIcon;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['indexList'] = entity.indexList?.toJson();
	data['advertising'] = entity.advertising?.toJson();
	data['banner_international'] =  entity.banner_international?.map((v) => v?.toJson()).toList();
	data['brandHall'] =  entity.brandHall?.map((v) => v?.toJson()).toList();
	data['newProduct_priorities'] =  entity.newProduct_priorities?.map((v) => v?.toJson()).toList();
	data['worldHotProducts'] =  entity.worldHotProducts?.map((v) => v?.toJson()).toList();
	data['kindSet'] =  entity.kindSet?.map((v) => v?.toJson()).toList();
	data['wsetIcon'] = entity.wsetIcon;
	return data;
}

KindSetList $KindSetListFromJson(Map<String, dynamic> json) {
	final KindSetList kindSetList = KindSetList();
	final String? kindName = jsonConvert.convert<String>(json['kindName']);
	if (kindName != null) {
		kindSetList.kindName = kindName;
	}
	final List<ProductInfoList?>? productInfoList = jsonConvert.convertList<ProductInfoList>(json['productInfoList']);
	if (productInfoList != null) {
		kindSetList.productInfoList = productInfoList;
	}
	return kindSetList;
}

Map<String, dynamic> $KindSetListToJson(KindSetList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['kindName'] = entity.kindName;
	data['productInfoList'] =  entity.productInfoList?.map((v) => v?.toJson()).toList();
	return data;
}

ProductInfoList $ProductInfoListFromJson(Map<String, dynamic> json) {
	final ProductInfoList productInfoList = ProductInfoList();
	final int? productId = jsonConvert.convert<int>(json['productId']);
	if (productId != null) {
		productInfoList.productId = productId;
	}
	final String? cname = jsonConvert.convert<String>(json['cname']);
	if (cname != null) {
		productInfoList.cname = cname;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		productInfoList.picture = picture;
	}
	final String? jnPrice = jsonConvert.convert<String>(json['jnPrice']);
	if (jnPrice != null) {
		productInfoList.jnPrice = jnPrice;
	}
	final String? parameter = jsonConvert.convert<String>(json['parameter']);
	if (parameter != null) {
		productInfoList.parameter = parameter;
	}
	return productInfoList;
}

Map<String, dynamic> $ProductInfoListToJson(ProductInfoList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['productId'] = entity.productId;
	data['cname'] = entity.cname;
	data['picture'] = entity.picture;
	data['jnPrice'] = entity.jnPrice;
	data['parameter'] = entity.parameter;
	return data;
}

WorldHotProducts $WorldHotProductsFromJson(Map<String, dynamic> json) {
	final WorldHotProducts worldHotProducts = WorldHotProducts();
	final String? cname = jsonConvert.convert<String>(json['cname']);
	if (cname != null) {
		worldHotProducts.cname = cname;
	}
	final String? ename = jsonConvert.convert<String>(json['ename']);
	if (ename != null) {
		worldHotProducts.ename = ename;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		worldHotProducts.picture = picture;
	}
	final double? jnPrice = jsonConvert.convert<double>(json['jnPrice']);
	if (jnPrice != null) {
		worldHotProducts.jnPrice = jnPrice;
	}
	final String? countryName = jsonConvert.convert<String>(json['countryName']);
	if (countryName != null) {
		worldHotProducts.countryName = countryName;
	}
	final String? grade = jsonConvert.convert<String>(json['grade']);
	if (grade != null) {
		worldHotProducts.grade = grade;
	}
	return worldHotProducts;
}

Map<String, dynamic> $WorldHotProductsToJson(WorldHotProducts entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cname'] = entity.cname;
	data['ename'] = entity.ename;
	data['picture'] = entity.picture;
	data['jnPrice'] = entity.jnPrice;
	data['countryName'] = entity.countryName;
	data['grade'] = entity.grade;
	return data;
}

NewProductPriorities $NewProductPrioritiesFromJson(Map<String, dynamic> json) {
	final NewProductPriorities newProductPriorities = NewProductPriorities();
	final String? flag = jsonConvert.convert<String>(json['flag']);
	if (flag != null) {
		newProductPriorities.flag = flag;
	}
	final String? productPic = jsonConvert.convert<String>(json['productPic']);
	if (productPic != null) {
		newProductPriorities.productPic = productPic;
	}
	final String? productName = jsonConvert.convert<String>(json['productName']);
	if (productName != null) {
		newProductPriorities.productName = productName;
	}
	final String? startPrice = jsonConvert.convert<String>(json['startPrice']);
	if (startPrice != null) {
		newProductPriorities.startPrice = startPrice;
	}
	final String? endPrice = jsonConvert.convert<String>(json['endPrice']);
	if (endPrice != null) {
		newProductPriorities.endPrice = endPrice;
	}
	final String? maturityDate = jsonConvert.convert<String>(json['maturityDate']);
	if (maturityDate != null) {
		newProductPriorities.maturityDate = maturityDate;
	}
	return newProductPriorities;
}

Map<String, dynamic> $NewProductPrioritiesToJson(NewProductPriorities entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['flag'] = entity.flag;
	data['productPic'] = entity.productPic;
	data['productName'] = entity.productName;
	data['startPrice'] = entity.startPrice;
	data['endPrice'] = entity.endPrice;
	data['maturityDate'] = entity.maturityDate;
	return data;
}

BrandHall $BrandHallFromJson(Map<String, dynamic> json) {
	final BrandHall brandHall = BrandHall();
	final String? appPictrueAddress = jsonConvert.convert<String>(json['appPictrueAddress']);
	if (appPictrueAddress != null) {
		brandHall.appPictrueAddress = appPictrueAddress;
	}
	return brandHall;
}

Map<String, dynamic> $BrandHallToJson(BrandHall entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['appPictrueAddress'] = entity.appPictrueAddress;
	return data;
}

BannerInternational $BannerInternationalFromJson(Map<String, dynamic> json) {
	final BannerInternational bannerInternational = BannerInternational();
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		bannerInternational.picture = picture;
	}
	final String? indexName = jsonConvert.convert<String>(json['indexName']);
	if (indexName != null) {
		bannerInternational.indexName = indexName;
	}
	return bannerInternational;
}

Map<String, dynamic> $BannerInternationalToJson(BannerInternational entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['picture'] = entity.picture;
	data['indexName'] = entity.indexName;
	return data;
}

IndexList $IndexListFromJson(Map<String, dynamic> json) {
	final IndexList indexList = IndexList();
	final Focus_picture? focusPicture = jsonConvert.convert<Focus_picture>(json['focusPicture']);
	if (focusPicture != null) {
		indexList.focusPicture = focusPicture;
	}
	final Home_button? homeButton = jsonConvert.convert<Home_button>(json['homeButton']);
	if (homeButton != null) {
		indexList.homeButton = homeButton;
	}
	final Announcement? announcement = jsonConvert.convert<Announcement>(json['announcement']);
	if (announcement != null) {
		indexList.announcement = announcement;
	}
	return indexList;
}

Map<String, dynamic> $IndexListToJson(IndexList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['focusPicture'] = entity.focusPicture?.toJson();
	data['homeButton'] = entity.homeButton?.toJson();
	data['announcement'] = entity.announcement?.toJson();
	return data;
}

Advertising $AdvertisingFromJson(Map<String, dynamic> json) {
	final Advertising advertising = Advertising();
	final Ranking? ranking = jsonConvert.convert<Ranking>(json['ranking']);
	if (ranking != null) {
		advertising.ranking = ranking;
	}
	final Advertising0? advertising_0 = jsonConvert.convert<Advertising0>(json['advertising_0']);
	if (advertising_0 != null) {
		advertising.advertising_0 = advertising_0;
	}
	final Advertising0? advertising_1 = jsonConvert.convert<Advertising0>(json['advertising_1']);
	if (advertising_1 != null) {
		advertising.advertising_1 = advertising_1;
	}
	final String? hotSellingRecommendation = jsonConvert.convert<String>(json['hotSellingRecommendation']);
	if (hotSellingRecommendation != null) {
		advertising.hotSellingRecommendation = hotSellingRecommendation;
	}
	return advertising;
}

Map<String, dynamic> $AdvertisingToJson(Advertising entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['ranking'] = entity.ranking?.toJson();
	data['advertising_0'] = entity.advertising_0?.toJson();
	data['advertising_1'] = entity.advertising_1?.toJson();
	data['hotSellingRecommendation'] = entity.hotSellingRecommendation;
	return data;
}

Advertising0 $Advertising0FromJson(Map<String, dynamic> json) {
	final Advertising0 advertising0 = Advertising0();
	final String? parameter = jsonConvert.convert<String>(json['parameter']);
	if (parameter != null) {
		advertising0.parameter = parameter;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		advertising0.picture = picture;
	}
	return advertising0;
}

Map<String, dynamic> $Advertising0ToJson(Advertising0 entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['parameter'] = entity.parameter;
	data['picture'] = entity.picture;
	return data;
}

Ranking $RankingFromJson(Map<String, dynamic> json) {
	final Ranking ranking = Ranking();
	final String? parameter = jsonConvert.convert<String>(json['parameter']);
	if (parameter != null) {
		ranking.parameter = parameter;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		ranking.picture = picture;
	}
	return ranking;
}

Map<String, dynamic> $RankingToJson(Ranking entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['parameter'] = entity.parameter;
	data['picture'] = entity.picture;
	return data;
}

Focus_picture $Focus_pictureFromJson(Map<String, dynamic> json) {
	final Focus_picture focus_picture = Focus_picture();
	final List<AppNewIndexCategories?>? appNewIndexCategories = jsonConvert.convertList<AppNewIndexCategories>(json['appNewIndexCategories']);
	if (appNewIndexCategories != null) {
		focus_picture.appNewIndexCategories = appNewIndexCategories;
	}
	return focus_picture;
}

Map<String, dynamic> $Focus_pictureToJson(Focus_picture entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['appNewIndexCategories'] =  entity.appNewIndexCategories?.map((v) => v?.toJson()).toList();
	return data;
}

AppNewIndexCategories $AppNewIndexCategoriesFromJson(Map<String, dynamic> json) {
	final AppNewIndexCategories appNewIndexCategories = AppNewIndexCategories();
	final String? indexName = jsonConvert.convert<String>(json['indexName']);
	if (indexName != null) {
		appNewIndexCategories.indexName = indexName;
	}
	final String? picture = jsonConvert.convert<String>(json['picture']);
	if (picture != null) {
		appNewIndexCategories.picture = picture;
	}
	final String? parameter = jsonConvert.convert<String>(json['parameter']);
	if (parameter != null) {
		appNewIndexCategories.parameter = parameter;
	}
	final int? urlType = jsonConvert.convert<int>(json['urlType']);
	if (urlType != null) {
		appNewIndexCategories.urlType = urlType;
	}
	final AppIndex? appIndex = jsonConvert.convert<AppIndex>(json['appIndex']);
	if (appIndex != null) {
		appNewIndexCategories.appIndex = appIndex;
	}
	return appNewIndexCategories;
}

Map<String, dynamic> $AppNewIndexCategoriesToJson(AppNewIndexCategories entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['indexName'] = entity.indexName;
	data['picture'] = entity.picture;
	data['parameter'] = entity.parameter;
	data['urlType'] = entity.urlType;
	data['appIndex'] = entity.appIndex?.toJson();
	return data;
}

AppIndex $AppIndexFromJson(Map<String, dynamic> json) {
	final AppIndex appIndex = AppIndex();
	final String? cName = jsonConvert.convert<String>(json['cName']);
	if (cName != null) {
		appIndex.cName = cName;
	}
	return appIndex;
}

Map<String, dynamic> $AppIndexToJson(AppIndex entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cName'] = entity.cName;
	return data;
}

Home_button $Home_buttonFromJson(Map<String, dynamic> json) {
	final Home_button home_button = Home_button();
	final List<AppNewIndexCategories>? appNewIndexCategories = jsonConvert.convertListNotNull<AppNewIndexCategories>(json['appNewIndexCategories']);
	if (appNewIndexCategories != null) {
		home_button.appNewIndexCategories = appNewIndexCategories;
	}
	return home_button;
}

Map<String, dynamic> $Home_buttonToJson(Home_button entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['appNewIndexCategories'] =  entity.appNewIndexCategories?.map((v) => v.toJson()).toList();
	return data;
}

Announcement $AnnouncementFromJson(Map<String, dynamic> json) {
	final Announcement announcement = Announcement();
	final List<AppNewIndexCategories>? appNewIndexCategories = jsonConvert.convertListNotNull<AppNewIndexCategories>(json['appNewIndexCategories']);
	if (appNewIndexCategories != null) {
		announcement.appNewIndexCategories = appNewIndexCategories;
	}
	return announcement;
}

Map<String, dynamic> $AnnouncementToJson(Announcement entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['appNewIndexCategories'] =  entity.appNewIndexCategories?.map((v) => v.toJson()).toList();
	return data;
}