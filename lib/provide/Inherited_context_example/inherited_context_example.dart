import 'package:flutter/material.dart';
import 'package:flutter_money/provide/Inherited_context_example/count_notifier2.dart';
import 'package:provider/provider.dart';


class InheritedContextExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('执行了 build 方法');

    final countWatchNotifier = context.watch<CountNotifier2>();
    //
    //
    final count = context.select((CountNotifier2 countNotifier2) => countNotifier2.count);

    //通过 Provider.of 获取值
    final countProvider  = Provider.of<CountNotifier2>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("InheritedContextExample"),
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(Provider.of<CountNotifier2>(context, listen: false).count.toString(),
      //         style: const TextStyle(
      //             color: Colors.red,
      //             fontSize: 50
      //         ),
      //       ),
      //
      //       Padding(
      //         padding: const EdgeInsets.only(top: 20),
      //         child: ElevatedButton(
      //           onPressed: () => countProvider.increment(),
      //           child: const Text("点击加1"),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      //read（）就是调用了Provider.of(this,listen: false);
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${context.read<CountNotifier2>().count.toString()}",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 50
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () => Provider.of<CountNotifier2>(context, listen: false).increment(),
                child: Text("点击加1"),
              ),
            ),
          ],
        ),
      ),

      /// Consumer 获取值
      // body: Center(
      //   child: Consumer<CountNotifier2>(
      //     builder: (_, countNotifier2, child) {
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text(countNotifier2.count.toString(),
      //             style: TextStyle(
      //                 color: Colors.red,
      //                 fontSize: 50
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(top: 20),
      //             child: ElevatedButton(
      //               onPressed: () => countNotifier2.increment(),
      //               child: Text("点击加1"),
      //             ),
      //           ),
      //         ],
      //       );
      //     },
      //   ),
      // ),

      /// watch
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(countWatchNotifier.count.toString(),
      //         style: TextStyle(
      //             color: Colors.red,
      //             fontSize: 50
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.only(top: 20),
      //         child: ElevatedButton(
      //           onPressed: () => countWatchNotifier.increment(),
      //           child: Text("点击加1"),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      /// Selector
      // body: Center(
      //   child: Selector<CountNotifier2, int>(
      //     selector: (_, countNotifier2) => countNotifier2.count,
      //     builder: (_, count, child) {
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text(count.toString(),
      //             style: TextStyle(
      //                 color: Colors.red,
      //                 fontSize: 50
      //             ),
      //           ),
      //           child!
      //         ],
      //       );
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.only(top: 20),
      //       child: ElevatedButton(
      //         onPressed: () => Provider.of<CountNotifier2>(context, listen: false).increment(),
      //         child: Text("点击加1"),
      //       ),
      //     ),
      //   ),
      // ),

      /// select
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(count.toString(),
      //         style: TextStyle(
      //             color: Colors.red,
      //             fontSize: 50
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.only(top: 20),
      //         child: ElevatedButton(
      //           onPressed: () => Provider.of<CountNotifier2>(context, listen: false).increment(),
      //           child: Text("点击加1"),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
