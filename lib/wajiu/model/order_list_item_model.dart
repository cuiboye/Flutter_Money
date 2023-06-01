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
  List<DeliveryList> delivery = [];
  Result({
    required this.delivery,
  });

  //List数据赋值步骤：
  //1）
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      delivery: List<DeliveryList>.from(
          json["delivery"].map((x) => DeliveryList.fromJson(x))),
    );
  }

  //2）
  Map<String, dynamic> toJson() => {
        "delivery": List<dynamic>.from(delivery.map((x) => x.toJson())),
      };
}

class DeliveryList {
  List<OrdersList> orders = [];

  DeliveryList({
    required this.orders,
  });

  //List数据赋值步骤：
  //1）
  factory DeliveryList.fromJson(Map<String, dynamic> json) {
    return DeliveryList(
      orders: List<OrdersList>.from(
          json["orders"].map((x) => OrdersList.fromJson(x))),
    );
  }

  //2）
  Map<String, dynamic> toJson() => {
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class OrdersList {
  final String? orderNumber;

  OrdersList({
    required  this.orderNumber,
  });

  factory OrdersList.fromJson(Map<String, dynamic> json) {
    return OrdersList(
      orderNumber: json['orderNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
    "orderNumber": orderNumber,
  };
}
