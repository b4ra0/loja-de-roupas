import 'package:flutter/material.dart';
import 'package:loja/providers/products.dart';
import 'package:loja/screens/edit_product_screen.dart';
import 'package:loja/widgets/app_drawer.dart';
import 'package:loja/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seus produtos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: "newProduct");
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (ctx, i) => UserProductItem(
            productsData.items[i].id,
            productsData.items[i].title,
            productsData.items[i].imageUrl
          ),
        ),
      ),
    );
  }
}
