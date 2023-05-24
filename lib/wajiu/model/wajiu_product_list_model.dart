class WajiuProductListModel {
  final Result? result;
  final int states;
  final String msg;

  WajiuProductListModel({
    required this.result,
    required this.states,
    required this.msg,
  });

  factory WajiuProductListModel.fromJson(Map<String, dynamic> json) {
    return WajiuProductListModel(
      result: Result.fromJson(json['result']), //对象需要这样设置来取值
      states: json['states'],
      msg: json['msg'],
    );
  }
}

class Result {
  List<ProductList> productList = [];

  Result({
    required this.productList,
  });

  //List数据赋值步骤：
  //1）
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      productList: List<ProductList>.from(
          json["productList"].map((x) => ProductList.fromJson(x))),
    );
  }

  //2）
  Map<String, dynamic> toJson() => {
        "productList": List<dynamic>.from(productList.map((x) => x.toJson())),
      };
}

class ProductList {
  final String? cname;
  final String? ename;
  final String? countryName;
  final String? priceDesc;
  final String? grade;
  final String? picture;
   List<dynamic> productMarksImg = [];

  ProductList({
    required  this.cname,
    required  this.ename,
    required  this.countryName,
    required  this.priceDesc,
    required this.grade,
    required this.picture,
     required this.productMarksImg,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      cname: json['cname'],
      ename: json['ename'],
      countryName: json['countryName'],
      grade: json['grade'],
      priceDesc: json['priceDesc'],
      picture: json['picture'],
      productMarksImg: json['productMarksImg'],//取List<String>类型的数据
    );
  }

  Map<String, dynamic> toJson() => {
        "cname": cname,
        "ename": ename,
        "countryName": countryName,
        "grade": grade,
        "picture": picture,
        "productMarksImg":productMarksImg,//取List<String>类型的数据
      };
}
