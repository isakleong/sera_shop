import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sera_shop/bloc/product_bloc.dart';
import 'package:sera_shop/model/product_model.dart';
import 'package:sera_shop/screens/cart_screen.dart';
import 'package:sera_shop/screens/product_detail.dart';

class ProductSearchDelegate extends SearchDelegate<Product?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(MdiIcons.closeBox),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(MdiIcons.arrowLeft),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return renderResult(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return renderResult(context);
  }

  Widget renderResult(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    final state = productBloc.state;

    if (state is ProductLoadedState) {
      final filteredProducts = state.products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return Container(
        color: Colors.white,
        child: filteredProducts.isNotEmpty ? 
        ListView.builder(
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return ListTile(
              leading: Image.network(product.image, width: 60, height: 60),
              title: Text(
                product.title,
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                ),
              ),
              onTap: () {
                context.push('/product/${product.id}', extra: product);
              },
            );
          },
        ) : Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animations/loading.json",
                width: MediaQuery.of(context).size.width * 0.4
              ),
              const Text(
                "Maaf, belum ketemu produk yang kamu cari",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      );
    }

    return const Center(child: CircularProgressIndicator());
  }
}
