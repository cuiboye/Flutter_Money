import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/CustomWidgets/map_base_page_state.dart';

/// 推荐上车点
class ShowRecommendStopPage extends StatefulWidget {
  @override
  _ShowRecommendStopPageState createState() => _ShowRecommendStopPageState();
}

class _ShowRecommendStopPageState
    extends BMFBaseMapState<ShowRecommendStopPage> {
  BMFRecommendStopSearch recommendStopSearch = BMFRecommendStopSearch();
  List<BMFMarker> markers = [];
  String addressText = '';

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    /// 地图加载回调
    onRecommendStopSearch(null);

    /// 地图区域改变完成后会调用此接口
    /// mapStatus 地图状态信息
    myMapController.setMapRegionDidChangeWithReasonCallback(callback:
        (BMFMapStatus mapStatus, BMFRegionChangeReason regionChangeReason) {
      if (BMFRegionChangeReason.Gesture == regionChangeReason) {
        onRecommendStopSearch(mapStatus.targetGeoPt);
      }
    });

    /// 地图marker点击回调
    myMapController.setMapClickedMarkerCallback(
        callback: (BMFMarker bmfMarker) {
      for (BMFMarker marker in markers) {
        if (marker.id == bmfMarker.id) {
          print(marker.title);
          // myMapController
          //     .updateMapOptions(BMFMapOptions(center: marker.position));
          marker.updateIcon("resoures/icon_marker_selected.png");
          setState(() {
            addressText = marker.title ?? "";
          });
        } else {
          marker.updateIcon("resoures/icon_marker_unselected.png");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: BMFAppBar(
        title: "推荐上车点",
      ),
      body: Stack(
        children: [
          Align(
            child: generateMap(),
          ),
          Align(
            child: Image(
              alignment: Alignment.center,
              image: AssetImage("resoures/water_drop.png"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _bottomSearchBar(),
          ),
        ],
      ),
    );
  }

  void onRecommendStopSearch(BMFCoordinate? center) async {
    if (center == null) {
      center = BMFCoordinate(39.947689, 116.392196);
    }

    BMFRecommendStopSearchOption option = BMFRecommendStopSearchOption(
      location: center,
    );

    bool result = await recommendStopSearch.recommendStopSearch(option);
    print('result = $result');
    recommendStopSearch.onGetRecommendStopSearchResult(callback:
        (BMFRecommendStopSearchResult result, BMFSearchErrorCode errorCode) {
      if (errorCode != BMFSearchErrorCode.NO_ERROR) {
        myMapController.cleanAllMarkers();
        markers.clear();
        return;
      }
      List<BMFRecommendStopInfo>? recommendStopInfoList =
          result.recommendStopInfoList;
      if (recommendStopInfoList == null || recommendStopInfoList.length <= 0) {
        return;
      }
      onAddMarkerToMap(recommendStopInfoList);
    });
  }

  /// 设置地图参数
  @override
  BMFMapOptions initMapOptions() {
    BMFCoordinate center = BMFCoordinate(39.947689, 116.392196);
    BMFMapOptions mapOptions = BMFMapOptions(
      mapType: BMFMapType.Standard,
      zoomLevel: 18,
      maxZoomLevel: 21,
      minZoomLevel: 4,
      center: center,
      mapPadding: BMFEdgeInsets(top: 0, left: 50, right: 50, bottom: 120),
    );
    return mapOptions;
  }

  void onAddMarkerToMap(List<BMFRecommendStopInfo> infoList) {
    if (infoList.length == 0) {
      return;
    }

    myMapController.cleanAllMarkers();
    markers.clear();

    for (BMFRecommendStopInfo infoBean in infoList) {
      if (infoBean.location == null) {
        continue;
      }

      BMFMarker marker = new BMFMarker.icon(
        position: infoBean.location!,
        title: infoBean.name,
        icon: "resoures/icon_marker_unselected.png",
        canShowCallout: false,
      );
      markers.add(marker);
    }

    myMapController.addMarkers(markers);

    /// myMapController?.setCenterCoordinate(markers.first.position, true);
  }

  /// search bar
  Widget _bottomSearchBar() {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text("地址：" + addressText, textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
