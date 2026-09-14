import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data_convert/json_convert.dart';

class ProductApi {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> callMultipleProducts({
    int limit = 10,
    int skip = 0,
  }) async {

    final url = '$baseUrl/products?limit=$limit&skip=$skip';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final data = jsonDecode(response.body);
    final products = data['products'];

    final result = <Product>[];
    for (final item in products) {
      result.add(Product.fromJson(item));
    }
    return result;
  }

Future<List<Product>> searchProducts(
      String text) async {

    final url =
        '$baseUrl/products/search?q=$text';

    final response =
        await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to search products',
      );
    }

    final data =
        jsonDecode(response.body);

    final products =
        data['products'];

    final result = <Product>[];

    for (final item in products) {
      result.add(
        Product.fromJson(item),
      );
    }

    return result;
  }

  Future<Product> callproduct(int id) async {

    final url = '$baseUrl/products/$id';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to load product');
    }

    final data = jsonDecode(response.body);
    return Product.fromJson(data);
  }
}
