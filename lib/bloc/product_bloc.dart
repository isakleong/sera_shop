
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera_shop/model/product_model.dart';
import 'package:sera_shop/service/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  ProductBloc({required this.productService}) : super(ProductInitialState()) {
    on<FetchProductsEvent>(_onFetchProducts);
  }

  void _onFetchProducts(FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      final products = await productService.getProducts();
      emit(ProductLoadedState(products: products));
    } catch (e) {
      emit(ProductErrorState(error: e.toString()));
    }
  }
}
