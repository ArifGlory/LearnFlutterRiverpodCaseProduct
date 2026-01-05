import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learning_riverpod_flutter/providers.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';

class ProductListController extends Notifier<AsyncValue<List<Product>>> {
  late final ProductRepository _repo;

  @override
  AsyncValue<List<Product>> build() {
    _repo = ref.read(productRepositoryProvider);
    _loadProducts();
    return const AsyncLoading();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _repo.getProducts();
      state = AsyncData(products);
    } catch (e) {
      if (state.hasValue) {
        // keep showing cached data
      } else {
        state = AsyncError(e, StackTrace.current);
      }
    }
  }


  Future<void> refresh() async {
    state = const AsyncLoading();
    await _loadProducts();
  }

  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await _repo.addProduct(product);

      state = state.whenData((products) => [newProduct, ...products]);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }


}

final productListControllerProvider =
NotifierProvider<ProductListController, AsyncValue<List<Product>>>(
    ProductListController.new);
