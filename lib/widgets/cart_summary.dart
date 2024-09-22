import 'package:flutter/material.dart';
import 'package:sera_shop/model/cart_model.dart';

class CartSummary extends StatelessWidget {
  final List<CartItem> items;

  const CartSummary({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final total = items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ${items.length} barang', 
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16  ,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'USD ${total.toStringAsFixed(2)}', 
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
            },
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Lanjut Bayar',
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 18  ,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}