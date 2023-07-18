import 'package:flutter/material.dart';
import 'package:flutter_money/provide/provider_example/user_model.dart';
import 'package:provider/provider.dart';

class ProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("ProviderExample"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Container(
             child:  Consumer<UserModel>(
               builder: (_, userModel, child) {
                 return Text(userModel.name,
                     style: TextStyle(
                         color: Colors.red,
                         fontSize: 30
                     )
                 );
               },
             ),
             height: 60,

           ),
            Container(
              height: 60,
              child: Consumer<UserModel>(
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
            )
          ],
        ),
      ),
    );
  }
}
