import 'package:flutter/material.dart';
import 'package:flutter_money/map/CustomWidgets/map_appbar.dart';
import 'package:flutter_money/map/DemoPages/Utils/short_share_page.dart';

class MapCreateSharePage extends StatelessWidget {
  const MapCreateSharePage({Key? key}) : super(key: key);

  final String shareText =
      '\t\t短串分享是指，用户搜索查询后得到的每一个地理位置结果将会对应一条短串（短链接），用户可以通过短信、邮件或第三方分享组件（如微博、微信等）把短串分享给其他用户从而实现地理位置信息的分享。当其他用户收到分享的短串后，点击短串即可打开手机上的百度地图客户端或者手机浏览器进行查看。\n\n' +
          '\t\t例如，用户搜索“百度大厦”后通过短信使用短串分享功能把该地点分享给好友，好友点击短信中的短串“http://j.map.baidu.com/XLCrk”后可以调起百度地图客户端或者手机浏览器查看“百度大厦”的地理位置信息。\n\n' +
          '\t\t目前短串分享功能暂时开放了“POI搜索结果分享”、“反向地理编码结果分享”和“路线规划路线结果分享(包含步行、骑行、驾车、公交)”，日后会开放更多的功能，欢迎广大开发者使用短串分享功能。';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BMFAppBar(
        title: '短串分享',
        isBack: false,
      ),
      body: _shareText(context),
    );
  }

  Widget _shareText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 36.0, 10.0, 20.0),
      child: Column(
        /// mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(shareText, style: TextStyle(color: Colors.black, fontSize: 16)),
          Container(
            margin: const EdgeInsets.only(top: 32.0),
            child: ElevatedButton(
              child: Text('开始体验'),
              onPressed: () {
                print('点击开始体验按钮');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapSharePage()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
