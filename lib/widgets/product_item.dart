import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sera_shop/main.dart';
import 'package:sera_shop/model/product_model.dart';
import 'package:sera_shop/screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/product/${product.id}', extra: product);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Hero(
                tag: product.image,
                child: Image.network(
                  product.image,
                  width: 90,
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16,),
            Text(
              'USD ${product.price}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}