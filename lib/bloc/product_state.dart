part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  ProductLoadedState({required this.products});
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState({required this.error});
}
