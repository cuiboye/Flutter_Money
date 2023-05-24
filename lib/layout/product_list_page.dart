import 'package:flutter/material.dart';
import 'package:flutter_money/view/product_list_father_view.dart';
import 'package:flutter_money/view/product_list_view.dart';
import 'package:flutter_money/wajiu/viewmodel/wajiu_product_list_view_model.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductListViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductListFatherView(),
      ),
    );
  }
}
