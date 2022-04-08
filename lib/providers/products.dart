import 'package:flutter/material.dart';
import 'package:loja/providers/product.dart';

class Products with ChangeNotifier{
  final List<Product> _items = [
    Product(
      id: "p1",
      title: "Camisa Vermelha",
      description: "A red shirt - it is pretty red",
      price: 29.99,
      imageUrl: "https://cdn.awsli.com.br/800x800/44/44273/produto/29989858/b28e079baa.jpg",
    ),
    Product(
      id: "p2",
      title: "Tênis casual",
      description: "A red shirt - it is pretty red",
      price: 129.99,
      imageUrl: "https://a-static.mlcdn.com.br/618x463/tenis-casual-masculino-portice-queen/portice/12441677517/8b2fc6c61f05881df40c9010f6778637.jpg",
    ),
    Product(
      id: "p3",
      title: "Calça Jean",
      description: "A red shirt - it is pretty red",
      price: 49.99,
      imageUrl: "https://cdn.dondoca.com.br/wp-content/uploads/2021/11/dondoca_com_br-body-maio-detalhe-abertura-no-decote-preto-poa-com-floral-img-9323-390x390.jpg",
    ),
    Product(
      id: "p4",
      title: "3 pares de meias",
      description: "A red shirt - it is pretty red",
      price: 29.99,
      imageUrl: "https://static.netshoes.com.br/produtos/meia-cano-medio-puma-logo-c-3-pares/58/D14-7141-158/D14-7141-158_zoom1.jpg?ts=1570543225",
    ),
  ];

  // var _showFavoritesOnly = false;



  List<Product> get items{
    // if (_showFavoritesOnly){
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoritesItems{
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id){
    return _items.firstWhere((produto) => produto.id == id);
  }

  // void showFavoritesOnly(){
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
  //
  // void showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(){
    // items.add(value);
    notifyListeners();
  }
}