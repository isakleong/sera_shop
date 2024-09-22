// CartItem model
import 'package:equatable/equatable.dart';
import 'package:sera_shop/model/product_model.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  @override
  List<Object?> get props => [product, quantity];
}