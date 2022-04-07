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
      imageUrl: "https://cdn.awsli.com.br/800x800/44/44273/produto/29989858/b28e079baa.jpg",
    ),
    Product(
      id: "p3",
      title: "Calça Jean",
      description: "A red shirt - it is pretty red",
      price: 49.99,
      imageUrl: "https://cdn.awsli.com.br/800x800/44/44273/produto/29989858/b28e079baa.jpg",
    ),
    Product(
      id: "p4",
      title: "3 pares de meias",
      description: "A red shirt - it is pretty red",
      price: 29.99,
      imageUrl: "https://cdn.awsli.com.br/800x800/44/44273/produto/29989858/b28e079baa.jpg",
    ),
  ];


  List<Product> get items{
    return [..._items];
  }

  Product findById(String id){
    return _items.firstWhere((produto) => produto.id == id);
  }

  void addProduct(){
    // items.add(value);
    notifyListeners();
  }
}