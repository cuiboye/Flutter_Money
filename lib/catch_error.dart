
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 异常处理
 */
//一个[ListTile]  可以设置为滚动的弹出框列表
class CatchError extends StatelessWidget {
  const CatchError({
    this.label,
    this.value,
    this.items,
    this.onChanged,
  });

  final String? label;
  final String? value;
  final List<String>? items;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final int? indexOfValue = items?.indexOf(value!);
    assert(indexOfValue != -1);

    final bool canIncrease = indexOfValue! < ((items?.length)??0) - 1;
    final bool canDecrease = indexOfValue > 0;

    return Semantics(
      container: true,
      label: label,
      value: value,
      increasedValue: canIncrease ? _increasedValue : null,
      decreasedValue: canDecrease ? _decreasedValue : null,
      onIncrease: canIncrease ? _performIncrease : null,
      onDecrease: canDecrease ? _performDecrease : null,
      child: ExcludeSemantics(
        child: ListTile(
          title: Text(label!),
          trailing: DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            items: items?.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  String get _increasedValue {
    final int? indexOfValue = items?.indexOf(value!);
    return items![indexOfValue! + 1];
  }

  String get _decreasedValue {
    final int? indexOfValue = items?.indexOf(value!);
    assert(indexOfValue! > 0);
    return items![indexOfValue! - 1];
  }

  void _performIncrease() => onChanged!(_increasedValue);

  void _performDecrease() => onChanged!(_decreasedValue);
}

class AdjustableDropdownExample extends StatefulWidget {
  @override
  AdjustableDropdownExampleState createState() => AdjustableDropdownExampleState();
}

class AdjustableDropdownExampleState extends State<AdjustableDropdownExample> {

  final List<String> items = <String>[
    '1 second',
    '5 seconds',
    '15 seconds',
    '30 seconds',
    '1 minute',
    '2 minute',
    '3 minute',
    '11 minute',
    '12 minute',
    '13 minute',
    '143 minute',
    '15 minute',
    '16 minute',
//    '3 minute',//这个列表中不能有两个相同的item，否则会报错
  ];
  late String timeout;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Adjustable DropDown'),
        ),
        body: ListView(

          children: <Widget>[
            CatchError(
              label: 'Timeout',
              value: timeout==null ? items[2]:timeout,
              items: items,
              onChanged: (String? value) {
                setState(() {
                  timeout = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}