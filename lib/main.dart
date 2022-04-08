import 'package:flutter/material.dart';
import 'package:loja/providers/cart.dart';
import 'package:loja/providers/products.dart';
import 'package:loja/screens/cart_screen.dart';
import 'package:loja/screens/product_detail_screen.dart';
import 'package:loja/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.yellow,
          ).copyWith(
            secondary: Colors.black,
          ),
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen()
        },
      ),
    );
  }
}
