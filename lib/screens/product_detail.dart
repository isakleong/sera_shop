import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sera_shop/bloc/cart_bloc.dart';
import 'package:sera_shop/widgets/sera_appbar.dart';

import '../model/product_model.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SeraAppBar(
        isTransparent: false,
        title: const Text(""),
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                context.push('/cart');
              },
              icon: Icon(MdiIcons.cartOutline),
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: Hero(
                        tag: widget.product.image,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(widget.product.image),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "USD ${widget.product.price.toString()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                      fontSize: 18,
                      color: Colors.green
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
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
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  final isInCart = state.items.any((item) => item.product.id == widget.product.id);
                  return FilledButton(
                    onPressed: () {
                      context.read<CartBloc>().add(AddToCartEvent(widget.product));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          content: Text(
                            'Berhasil tambah ${widget.product.title} ke keranjang',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              fontSize: 14,
                            ),
                          ),
                          backgroundColor: Colors.teal.withOpacity(0.75),
                          duration: const Duration(seconds: 1),
                          // behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            isInCart ? 
                            'Tambah Lagi ke Keranjang' 
                            : 
                            'Tambah ke Keranjang',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Icon(MdiIcons.cartPlus)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
