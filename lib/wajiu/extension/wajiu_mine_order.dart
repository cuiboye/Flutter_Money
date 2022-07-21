import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension MineOrderExtension on Widget{
  Widget withMineOrder(String imagePath){
    return Container(
      child: Column(
        children: [
          Image.asset(imagePath,height: 20,width: 20,),
          this,
        ],
      ),
    );
  }
}