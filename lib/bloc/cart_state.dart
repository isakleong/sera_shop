part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  @override
  List<Object?> get props => [items];
}
