import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../model/products_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  bool showDiscountPrice = false;
  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  ProductProvider() {
    fetchProducts();
    configureRemoteConfig();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _products = (data['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }

    _isLoading = false;
    notifyListeners();
  }

  void configureRemoteConfig() {
    var remoteConfig = FirebaseRemoteConfig.instance;
    var data = remoteConfig.getAll();
     showDiscountPrice = data['showDiscountPrice']?.asBool() ?? false;
    remoteConfig.onConfigUpdated.listen(
          (event) async {

        await remoteConfig.activate();
        showDiscountPrice = remoteConfig.getBool('showDiscountPrice') ?? false;
        notifyListeners();
      },
    );
  }
}