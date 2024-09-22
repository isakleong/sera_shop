import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sera_shop/bloc/cart_bloc.dart';
import 'package:sera_shop/model/cart_model.dart';
import 'package:sera_shop/widgets/cart_item.dart';
import 'package:sera_shop/widgets/cart_summary.dart';
import 'package:sera_shop/widgets/sera_appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf6fffd),
      appBar: SeraAppBar(
        title: Image.asset(
          'assets/images/logo.png',
          width: 60,
          height: 60,
        ),
        isTransparent: false,
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.cartRemove),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Konfirmasi Hapus Keranjang",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                      fontSize: 18,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Lottie.asset(
                        "assets/animations/loading.json",
                        width: MediaQuery.of(context).size.width * 0.4
                      ),
                      const Text(
                        "Yakin ingin menghapus keranjang?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.teal, width: 1)
                            ),
                            onPressed: () => context.pop(),
                            child: const Text('Batal'),
                          ),
                        ),
                        const SizedBox(width: 16,),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              context.read<CartBloc>().add(const ClearCartEvent());
                              context.pop();
                            },
                            child: const Text('Ya, Hapus'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animations/loading.json",
                  width: MediaQuery.of(context).size.width * 0.4
                ),
                const Text(
                  "Keranjang kamu masih kosong, yuk mulai belanja!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 18,
                  ),
                ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                child: Text(
                  "Keranjang Saya",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return CartItemTile(item: item);
                  },
                ),
              ),
              CartSummary(items: state.items),
            ],
          );
        },
      ),
    );
  }
}