import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';

///Transition widgets 是一组 Flutter widgets，它们的名字都以Transition结尾。ScaleTransition、DecoratedBoxTransition、SizeTransition、 等等。
///他们和AnimatedPositioned很像，但有一个主要区别：这些 Transition 小部件是AnimatedWidget. 这使得它们成为明确的动画。
class TranstionAnimationPage extends StatefulWidget {
  const TranstionAnimationPage({super.key});

  @override
  State<TranstionAnimationPage> createState() =>
      _TweenAnimationBuildPageState();
}

class _TweenAnimationBuildPageState extends State<TranstionAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationController2;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );

    _animationController2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animation = CurvedAnimation(
        parent: _animationController2, curve: Curves.fastOutSlowIn);
    return Scaffold(
      appBar: CustomAppbar(
        context: context,
        title: 'Transtion Widget',
      ),
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
            child: Container(
              color: Colors.black,
              width: 66,
              height: 66,
            ),
          ),
          Center(
            child: Column(
              children: [
                RotationTransition(
                  //旋转动画
                  alignment: Alignment.center,
                  turns: _animationController,
                  child: Text('HELLOWORLD'),
                ),
                ScaleTransition(
                  //缩放动画
                  scale: _animation,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FlutterLogo(size: 150.0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
