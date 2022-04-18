import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loja/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  String? get userId => _userId;

  bool get isAuth {
    print(token);
    return token!.length > 15;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return "Deu ruim doidão";
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(urlSegment);
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      print(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> singup(String email, String password) async {
    return _authenticate(email, password,
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCW2-nb44WJHcfq2lqUyzZkwYBpC1mPxmA");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password,
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCW2-nb44WJHcfq2lqUyzZkwYBpC1mPxmA");
  }
}
