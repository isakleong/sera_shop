part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final Product product;

  const AddToCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final Product product;

  const RemoveFromCartEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class IncrementQuantityEvent extends CartEvent {
  final Product product;
  const IncrementQuantityEvent(this.product);
  @override
  List<Object?> get props => [product];
}

class DecrementQuantityEvent extends CartEvent {
  final Product product;
  const DecrementQuantityEvent(this.product);
  @override
  List<Object?> get props => [product];
}

class ClearCartEvent extends CartEvent {
  const ClearCartEvent();
}