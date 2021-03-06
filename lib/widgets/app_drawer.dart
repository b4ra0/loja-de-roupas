import 'package:flutter/material.dart';
import 'package:loja/providers/auth.dart';
import 'package:loja/screens/auth_screen.dart';
import 'package:loja/screens/orders_screen.dart';
import 'package:loja/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Olá!"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Loja"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Pedidos"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Gerenciar produtos"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red,),
            title: const Text("Sair", style: TextStyle(color: Colors.red),),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
