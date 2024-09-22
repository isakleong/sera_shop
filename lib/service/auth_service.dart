import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sera_shop/model/user_model.dart';

class AuthService {
  final http.Client client;
  final String baseUrl;

  AuthService({required this.client, required this.baseUrl});

  Future<User> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw ('Email atau Password salah');
    } else {
      throw ('Gagal menghubungkan ke server, silahkan coba lagi nanti');
    }
  }
}