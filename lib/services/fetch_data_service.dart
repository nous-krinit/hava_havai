import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

import '../models/product.dart';

class FetchDataService with ListenableServiceMixin {
  FetchDataService() {
    listenToReactiveValues([_cachedProducts]);
  }
  static const String apiUrl = "https://dummyjson.com/products";
  List<Product> _cachedProducts = [];

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _cachedProducts = Product.fromJsonList(data['products']);
      return _cachedProducts;
    } else {
      throw Exception("Failed to load products");
    }
  }

  List<Product> getCachedProducts() {
    Future.microtask(() => notifyListeners());
    return _cachedProducts; // Return tasks from memory
  }
}
