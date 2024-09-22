import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sera_shop/bloc/auth_bloc.dart';
import 'package:sera_shop/bloc/cart_bloc.dart';
import 'package:sera_shop/bloc/product_bloc.dart';
import 'package:sera_shop/model/product_model.dart';
import 'package:sera_shop/screens/cart_screen.dart';
import 'package:sera_shop/widgets/product_item.dart';
import 'package:sera_shop/widgets/product_search.dart';
import 'package:sera_shop/widgets/sera_appbar.dart';
import 'package:sera_shop/widgets/sera_textfield.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnauthenticatedState) {
          context.go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFf6fffd),
        appBar: SeraAppBar(
          title: Image.asset(
            'assets/images/logo.png',
            width: 60,
            height: 60,
          ),
          isTransparent: false,
          leading: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
              icon: Icon(
                MdiIcons.logout,
                color: Colors.black,
              )),
          actions: [
            IconButton(
              icon: Icon(
                MdiIcons.shoppingSearch,
                color: Colors.green,
              ),
              onPressed: () {
                showSearch(context: context, delegate: ProductSearchDelegate());
              },
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Badge(
                    label: Text(state.items.length.toString()),
                    child: IconButton(
                      icon: Icon(
                        MdiIcons.cartOutline, 
                        color: Colors.green,
                      ),
                      onPressed: () {
                        context.push('/cart');
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductInitialState) {
              context.read<ProductBloc>().add(FetchProductsEvent());
              return Center(
                  child: Lottie.asset("assets/animations/loading.json",
                      width: MediaQuery.of(context).size.width));
            } else if (state is ProductLoadingState) {
              return Center(
                child: Lottie.asset("assets/animations/loading.json",
                    width: MediaQuery.of(context).size.width),
              );
            } else if (state is ProductLoadedState) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return ProductItem(product: state.products[index]);
                        },
                        itemCount: state.products.length,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ProductErrorState) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
