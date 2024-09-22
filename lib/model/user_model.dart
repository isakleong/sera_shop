import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String accessToken;
  final String refreshToken;

  const User({required this.accessToken, required this.refreshToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}