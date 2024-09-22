part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthLoadingState extends AuthState {}

class UnauthenticatedState extends AuthState {}

class AuthenticatedState extends AuthState {
  final User user;

  AuthenticatedState({required this.user});
}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState({required this.error});
}