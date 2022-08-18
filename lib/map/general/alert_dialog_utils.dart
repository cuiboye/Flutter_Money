import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// 检索结果alert
void showSearchResultAlertDialog(BuildContext context, String content) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("检索结果"),
        content: Text(
          content,
          textAlign: TextAlign.start,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("我知道了"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

/// marker点击alert
void showMarkerClickAlertDialog(BuildContext context, String content) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("点击结果"),
        content: Text(
          content,
          textAlign: TextAlign.start,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("我知道了"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

/// toast
void showToast(BuildContext context, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),
        );
      }
  );
}