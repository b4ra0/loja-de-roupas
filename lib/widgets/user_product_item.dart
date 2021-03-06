import 'package:flutter/material.dart';
import 'package:loja/providers/products.dart';
import 'package:loja/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id);
            },
            icon: const Icon(Icons.edit),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () async{
              try {
                await Provider.of<Products>(context, listen: false).deleteProduct(id);
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Ocorreu um erro durante a exclusão"),
                  ),
                );
              } finally{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Produto excluído com sucesso!"),
                  ),
                );
              }
            },
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ],
      ),
    );
  }
}
