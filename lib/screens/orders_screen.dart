import 'package:flutter/material.dart';
import 'package:loja/providers/orders.dart' show Orders;
import 'package:loja/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';


class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Seus pedidos"),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}
