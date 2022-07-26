import 'package:flutter/material.dart';
import 'package:flutter_money/provide/change_notifier_provider_example/next_page.dart';
import 'package:flutter_money/provide/change_notifier_provider_example/user_model1.dart';
import 'package:provider/provider.dart';

class ChangeNotifierProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChangeNotifierProvider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserModel1>(
              builder: (_, userModel, child) {
                return Column(
                  children: [
                    Text(userModel.name,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 30
                        ),
                    ),
                    // Text("userModel的name发生变化时，这个Text也会被重新创建"),
                    child!//这里设置child,也就是下面的child:Text()将不会被重新构建
                  ],
                );
              },
              child: Text("userModel的name发生变化时，这个Text将不会被重新创建"),
            ),
            Consumer<UserModel1>(
              builder: (_, userModel, child) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: (){
                      userModel.changeName();
                    },
                    child: Text("改变值"),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => NextPage()));
                },
                child: Text("跳转到下一个页面"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
