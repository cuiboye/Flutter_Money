import 'package:flutter/cupertino.dart';

extension ExtNum on num {
  /// 行间距
  Widget get gapRow => SizedBox(width: toDouble());

  /// 列间距
  Widget get gapColumn => SizedBox(height: toDouble());

  /// sliver横向间距
  SliverToBoxAdapter get sliverGapRow => SliverToBoxAdapter(
        child: SizedBox(width: toDouble()),
      );

  /// sliver纵向间距
  SliverToBoxAdapter get sliverGapColumn => SliverToBoxAdapter(
        child: SizedBox(height: toDouble()),
      );
}
