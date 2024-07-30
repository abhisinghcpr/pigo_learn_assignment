import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';


class ApiService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
