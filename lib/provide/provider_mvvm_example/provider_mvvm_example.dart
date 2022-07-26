import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_money/provide/provider_mvvm_example/view/joke_view.dart';
import 'package:path_provider/path_provider.dart';

class ProviderMvvmExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return JokeView();
  }
}