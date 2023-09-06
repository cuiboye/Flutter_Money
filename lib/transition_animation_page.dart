

import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';

///Transition widgets 是一组 Flutter widgets，它们的名字都以Transition结尾。ScaleTransition、DecoratedBoxTransition、SizeTransition、 等等。
///他们和AnimatedPositioned很像，但有一个主要区别：这些 Transition 小部件是AnimatedWidget. 这使得它们成为明确的动画。
class TranstionAnimationPage extends StatefulWidget {
  const TranstionAnimationPage({super.key});

  @override
  State<TranstionAnimationPage> createState() => _TweenAnimationBuildPageState();
}

class _TweenAnimationBuildPageState extends State<TranstionAnimationPage> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context: context,title: 'Transtion Widget',),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (_animationController.isAnimating) {
                _animationController.stop();
              } else {
                _animationController.repeat();
              }
            },
            child: Container(color: Colors.black,width: 66,height: 66,),
          ),
         Center(
           child:  RotationTransition(
             alignment: Alignment.center,
             turns: _animationController,
             child:Text('HELLOWORLD'),
           ),
         )
        ],
      ),
    );
  }
}
