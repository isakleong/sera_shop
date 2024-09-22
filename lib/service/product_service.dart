import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sera_shop/model/product_model.dart';

class ProductService {
  final http.Client client;
  final String baseUrl;

  ProductService({required this.client, required this.baseUrl});

  Future<List<Product>> getProducts() async {
    final response = await client.get(Uri.parse('$baseUrl/products'));

    print("ini response product " + response.body.toString());

    if (response.statusCode == 200) {
      List<dynamic> productsJson = jsonDecode(response.body);
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
