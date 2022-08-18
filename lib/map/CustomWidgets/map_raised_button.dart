import 'package:flutter/material.dart';
import 'package:flutter_money/map/constants.dart';

class BMFElevatedButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;

  const BMFElevatedButton({Key? key, this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: defaultBtnBgColor,
      ),
      child: Text(
        title ?? "",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      onPressed: onPressed,
    );
  }
}

class BMFRaisedVisibleButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final bool visible;

  const BMFRaisedVisibleButton(
      {Key? key, this.title, this.onPressed, this.visible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: defaultBtnBgColor,
        ),
        child: Text(
          title ?? "",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        onPressed: onPressed,
      );
    } else {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }
}
