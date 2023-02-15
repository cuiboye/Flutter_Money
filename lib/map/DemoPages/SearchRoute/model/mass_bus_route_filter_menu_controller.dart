import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';

class MassBusRouteFilterMenuController {
  /// 市内公交换乘策略，可选，
  ///
  /// 默认使用BMFMassTransitIncityPolicy.RECOMMEND
  BMFMassTransitIncityPolicy? incityPolicy;

  /// 跨城公交换乘策略，可选，
  ///
  /// 默认使用BMFMassTransitIntercityPolicy.TIME_FIRST
  BMFMassTransitIntercityPolicy? intercityPolicy;

  /// 跨城交通方式策略，可选，
  ///
  /// 默认使用BMK_MASS_TRANSIT_INTERCITY_TRANS_TRAIN_FIRST
  BMFMassTransitIntercityTransPolicy? intercityTransPolicy;
}