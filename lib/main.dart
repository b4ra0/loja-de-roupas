import 'package:flutter/material.dart';
import 'package:loja/providers/auth.dart';
import 'package:loja/providers/cart.dart';
import 'package:loja/providers/orders.dart';
import 'package:loja/providers/products.dart';
import 'package:loja/screens/auth_screen.dart';
import 'package:loja/screens/cart_screen.dart';
import 'package:loja/screens/edit_product_screen.dart';
import 'package:loja/screens/orders_screen.dart';
import 'package:loja/screens/product_detail_screen.dart';
import 'package:loja/screens/products_overview_screen.dart';
import 'package:loja/screens/user_products_screen.dart';
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
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products('', []),
          update: (_, auth, previousProducts) =>
              Products(auth.token!, previousProducts!.items),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders('', []),
          update: (ctx, auth, previousOrder) => Orders(
            auth.token!,
            previousOrder == null ? [] : previousOrder.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.yellow,
            ).copyWith(
              secondary: Colors.black,
            ),
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          debugShowCheckedModeBanner: false,
          routes: {
            ProductDetailScreen.routeName: (context) =>
                const ProductDetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
            AuthScreen.routeName: (context) => AuthScreen(),
            ProductsOverviewScreen.routeName: (context) =>
                ProductsOverviewScreen(),
          },
        ),
      ),
    );
  }
}
