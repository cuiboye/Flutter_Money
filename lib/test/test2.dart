import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money/view/custom_appbar.dart';
import 'package:flutter_money/view/custom_materialapp.dart';
import 'package:flutter_money/wajiu/constant/color.dart';

class Test2 extends StatelessWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        child: Scaffold(
          appBar: AppBar(
            title: Text('InheritedWidget Demo'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              WidgetA(),
              WidgetB(),
              WidgetC(),
            ],
          ),
        ),
      ),
    );
  }
}


class _MyInheritedWidget extends InheritedWidget {

  final HomePageState data;

  _MyInheritedWidget({ Key? key, required Widget child, required this.data }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_MyInheritedWidget oldWidget) {
    return true;
  }

}

class HomePage extends StatefulWidget {

  final Widget child;

  const HomePage({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

  static HomePageState? of(BuildContext context, {bool rebuild = true}) {
    if (rebuild) {
      return context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>()?.data;
    }
    return context.findAncestorWidgetOfExactType<_MyInheritedWidget>()?.data;
    //or
    //return (context.getElementForInheritedWidgetOfExactType<_MyInheritedWidget>().widget as _MyInheritedWidget).data;
  }
}

class HomePageState extends State<HomePage> {
  int counter = 0;

  void _incrementCounter() {
    print('HomePageState before _incrementCounter counter $counter');
    setState(() {
      counter++;
      print('HomePageState counter $counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}


class WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("WidgetA");
    final HomePageState? state = HomePage.of(context);

    return Center(
      child: Text(
        '${state?.counter}',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("WidgetB");

    return Text('I am a widget that will not be rebuilt.');
  }
}

class WidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("WidgetC");

    final HomePageState? state = HomePage.of(context, rebuild: false);

    return RaisedButton(
      onPressed: () {
        state?._incrementCounter();
      },
      child: Icon(Icons.add),
    );
  }
}
