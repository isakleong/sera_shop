import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sera_shop/model/cart_model.dart';
import 'package:sera_shop/model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<IncrementQuantityEvent>(_onIncrementQuantity);
    on<DecrementQuantityEvent>(_onDecrementQuantity);
    on<ClearCartEvent>(_onClearCart);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final updatedItems = List<CartItem>.from(state.items);
    final existingIndex = updatedItems.indexWhere((item) => item.product.id == event.product.id);

    if (existingIndex != -1) {
      updatedItems[existingIndex] = CartItem(
        product: event.product,
        quantity: updatedItems[existingIndex].quantity + 1,
      );
    } else {
      updatedItems.add(CartItem(product: event.product, quantity: 1));
    }

    emit(CartState(items: updatedItems));
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final updatedItems = List<CartItem>.from(state.items);
    updatedItems.removeWhere((item) => item.product.id == event.product.id);
    emit(CartState(items: updatedItems));
  }

  void _onIncrementQuantity(IncrementQuantityEvent event, Emitter<CartState> emit) {
    final updatedItems = state.items.map((item) {
      if (item.product.id == event.product.id) {
        return CartItem(product: item.product, quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    emit(CartState(items: updatedItems));
  }

  void _onDecrementQuantity(DecrementQuantityEvent event, Emitter<CartState> emit) {
    final updatedItems = state.items.map((item) {
      if (item.product.id == event.product.id && item.quantity > 1) {
        return CartItem(product: item.product, quantity: item.quantity - 1);
      }
      return item;
    }).toList();
    emit(CartState(items: updatedItems));
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    emit(const CartState());
  }
}
