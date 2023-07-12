class WajiuProductListNewModel2 {
  final Result? result;
  final int? states;
  final String? msg;

  WajiuProductListNewModel2({
    required this.result,
    required this.states,
    required this.msg,
  });

  factory WajiuProductListNewModel2.fromJson(Map<String, dynamic> json) {
    print("444411");

    return WajiuProductListNewModel2(
      result: Result.fromJson(json['result']), //对象需要这样设置来取值
      states: json['states'],
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "result": result?.toJson(),
    "states": states,
  };
}

class Result {
  List<DeliveryList>? delivery = [];

  Result({
    required this.delivery,
  });

  //List数据赋值步骤：
  //1）
  factory Result.fromJson(Map<String, dynamic> json) {
    if( json==null || json.isEmpty ){
      return Result(delivery: []);
    }
    print("4444");
    print("$json");
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
  List<OrdersList>? orders = [];

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
  final String? unionOrderNumber;

  OrdersList({
    required this.unionOrderNumber,
  });

  factory OrdersList.fromJson(Map<String, dynamic> json) {
    return OrdersList(
      unionOrderNumber: json['unionOrderNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        "unionOrderNumber": unionOrderNumber,
      };
}