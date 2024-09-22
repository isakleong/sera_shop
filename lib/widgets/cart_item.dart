import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sera_shop/bloc/cart_bloc.dart';
import 'package:sera_shop/model/cart_model.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

  const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Image.network(item.product.image, fit: BoxFit.contain),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title, 
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Text(
                    'USD ${item.product.price}', 
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      color: Colors.green
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    MdiIcons.minusBoxOutline, 
                    color: Colors.green,
                  ),
                  onPressed: () {
                    context.read<CartBloc>().add(DecrementQuantityEvent(item.product));
                  },
                ),
                Text('${item.quantity}'),
                IconButton(
                  icon: Icon(
                    MdiIcons.plusBoxOutline, 
                    color: Colors.green,
                  ),
                  onPressed: () {
                    context.read<CartBloc>().add(IncrementQuantityEvent(item.product));
                  },
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                MdiIcons.trashCanOutline, 
                color: Colors.green,
              ),
              onPressed: () {
                context.read<CartBloc>().add(RemoveFromCartEvent(item.product));
              },
            ),
          ],
        ),
      ),
    );
  }
}