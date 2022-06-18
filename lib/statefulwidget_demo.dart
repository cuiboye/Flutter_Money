import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

/**
 * StatefulWidget组件的使用
 *
 */
class StatefulWidgetDemo extends StatefulWidget {
  @override
  _StatefulWidgetDemoState createState() => _StatefulWidgetDemoState();
}

class _StatefulWidgetDemoState extends State<StatefulWidgetDemo> {
  int mCurrentSelectedIndex = 0;
  String afterRefreshContent = "";
  // final Dio _dio = Dio();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "StatefulWidget组件的使用",
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("StatefulWidget组件的使用"),
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back)
          ),
        ),
        body:mCurrentSelectedIndex==0?
        RefreshIndicator(//RefreshIndicator和ListView一起使用才会生效
            onRefresh: _handleRefresh,
            child:ListView(
              children: [
                Text("1"+afterRefreshContent),
                Image.network(//加载网络图片
                    "https://img2.woyaogexing.com/2022/06/14/a6242dfe2ee9ccaa!400x400.jpg",
                  width: 200,
                  height: 200
                ),
                TextField(//输入文本的样式
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "请输入内容",
                    hintStyle: TextStyle(fontSize: 15,color: ColorUtil.color("#ff0000"))
                  ),
                  minLines: 2,//最小行数
                  maxLines: 10,//最大行数
                ),
              ],
            )
        ):Container(
          height: 100,//设置容器大小
          child: Column(
            children: [
              PageView(
                children: [
                  _item("页面1",Colors.black),
                  _item("页面2",Colors.blue),
                  _item("页面3",Colors.orange)
                ],
              ),
              // FutureBuilder(
              //     future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //       //请求完成
              //       if (snapshot.connectionState == ConnectionState.done) {
              //         Response response = snapshot.data;
              //         //发生错误
              //         if (snapshot.hasError) {
              //           return Text(snapshot.error.toString());
              //         }
              //         //请求成功，通过项目信息构建用于显示项目名称的ListView
              //         return ListView(
              //           children: response.data
              //               .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
              //               .toList(),
              //         );
              //       }
              //       return Text(snapshot.error.toString());
              //     }),
            ],
          )
        ),

          floatingActionButton: FloatingActionButton( //floatingActionButton悬浮在右下角的按钮
          onPressed: () => _floatingActionButtonPress(),
          child: const Text("点击"),
        ),
        bottomNavigationBar: BottomNavigationBar( //底部的tab标签
          currentIndex: mCurrentSelectedIndex,//当前选中的下标
          onTap: (index) => _bottomNavigationBar(index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color:Colors.grey),
                activeIcon: Icon(Icons.home, color:Colors.red),
                label: "首页"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list, color: Colors.grey),
                activeIcon: Icon(Icons.list, color: Colors.red),
                label: "列表"
            )
          ],
        ),
      ),
    );
  }

  _item(String title,Color color){
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(
        title,
        style: TextStyle(color: Colors.white,fontSize: 12)
      ),
    );
  }

  _floatingActionButtonPress() {
    print("_floatingActionButtonPress");
  }

  _bottomNavigationBar(int index) {
    setState(() {
      mCurrentSelectedIndex = index;
    });
    print("_bottomNavigationBar");
  }

  Future<void> _handleRefresh() async {
    try{
      await Future.delayed(
          const Duration(milliseconds: 200)
      );
      setState(() {
        afterRefreshContent = "刷新了";
      });
    }catch(e){

    }
    return;
  }
}
