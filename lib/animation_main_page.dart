import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_customappbar_plugin/flutter_customappbar_plugin.dart';
import 'package:flutter_money/animated_container_page.dart';
import 'package:flutter_money/animated_opacity_page.dart';
import 'package:flutter_money/animation_widget.dart';
import 'package:flutter_money/animationbuild_example.dart';
import 'package:flutter_money/honor_demo_page.dart';
import 'package:flutter_money/layout/animatedlist.dart';
import 'package:flutter_money/transition_animation_page.dart';
import 'package:flutter_money/tween_animation_builder_page.dart';
import 'package:flutter_money/utils/get_navigation_utils.dart';
import 'package:flutter_money/view/animated_switcher.dart';
import 'package:flutter_money/widget/stagger_animation_example.dart';

import 'animation_main.dart';

///动画
class AnimationMainPage extends StatefulWidget {
  const AnimationMainPage({super.key});

  @override
  State<AnimationMainPage> createState() => _AnimationMainPageState();
}

class _AnimationMainPageState extends State<AnimationMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context: context,title: '动画',),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(AnimationBase()), child: Text('动画的基本使用')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(AnimatedWidgetExample()), child: Text('AnimatedWidget的使用')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(AnimatedBuilderExample()), child: Text('AnimatedBuilder的使用')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(StaggerAnimationExample()), child: Text('组合动画')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(AnimatedSwitcherExample()), child: Text('动画切换组件')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(HonorDemoPage()), child: Text('共性元素动画')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(AnimatedContainerPage()), child: Text('隐式动画')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(TweenAnimationBuildPage()), child: Text('TweenAnimationBuilder的使用')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(TranstionAnimationPage()), child: Text('Transtion Widget')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(AnimatedOpacityPage()), child: Text('淡入淡出动画')),
          ElevatedButton(onPressed: ()=>GetNavigationUtils.navigateRightToLeft(AnimatedListLayout()), child: Text('ListView列表动画'))
        ],
      ),
    );
  }
}
