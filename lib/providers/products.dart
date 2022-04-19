import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja/models/http_exception.dart';
import 'package:loja/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: "p1",
    //   title: "Camisa Vermelha",
    //   description: "Uma camisa vermelha - ela é bem vermelha",
    //   price: 29.99,
    //   imageUrl:
    //       "https://cdn.awsli.com.br/800x800/44/44273/produto/29989858/b28e079baa.jpg",
    // ),
    // Product(
    //   id: "p3",
    //   title: "Calça Jean",
    //   description: "Uma calça jeans - calça jeans unisex, azul, com rasgos no joelho",
    //   price: 49.99,
    //   imageUrl:
    //       "https://cdn.dondoca.com.br/wp-content/uploads/2021/11/dondoca_com_br-body-maio-detalhe-abertura-no-decote-preto-poa-com-floral-img-9323-390x390.jpg",
    // ),
    // Product(
    //   id: "p4",
    //   title: "3 pares de meias",
    //   description: "Meias nas cores preta, cinza e branca",
    //   price: 29.99,
    //   imageUrl:
    //       "https://static.netshoes.com.br/produtos/meia-cano-medio-puma-logo-c-3-pares/58/D14-7141-158/D14-7141-158_zoom1.jpg?ts=1570543225",
    // ),
    // Product(
    //   id: "p2",
    //   title: "Tênis casual",
    //   description: "Tênis preto casual confortável unisex",
    //   price: 129.99,
    //   imageUrl:
    //       "https://a-static.mlcdn.com.br/618x463/tenis-casual-masculino-portice-queen/portice/12441677517/8b2fc6c61f05881df40c9010f6778637.jpg",
    // ),
  ];

  // var _showFavoritesOnly = false;

  final String authToken;
  final String userId;

  Products(this.authToken, this._items, this.userId);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoritesItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((produto) => produto.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = true]) async {
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId': '';
    final url = Uri.parse(
        'https://loja-barao-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString"');
    final urlFav = Uri.parse(
        'https://loja-barao-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
    try {
      final response = await http.get(url).timeout(Duration(seconds: 10));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final favoriteResponse = await http.get(urlFav).timeout(Duration(seconds: 10));
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              imageUrl: prodData['imageUrl'],
              isFavorite: favoriteData == null ? false : favoriteData[prodId] ?? false),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch(error){

    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://loja-barao-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
          'creatorId': userId,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: false,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://loja-barao-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
    } else {}

    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://loja-barao-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    final response = await http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        _items.insert(existingProductIndex, existingProduct);
        throw HttpException('Ocorreu um erro durante a exclusão do produto');
      } else {
        notifyListeners();
      }
    });
  }
}
