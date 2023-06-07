import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
  ValueBuilder 更像个小型的 StatefulWidget
  通过 updateFn 来更新数据
  自动更新value
*/
// typedef ValueBuilderUpdateCallback<T> = void Function(T snapshot);

class ValueBuilderView extends StatelessWidget {
  ValueBuilderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ValueBuilderView-build");
    return Scaffold(
      appBar: AppBar(
        title: Text("ValueBuilder"),
      ),
      body: Column(
        children: [
          Center(
            child: ValueBuilder<int?>(
              initialValue: 10,
              builder: (value, updateFn) {
                return Column(
                  children: [
                    Text("count -> " + value.toString()),
                    ElevatedButton(
                      onPressed: () {
                        updateFn(value! + 1);
                      },
                      child: Text('ValueBuilder -> add'),
                    )
                  ],
                );
              },
          
              // builder: (value, updateFn) => Switch(
              //   value: value,
              //   onChanged:
              //       updateFn, // same signature! you could use ( newValue ) => updateFn( newValue )
              // ),
              // if you need to call something outside the builder method.
              onUpdate: (value) => print("Value updated: $value"),
              onDispose: () => print("Widget unmounted"),
            ),
          ),
        ],
      ),
    );
  }
}
