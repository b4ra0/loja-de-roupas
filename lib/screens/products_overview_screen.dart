import 'package:flutter/material.dart';
import 'package:loja/providers/product.dart';
import 'package:loja/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My shop"),
      ),
      body: ProductsGrid(),
    );
  }
}


