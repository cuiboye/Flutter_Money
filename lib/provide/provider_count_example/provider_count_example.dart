import 'package:flutter/material.dart';
import 'package:flutter_money/provide/provider_count_example/count_notifier.dart';
import 'package:provider/provider.dart';


class ProviderCountExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CountNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("ProviderCount"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          counter.increment();
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        //这里是子节点，当点击按钮后这里会进行刷新
        child: Text(counter.count.toString(),
          style: TextStyle(
              color: Colors.red,
              fontSize: 50
          ),
        ),
      ),
    );
  }
}
