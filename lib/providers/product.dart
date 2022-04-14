import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
  });

  Future<void> toggleFavoriteStatus() async {
    final url = Uri.parse(
        'https://loja-barao-default-rtdb.firebaseio.com/products/$id.json');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    isFavorite = !extractedData['isFavorite'];
    final url2 = Uri.parse(
        'https://loja-barao-default-rtdb.firebaseio.com/products/$id.json');
    await http.patch(url2, body: jsonEncode({
      'isFavorite': isFavorite,
    }));
    notifyListeners();
  }

}